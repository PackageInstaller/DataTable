using System;
using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[DisplayName("Assets from Legacy Resources")]
public class LegacyResourcesProvider : ResourceProviderBase
{
	internal class InternalOp
	{
		private ResourceRequest m_RequestOperation;

		private ProvideHandle m_ProvideHandle;

		public void Start(ProvideHandle provideHandle)
		{
			m_ProvideHandle = provideHandle;
			provideHandle.SetProgressCallback(PercentComplete);
			provideHandle.SetWaitForCompletionCallback(WaitForCompletionHandler);
			m_RequestOperation = Resources.LoadAsync(m_ProvideHandle.ResourceManager.TransformInternalId(m_ProvideHandle.Location), m_ProvideHandle.Type);
			m_RequestOperation.completed += AsyncOperationCompleted;
		}

		private bool WaitForCompletionHandler()
		{
			if (!m_RequestOperation.isDone && Mathf.Approximately(m_RequestOperation.progress, 1f))
			{
				m_RequestOperation.completed -= AsyncOperationCompleted;
				AsyncOperationCompleted(m_RequestOperation);
				return true;
			}
			if (m_RequestOperation != null)
			{
				return m_RequestOperation.isDone;
			}
			return false;
		}

		private void AsyncOperationCompleted(AsyncOperation op)
		{
			object obj = ((op is ResourceRequest resourceRequest) ? resourceRequest.asset : null);
			obj = ((obj != null && m_ProvideHandle.Type.IsAssignableFrom(obj.GetType())) ? obj : null);
			m_ProvideHandle.Complete(obj, obj != null, (obj == null) ? new Exception($"Unable to load asset of type {m_ProvideHandle.Type} from location {m_ProvideHandle.Location}.") : null);
		}

		public float PercentComplete()
		{
			if (m_RequestOperation == null)
			{
				return 0f;
			}
			return m_RequestOperation.progress;
		}
	}

	public override void Provide(ProvideHandle pi)
	{
		Type type = pi.Type;
		bool flag = type.IsGenericType && typeof(IList<>) == type.GetGenericTypeDefinition();
		string text = pi.ResourceManager.TransformInternalId(pi.Location);
		string mainKey;
		string subKey;
		if (type.IsArray | flag)
		{
			object obj = null;
			obj = ((!type.IsArray) ? ResourceManagerConfig.CreateListResult(type, Resources.LoadAll(text, type.GetGenericArguments()[0])) : ResourceManagerConfig.CreateArrayResult(type, Resources.LoadAll(text, type.GetElementType())));
			pi.Complete(obj, obj != null, (obj == null) ? new Exception($"Unable to load asset of type {pi.Type} from location {pi.Location}.") : null);
		}
		else if (ResourceManagerConfig.ExtractKeyAndSubKey(text, out mainKey, out subKey))
		{
			Object[] array = Resources.LoadAll(mainKey, pi.Type);
			object obj2 = null;
			Object[] array2 = array;
			foreach (Object obj3 in array2)
			{
				if (obj3.name == subKey && pi.Type.IsAssignableFrom(obj3.GetType()))
				{
					obj2 = obj3;
					break;
				}
			}
			pi.Complete(obj2, obj2 != null, (obj2 == null) ? new Exception($"Unable to load asset of type {pi.Type} from location {pi.Location}.") : null);
		}
		else
		{
			new InternalOp().Start(pi);
		}
	}

	public override void Release(IResourceLocation location, object asset)
	{
		if (location == null)
		{
			throw new ArgumentNullException("location");
		}
		Object obj = asset as Object;
		if (obj != null && !(obj is GameObject))
		{
			Resources.UnloadAsset(obj);
		}
	}
}
