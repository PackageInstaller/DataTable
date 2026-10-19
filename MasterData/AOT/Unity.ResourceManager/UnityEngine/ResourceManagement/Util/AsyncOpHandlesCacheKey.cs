using System;
using System.Collections.Generic;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.ResourceManagement.Util;

internal sealed class AsyncOpHandlesCacheKey : IOperationCacheKey, IEquatable<IOperationCacheKey>
{
	private readonly HashSet<AsyncOperationHandle> m_Handles;

	public AsyncOpHandlesCacheKey(IList<AsyncOperationHandle> handles)
	{
		m_Handles = new HashSet<AsyncOperationHandle>(handles);
	}

	public override int GetHashCode()
	{
		return m_Handles.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as AsyncOpHandlesCacheKey);
	}

	public bool Equals(IOperationCacheKey other)
	{
		return Equals(other as AsyncOpHandlesCacheKey);
	}

	private bool Equals(AsyncOpHandlesCacheKey other)
	{
		if (this == other)
		{
			return true;
		}
		if (other == null)
		{
			return false;
		}
		return m_Handles.SetEquals(other.m_Handles);
	}
}
