using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[UsedByNativeCode]
public struct BoneWeight1 : IEquatable<BoneWeight1>
{
	[SerializeField]
	private float m_Weight;

	[SerializeField]
	private int m_BoneIndex;

	public float weight => m_Weight;

	public int boneIndex => m_BoneIndex;

	public override bool Equals(object other)
	{
		return other is BoneWeight1 && Equals((BoneWeight1)other);
	}

	public bool Equals(BoneWeight1 other)
	{
		return boneIndex.Equals(other.boneIndex) && weight.Equals(other.weight);
	}

	public override int GetHashCode()
	{
		return boneIndex.GetHashCode() ^ weight.GetHashCode();
	}
}
