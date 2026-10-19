using System;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.ResourceProviders;

public abstract class ResourceProviderBase : IResourceProvider, IInitializableObject
{
	private class BaseInitAsyncOp : AsyncOperationBase<bool>
	{
		private Func<bool> m_CallBack;

		public void Init(Func<bool> callback)
		{
			m_CallBack = callback;
		}

		protected override bool InvokeWaitForCompletion()
		{
			m_RM?.Update(Time.unscaledDeltaTime);
			if (!HasExecuted)
			{
				InvokeExecute();
			}
			return true;
		}

		protected override void Execute()
		{
			if (m_CallBack != null)
			{
				Complete(m_CallBack(), success: true, "");
			}
			else
			{
				Complete(result: true, success: true, "");
			}
		}
	}

	protected string m_ProviderId;

	protected ProviderBehaviourFlags m_BehaviourFlags;

	public virtual string ProviderId
	{
		get
		{
			if (string.IsNullOrEmpty(m_ProviderId))
			{
				m_ProviderId = GetType().FullName;
			}
			return m_ProviderId;
		}
	}

	ProviderBehaviourFlags IResourceProvider.BehaviourFlags => m_BehaviourFlags;

	public virtual bool Initialize(string id, string data)
	{
		m_ProviderId = id;
		return !string.IsNullOrEmpty(m_ProviderId);
	}

	public virtual bool CanProvide(Type t, IResourceLocation location)
	{
		return GetDefaultType(location).IsAssignableFrom(t);
	}

	public override string ToString()
	{
		return ProviderId;
	}

	public virtual void Release(IResourceLocation location, object obj)
	{
	}

	public virtual Type GetDefaultType(IResourceLocation location)
	{
		return typeof(object);
	}

	public abstract void Provide(ProvideHandle provideHandle);

	public virtual AsyncOperationHandle<bool> InitializeAsync(ResourceManager rm, string id, string data)
	{
		BaseInitAsyncOp baseInitAsyncOp = new BaseInitAsyncOp();
		baseInitAsyncOp.Init(() => Initialize(id, data));
		return rm.StartOperation(baseInitAsyncOp, default);
	}
}
