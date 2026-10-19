using System;

namespace UnityEngine.ResourceManagement.Util;

internal sealed class IdCacheKey : IOperationCacheKey, IEquatable<IOperationCacheKey>
{
	public string ID;

	public Type locationType;

	public IdCacheKey(Type locType, string id)
	{
		ID = id;
		locationType = locType;
	}

	private bool Equals(IdCacheKey other)
	{
		if (this == other)
		{
			return true;
		}
		if (other == null)
		{
			return false;
		}
		if (other.ID == ID)
		{
			return locationType == other.locationType;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (527 + ID.GetHashCode()) * 31 + locationType.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as IdCacheKey);
	}

	public bool Equals(IOperationCacheKey other)
	{
		return Equals(other as IdCacheKey);
	}
}
