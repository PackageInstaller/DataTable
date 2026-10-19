using System;
using System.ComponentModel;
using System.IO;
using UnityEngine.Networking;
using UnityEngine.ResourceManagement.Exceptions;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[DisplayName("Binary Data Provider")]
internal class BinaryDataProvider : ResourceProviderBase
{
	internal class InternalOp
	{
		private BinaryDataProvider m_Provider;

		private UnityWebRequestAsyncOperation m_RequestOperation;

		private WebRequestQueueOperation m_RequestQueueOperation;

		private ProvideHandle m_PI;

		private bool m_IgnoreFailures;

		private bool m_Complete;

		private int m_Timeout;

		private float GetPercentComplete()
		{
			if (m_RequestOperation == null)
			{
				return 0f;
			}
			return m_RequestOperation.progress;
		}

		public void Start(ProvideHandle provideHandle, BinaryDataProvider rawProvider)
		{
			m_PI = provideHandle;
			m_PI.SetWaitForCompletionCallback(WaitForCompletionHandler);
			provideHandle.SetProgressCallback(GetPercentComplete);
			m_Provider = rawProvider;
			if (m_PI.Location.Data is ProviderLoadRequestOptions providerLoadRequestOptions)
			{
				m_IgnoreFailures = providerLoadRequestOptions.IgnoreFailures;
				m_Timeout = providerLoadRequestOptions.WebRequestTimeout;
			}
			else
			{
				m_IgnoreFailures = rawProvider.IgnoreFailures;
				m_Timeout = 0;
			}
			string text = m_PI.ResourceManager.TransformInternalId(m_PI.Location);
			if (ResourceManagerConfig.ShouldPathUseWebRequest(text))
			{
				SendWebRequest(text);
			}
			else if (File.Exists(text))
			{
				if (text.Length >= 260)
				{
					text = "\\\\?\\" + text;
				}
				if (text.EndsWith(".json"))
				{
					throw new Exception("Trying to read non binary data at path '" + text + "'.");
				}
				byte[] data = File.ReadAllBytes(text);
				object obj = ConvertBytes(data);
				m_PI.Complete(obj, obj != null, (obj == null) ? new Exception($"Unable to load asset of type {m_PI.Type} from location {m_PI.Location}.") : null);
				m_Complete = true;
			}
			else
			{
				Exception exception = null;
				if (m_IgnoreFailures)
				{
					m_PI.Complete<object>(null, status: true, exception);
					m_Complete = true;
				}
				else
				{
					exception = new Exception($"Invalid path in TextDataProvider : '{text}'.");
					m_PI.Complete<object>(null, status: false, exception);
					m_Complete = true;
				}
			}
		}

		private bool WaitForCompletionHandler()
		{
			if (m_Complete)
			{
				return true;
			}
			if (m_RequestOperation != null)
			{
				if (m_RequestOperation.isDone && !m_Complete)
				{
					RequestOperation_completed(m_RequestOperation);
				}
				else if (!m_RequestOperation.isDone)
				{
					return false;
				}
			}
			return m_Complete;
		}

		private void RequestOperation_completed(AsyncOperation op)
		{
			if (m_Complete)
			{
				return;
			}
			UnityWebRequestAsyncOperation unityWebRequestAsyncOperation = op as UnityWebRequestAsyncOperation;
			byte[] data = null;
			Exception exception = null;
			if (unityWebRequestAsyncOperation != null)
			{
				UnityWebRequest webRequest = unityWebRequestAsyncOperation.webRequest;
				if (!UnityWebRequestUtilities.RequestHasErrors(webRequest, out var result))
				{
					data = webRequest.downloadHandler.data;
				}
				else
				{
					exception = new RemoteProviderException("TextDataProvider : unable to load from url : " + webRequest.url, m_PI.Location, result);
				}
				webRequest.Dispose();
			}
			else
			{
				exception = new RemoteProviderException("TextDataProvider unable to load from unknown url", m_PI.Location);
			}
			CompleteOperation(data, exception);
		}

		protected void CompleteOperation(byte[] data, Exception exception)
		{
			object obj = null;
			if (data != null && data.Length != 0)
			{
				obj = ConvertBytes(data);
			}
			m_PI.Complete(obj, obj != null || m_IgnoreFailures, exception);
			m_Complete = true;
		}

		private object ConvertBytes(byte[] data)
		{
			try
			{
				return m_Provider.Convert(m_PI.Type, data);
			}
			catch (Exception exception)
			{
				if (!m_IgnoreFailures)
				{
					Debug.LogException(exception);
				}
				return null;
			}
		}

		protected virtual void SendWebRequest(string path)
		{
			UnityWebRequest unityWebRequest = new UnityWebRequest(path, "GET", new DownloadHandlerBuffer(), null);
			if (m_Timeout > 0)
			{
				unityWebRequest.timeout = m_Timeout;
			}
			m_PI.ResourceManager.WebRequestOverride?.Invoke(unityWebRequest);
			m_RequestQueueOperation = WebRequestQueue.QueueRequest(unityWebRequest);
			if (m_RequestQueueOperation.IsDone)
			{
				m_RequestOperation = m_RequestQueueOperation.Result;
				if (m_RequestOperation.isDone)
				{
					RequestOperation_completed(m_RequestOperation);
				}
				else
				{
					m_RequestOperation.completed += RequestOperation_completed;
				}
			}
			else
			{
				WebRequestQueueOperation requestQueueOperation = m_RequestQueueOperation;
				requestQueueOperation.OnComplete = (Action<UnityWebRequestAsyncOperation>)Delegate.Combine(requestQueueOperation.OnComplete, (Action<UnityWebRequestAsyncOperation>)((UnityWebRequestAsyncOperation asyncOperation) =>
				{
					m_RequestOperation = asyncOperation;
					m_RequestOperation.completed += RequestOperation_completed;
				}));
			}
		}
	}

	public bool IgnoreFailures { get; set; }

	public virtual object Convert(Type type, byte[] data)
	{
		return data;
	}

	public override void Provide(ProvideHandle provideHandle)
	{
		new InternalOp().Start(provideHandle, this);
	}
}
