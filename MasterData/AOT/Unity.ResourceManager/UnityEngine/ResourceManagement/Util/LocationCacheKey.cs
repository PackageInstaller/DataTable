using System;
using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.Util;

internal sealed class LocationCacheKey : IOperationCacheKey, IEquatable<IOperationCacheKey>
{
	private readonly IResourceLocation m_Location;

	private readonly Type m_DesiredType;

	public LocationCacheKey(IResourceLocation location, Type desiredType)
	{
		if (location == null)
		{
			throw new NullReferenceException("Resource location cannot be null.");
		}
		if (desiredType == null)
		{
			throw new NullReferenceException("Desired type cannot be null.");
		}
		m_Location = location;
		m_DesiredType = desiredType;
	}

	public override int GetHashCode()
	{
		return m_Location.Hash(m_DesiredType);
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as LocationCacheKey);
	}

	public bool Equals(IOperationCacheKey other)
	{
		return Equals(other as LocationCacheKey);
	}

	private bool Equals(LocationCacheKey other)
	{
		if (this == other)
		{
			return true;
		}
		if (other == null)
		{
			return false;
		}
		if (LocationUtils.LocationEquals(m_Location, other.m_Location))
		{
			return object.Equals(m_DesiredType, other.m_DesiredType);
		}
		return false;
	}
}
