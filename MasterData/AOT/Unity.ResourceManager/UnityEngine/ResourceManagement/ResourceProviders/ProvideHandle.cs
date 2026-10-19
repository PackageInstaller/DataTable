using System;
using System.Collections.Generic;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.ResourceProviders;

public struct ProvideHandle
{
	private int m_Version;

	private IGenericProviderOperation m_InternalOp;

	private ResourceManager m_ResourceManager;

	internal bool IsValid
	{
		get
		{
			if (m_InternalOp != null)
			{
				return m_InternalOp.ProvideHandleVersion == m_Version;
			}
			return false;
		}
	}

	internal IGenericProviderOperation InternalOp
	{
		get
		{
			if (m_InternalOp.ProvideHandleVersion != m_Version)
			{
				throw new Exception("The ProvideHandle is invalid. After the handle has been completed, it can no longer be used");
			}
			return m_InternalOp;
		}
	}

	public ResourceManager ResourceManager => m_ResourceManager;

	public Type Type => InternalOp.RequestedType;

	public IResourceLocation Location => InternalOp.Location;

	public int DependencyCount => InternalOp.DependencyCount;

	internal ProvideHandle(ResourceManager rm, IGenericProviderOperation op)
	{
		m_ResourceManager = rm;
		m_InternalOp = op;
		m_Version = op.ProvideHandleVersion;
	}

	public TDepObject GetDependency<TDepObject>(int index)
	{
		return InternalOp.GetDependency<TDepObject>(index);
	}

	public void GetDependencies(IList<object> list)
	{
		InternalOp.GetDependencies(list);
	}

	public void SetProgressCallback(Func<float> callback)
	{
		InternalOp.SetProgressCallback(callback);
	}

	public void SetDownloadProgressCallbacks(Func<DownloadStatus> callback)
	{
		InternalOp.SetDownloadProgressCallback(callback);
	}

	public void SetWaitForCompletionCallback(Func<bool> callback)
	{
		InternalOp.SetWaitForCompletionCallback(callback);
	}

	public void Complete<T>(T result, bool status, Exception exception)
	{
		InternalOp.ProviderCompleted(result, status, exception);
	}
}
