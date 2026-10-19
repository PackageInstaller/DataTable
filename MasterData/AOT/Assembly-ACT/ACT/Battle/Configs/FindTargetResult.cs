using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public struct FindTargetResult : IEquatable<FindTargetResult>
{
	[Flags]
	public enum TargetSourceType
	{
		Script = 1,
		Bodypart = 2,
		MonoEntity = 4,
		Damageable = 8,
		All = Script | Bodypart | MonoEntity | Damageable
	}

	private byte m_BodyIndex;

	private TargetSourceType m_TargetSourceType;

	private float m_SqrDis;

	private Vector3 m_TouchPos;

	private Vector3 m_TouchForward;

	public byte bodyIndex => m_BodyIndex;

	public byte BodyPriority
	{
		get
		{
			if (bodyIndex != 0)
			{
				return entity.GetMono().bodyParts[bodyIndex - 1].priority;
			}
			return 0;
		}
	}

	public bool IsParryOnlyBodyPart
	{
		get
		{
			if (m_TargetSourceType != TargetSourceType.Bodypart || m_BodyIndex == 0 || !entity.IsValid)
			{
				return false;
			}
			MonoEntity mono = entity.GetMono();
			int num = m_BodyIndex - 1;
			if (mono == null || mono.bodyParts == null || num >= mono.bodyParts.Length)
			{
				return false;
			}
			MonoBodyPart monoBodyPart = mono.bodyParts[num];
			if (monoBodyPart != null)
			{
				return monoBodyPart.parryOnly;
			}
			return false;
		}
	}

	public Vector3 SourcePosition => m_TargetSourceType switch
	{
		TargetSourceType.Script => entity.GetCompTransform().physicsPosition, 
		TargetSourceType.Bodypart => entity.GetMono().bodyParts[bodyIndex - 1].transform.position, 
		TargetSourceType.MonoEntity => entity.GetCompTransform().physicsPosition, 
		TargetSourceType.Damageable => damageable.transform.position, 
		_ => throw new ArgumentOutOfRangeException(), 
	};

	public TargetSourceType targetSourceType => m_TargetSourceType;

	public float sqrDis => m_SqrDis;

	public Damageable damageable { get; private set; }

	public Entity entity { get; set; }

	public Vector3 TouchPos => m_TouchPos;

	public Vector3 TouchForward => m_TouchForward;

	public Collider Collider { get; private set; }

	public bool IsValid
	{
		get
		{
			if (m_TargetSourceType == TargetSourceType.Damageable)
			{
				return damageable != null;
			}
			return entity.IsValid;
		}
	}

	public static FindTargetResult EntityOnly(Entity entity)
	{
		return new FindTargetResult
		{
			entity = entity,
			m_TargetSourceType = TargetSourceType.Script
		};
	}

	public static FindTargetResult BodyPart(Entity entity, byte bodyIndex, float sqrDis, Vector3 touchPos, Vector3 touchForward, Collider collider = null)
	{
		return new FindTargetResult
		{
			entity = entity,
			m_BodyIndex = bodyIndex,
			m_SqrDis = sqrDis,
			m_TargetSourceType = TargetSourceType.Bodypart,
			m_TouchPos = touchPos,
			m_TouchForward = touchForward,
			Collider = collider
		};
	}

	public static FindTargetResult MonoEntity(Entity entity, float sqrDis, Vector3 touchPos, Vector3 touchForward, Collider collider = null)
	{
		return new FindTargetResult
		{
			entity = entity,
			m_SqrDis = sqrDis,
			m_TargetSourceType = TargetSourceType.MonoEntity,
			m_TouchPos = touchPos,
			m_TouchForward = touchForward,
			Collider = collider
		};
	}

	public static FindTargetResult Damageable(Damageable damageable, float sqrDis, Vector3 touchPos, Collider collider = null)
	{
		return new FindTargetResult
		{
			damageable = damageable,
			m_SqrDis = sqrDis,
			m_TargetSourceType = TargetSourceType.Damageable,
			m_TouchPos = touchPos,
			m_TouchForward = Vector3.zero,
			Collider = collider
		};
	}

	public bool Equals(FindTargetResult other)
	{
		if (other.entity == entity)
		{
			return damageable == other.damageable;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return entity.Id.GetHashCode();
	}
}
