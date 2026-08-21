using System;
using GameFramework.WebRequest;
using UnityEngine.Networking;

namespace GameFramework.Runtime;

public class UnityWebRequestAgentHelper : WebRequestAgentHelperBase, IDisposable
{
	private UnityWebRequest m_UnityWebRequest = null;

	private bool m_Disposed = false;

	private EventHandler<WebRequestAgentHelperCompleteEventArgs> m_WebRequestAgentHelperCompleteEventHandler = null;

	private EventHandler<WebRequestAgentHelperErrorEventArgs> m_WebRequestAgentHelperErrorEventHandler = null;

	public override event EventHandler<WebRequestAgentHelperCompleteEventArgs> WebRequestAgentHelperComplete
	{
		add
		{
			m_WebRequestAgentHelperCompleteEventHandler = (EventHandler<WebRequestAgentHelperCompleteEventArgs>)Delegate.Combine(m_WebRequestAgentHelperCompleteEventHandler, value);
		}
		remove
		{
			m_WebRequestAgentHelperCompleteEventHandler = (EventHandler<WebRequestAgentHelperCompleteEventArgs>)Delegate.Remove(m_WebRequestAgentHelperCompleteEventHandler, value);
		}
	}

	public override event EventHandler<WebRequestAgentHelperErrorEventArgs> WebRequestAgentHelperError
	{
		add
		{
			m_WebRequestAgentHelperErrorEventHandler = (EventHandler<WebRequestAgentHelperErrorEventArgs>)Delegate.Combine(m_WebRequestAgentHelperErrorEventHandler, value);
		}
		remove
		{
			m_WebRequestAgentHelperErrorEventHandler = (EventHandler<WebRequestAgentHelperErrorEventArgs>)Delegate.Remove(m_WebRequestAgentHelperErrorEventHandler, value);
		}
	}

	public override void Request(string webRequestUri, object userData)
	{
		WWWFormInfo wWWFormInfo = (WWWFormInfo)userData;
		if (wWWFormInfo.WWWForm == null)
		{
			m_UnityWebRequest = UnityWebRequest.Get(webRequestUri);
		}
		else
		{
			m_UnityWebRequest = UnityWebRequest.Post(webRequestUri, wWWFormInfo.WWWForm);
		}
		m_UnityWebRequest.SendWebRequest();
	}

	public override void Request(string webRequestUri, byte[] postData, object userData)
	{
		m_UnityWebRequest = UnityWebRequest.Post(webRequestUri, Utility.Converter.GetString(postData));
		m_UnityWebRequest.SendWebRequest();
	}

	public override void Request(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Expected O, but got Unknown
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Expected O, but got Unknown
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Expected O, but got Unknown
		m_UnityWebRequest = new UnityWebRequest(webRequestUri, "POST");
		m_UnityWebRequest.uploadHandler = (UploadHandler)new UploadHandlerRaw(postData);
		m_UnityWebRequest.downloadHandler = (DownloadHandler)new DownloadHandlerBuffer();
		m_UnityWebRequest.SetRequestHeader(headerName, headerValue);
		m_UnityWebRequest.SendWebRequest();
	}

	public override void Reset()
	{
		if (m_UnityWebRequest != null)
		{
			m_UnityWebRequest.Dispose();
			m_UnityWebRequest = null;
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!m_Disposed)
		{
			if (disposing && m_UnityWebRequest != null)
			{
				m_UnityWebRequest.Dispose();
				m_UnityWebRequest = null;
			}
			m_Disposed = true;
		}
	}

	private void Update()
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Invalid comparison between Unknown and I4
		if (m_UnityWebRequest != null && m_UnityWebRequest.isDone)
		{
			if ((int)m_UnityWebRequest.result != 1)
			{
				WebRequestAgentHelperErrorEventArgs e = WebRequestAgentHelperErrorEventArgs.Create(m_UnityWebRequest.error);
				m_WebRequestAgentHelperErrorEventHandler(this, e);
				ReferencePool.Release(e);
			}
			else if (m_UnityWebRequest.downloadHandler.isDone)
			{
				WebRequestAgentHelperCompleteEventArgs e2 = WebRequestAgentHelperCompleteEventArgs.Create(m_UnityWebRequest.downloadHandler.data);
				m_WebRequestAgentHelperCompleteEventHandler(this, e2);
				ReferencePool.Release(e2);
			}
		}
	}
}
