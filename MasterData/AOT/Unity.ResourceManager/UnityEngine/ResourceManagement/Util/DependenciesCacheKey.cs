using System;
using System.Collections.Generic;
using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.Util;

internal sealed class DependenciesCacheKey : IOperationCacheKey, IEquatable<IOperationCacheKey>
{
	private readonly IList<IResourceLocation> m_Dependencies;

	private readonly int m_DependenciesHash;

	public DependenciesCacheKey(IList<IResourceLocation> dependencies, int dependenciesHash)
	{
		m_Dependencies = dependencies;
		m_DependenciesHash = dependenciesHash;
	}

	public override int GetHashCode()
	{
		return m_DependenciesHash;
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as DependenciesCacheKey);
	}

	public bool Equals(IOperationCacheKey other)
	{
		return Equals(other as DependenciesCacheKey);
	}

	private bool Equals(DependenciesCacheKey other)
	{
		if (this == other)
		{
			return true;
		}
		if (other == null)
		{
			return false;
		}
		return LocationUtils.DependenciesEqual(m_Dependencies, other.m_Dependencies);
	}
}
