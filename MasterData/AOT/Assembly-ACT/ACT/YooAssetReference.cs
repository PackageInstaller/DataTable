using System;
using Bamboo.AssetField;
using UnityEngine;
using YooAsset;

namespace ACT;

[Serializable]
public class YooAssetReference : AssetID
{
	[SerializeField]
	private string _guid;

	private static ResourcePackage _package;

	public string GUID => _guid;

	public YooAssetReference()
	{
	}

	public YooAssetReference(string guid)
	{
		_guid = guid;
	}

	public bool IsValid()
	{
		return this.RuntimeKeyIsValid();
	}

	public static bool operator ==(YooAssetReference left, YooAssetReference right)
	{
		return left?.Equals(right) ?? ((object)right == null);
	}

	public static bool operator !=(YooAssetReference left, YooAssetReference right)
	{
		return !(left == right);
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (this == obj)
		{
			return true;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		return Equals((YooAssetReference)obj);
	}

	public bool Equals(YooAssetReference other)
	{
		if ((object)other == null)
		{
			return false;
		}
		return string.Equals(_guid, other._guid, StringComparison.Ordinal);
	}

	public override int GetHashCode()
	{
		if (_guid == null)
		{
			return 0;
		}
		return _guid.GetHashCode();
	}
}
[Serializable]
public class YooAssetReference<T> : YooAssetReference where T : UnityEngine.Object
{
	public YooAssetReference(string guid)
		: base(guid)
	{
	}
}
