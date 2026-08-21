using System;

namespace Ase.ECS;

public struct FrameCollisionData : IEquatable<FrameCollisionData>
{
	private static uint s_SN;

	public uint sn;

	public BaseEntity _entity;

	public float _lastImpact;

	public float _interval;

	public void Clear()
	{
		_entity = null;
	}

	public readonly uint GetSN()
	{
		if (s_SN >= 4294967279u)
		{
			s_SN = 1u;
		}
		return s_SN++;
	}

	public readonly bool Equals(FrameCollisionData obj)
	{
		return sn == obj.sn;
	}
}
