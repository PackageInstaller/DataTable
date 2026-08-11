using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class LogicEntityCollisionComponent : ColllisionComponent
{
	private DREntityCollision _entityCollision;

	public float GetColliderNearestDistance(BaseLogicCollider target)
	{
		if (target == null || LogicBodyCollider == null)
		{
			return 0f;
		}
		float num = float.MaxValue;
		if (LogicOtherCollider != null)
		{
			for (int i = 0; i < LogicOtherCollider.Count; i++)
			{
				BaseLogicCollider baseLogicCollider = LogicOtherCollider[i];
				if (baseLogicCollider != null)
				{
					float num2 = CalcStrict3DDistance(baseLogicCollider, target);
					if (num2 < num)
					{
						num = num2;
					}
					if (num <= 0f)
					{
						return 0f;
					}
				}
			}
		}
		float num3 = CalcStrict3DDistance(LogicBodyCollider, target);
		if (num3 < num)
		{
			num = num3;
		}
		return Mathf.Max(0f, num);
	}

	private static float CalcStrict3DDistance(BaseLogicCollider a, BaseLogicCollider b)
	{
		Vector3 centerWorldPosition = a.GetCenterWorldPosition();
		Vector3 centerWorldPosition2 = b.GetCenterWorldPosition();
		float num = ((a is LogicCapsuleCollider logicCapsuleCollider) ? (logicCapsuleCollider.Height * 0.5f) : a.Radius);
		float num2 = ((b is LogicCapsuleCollider logicCapsuleCollider2) ? (logicCapsuleCollider2.Height * 0.5f) : b.Radius);
		float num3 = centerWorldPosition.y - num;
		float num4 = centerWorldPosition.y + num;
		float num5 = centerWorldPosition2.y - num2;
		float num6 = centerWorldPosition2.y + num2;
		float num7;
		bool flag;
		if (num4 < num5)
		{
			num7 = num5 - num4;
			flag = false;
		}
		else if (num6 < num3)
		{
			num7 = num3 - num6;
			flag = false;
		}
		else
		{
			num7 = 0f;
			flag = true;
		}
		Vector2 a2 = new Vector2(centerWorldPosition.x, centerWorldPosition.z);
		Vector2 b2 = new Vector2(centerWorldPosition2.x, centerWorldPosition2.z);
		float num8 = Vector2.Distance(a2, b2);
		float num9 = a.Radius + b.Radius;
		float num10 = Mathf.Max(0f, num8 - num9);
		if (flag && num10 <= 0f)
		{
			return 0f;
		}
		if (flag)
		{
			return num10;
		}
		if (num10 <= 0f)
		{
			return num7;
		}
		return Mathf.Sqrt(num7 * num7 + num10 * num10);
	}

	protected override void InitCollisionData()
	{
		_entityCollision = GetData<DREntityCollision>("CollisionData");
	}

	protected override CapsuleCollider InitBodyCollision()
	{
		if (_entityCollision == null)
		{
			return null;
		}
		if (_entityCollision.OtherCapsuleCenter.Count != _entityCollision.OtherCapsuleHeight.Count)
		{
			return null;
		}
		if (_entityCollision.OtherSphereRadius.Count != _entityCollision.OtherSphereHeight.Count)
		{
			return null;
		}
		CapsuleCollider orAddComponent = PhysicsGo.GetOrAddComponent<CapsuleCollider>();
		orAddComponent.center = _entityCollision.BobyCenter.ToVector3();
		orAddComponent.radius = _entityCollision.BobyRadius;
		orAddComponent.height = _entityCollision.BobyHeight;
		((Collider)orAddComponent).enabled = true;
		LogicBodyCollider = new LogicCapsuleCollider();
		LogicBodyCollider.CenterOffset = _entityCollision.BobyCenter.ToVector3();
		LogicBodyCollider.Radius = _entityCollision.BobyRadius;
		LogicBodyCollider.Height = _entityCollision.BobyHeight;
		LogicBodyCollider.BaseEntity = mBaseEntity;
		return orAddComponent;
	}

	protected override void InitOtherCollision(EntityCollisionLayer collisionLayer)
	{
		if (_entityCollision != null)
		{
			for (int i = 0; i < _entityCollision.OtherCapsuleCenter.Count; i++)
			{
				List<float> list = _entityCollision.OtherCapsuleCenter[i];
				float height = _entityCollision.OtherCapsuleHeight[i];
				float radius = _entityCollision.OtherCapsuleRadius[i];
				CapsuleCollider val = PhysicsGo.AddComponent<CapsuleCollider>();
				val.center = list.ToVector3();
				val.radius = radius;
				val.height = height;
				((Collider)val).enabled = true;
				collisionLayer.others.Add((Collider)(object)val);
				BaseLogicCollider baseLogicCollider = new LogicCapsuleCollider();
				baseLogicCollider.CenterOffset = list.ToVector3();
				baseLogicCollider.Height = height;
				baseLogicCollider.Radius = radius;
				baseLogicCollider.BaseEntity = mBaseEntity;
				LogicOtherCollider.Add(baseLogicCollider);
			}
			for (int j = 0; j < _entityCollision.OtherSphereHeight.Count; j++)
			{
				List<float> list2 = _entityCollision.OtherSphereHeight[j];
				float radius2 = _entityCollision.OtherSphereRadius[j];
				SphereCollider val2 = PhysicsGo.AddComponent<SphereCollider>();
				val2.center = list2.ToVector3();
				val2.radius = radius2;
				((Collider)val2).enabled = true;
				collisionLayer.others.Add((Collider)(object)val2);
				BaseLogicCollider baseLogicCollider2 = new LogicSphereCollider();
				baseLogicCollider2.CenterOffset = list2.ToVector3();
				baseLogicCollider2.Radius = radius2;
				baseLogicCollider2.BaseEntity = mBaseEntity;
				LogicOtherCollider.Add(baseLogicCollider2);
			}
		}
	}
}
