using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using Sirenix.Utilities;
using UnityEngine;

namespace Ase.Paradox;

[Name("矫正攻击时英雄位置", 0)]
[Description("当英雄在攻击时，如果与其他碰撞器重叠，则进行位置矫正，使其保持与其他碰撞器的最小距离。")]
[Category("✫ DragonLost/Transform")]
public class ModifyAttackDistanceAction : ActionTaskBase
{
	[Name("矫正距离", 0)]
	[Description("攻击后，英雄与其他碰撞器之间的最小距离。")]
	public BBParameter<float> minDistanceInput = new BBParameter<float>();

	private float minDistance;

	protected override void OnExecute()
	{
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		base.OnExecute();
		if (ownerEntity == null)
		{
			OnActionFinish();
			return;
		}
		if (minDistanceInput == null)
		{
			minDistance = 0f;
		}
		else
		{
			minDistance = minDistanceInput.value;
		}
		Collider[] array = (Collider[])(object)new Collider[16];
		PhysicsScene physicsScene = GetOwnerEntity().GetWorld().GetPhysicsScene();
		if (((PhysicsScene)(ref physicsScene)).OverlapSphere(GetOwnerEntity().transform.position, minDistance, array, -1, (QueryTriggerInteraction)1) > 0)
		{
			array.Sort(CompareColliders);
			if (TryGetNearestHitPonit(array, out var nearestCollider))
			{
				float num = Vector3.Distance(GetOwnerEntity().transform.position, nearestCollider.bounds.center) - GetRadius(nearestCollider);
				if (num < minDistance)
				{
					Vector3 rhs = GetOwnerEntity().transform.position - nearestCollider.bounds.center;
					rhs.y = 0f;
					if (Vector3.Dot(GetOwnerEntity().GetComponent<KinematicMoveComponent>().GetCurrentMoveDir(), rhs) > 0f)
					{
						OnActionFinish();
						return;
					}
					float num2 = minDistance - num;
					Vector3 position = GetOwnerEntity().transform.position + rhs.normalized * num2;
					GetOwnerEntity().GetComponent<KinematicMoveComponent>().SetPosition(position, "攻击后退矫正");
				}
			}
		}
		OnActionFinish();
	}

	private float GetRadius(Collider collider)
	{
		SphereCollider val = (SphereCollider)(object)((collider is SphereCollider) ? collider : null);
		if (val != null)
		{
			return val.radius;
		}
		CapsuleCollider val2 = (CapsuleCollider)(object)((collider is CapsuleCollider) ? collider : null);
		if (val2 != null)
		{
			return val2.radius;
		}
		return 0f;
	}

	private bool IsVaildCollider(Collider collider)
	{
		if ((Object)(object)collider == null || collider.isTrigger)
		{
			return false;
		}
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			return false;
		}
		return GetOwnerEntity().GetComponent<KinematicMoveComponent>().IsColliderValidForCollisions(collider);
	}

	private bool TryGetNearestHitPonit(Collider[] colliders, out Collider nearestCollider)
	{
		float num = float.MaxValue;
		nearestCollider = null;
		for (int i = 0; i < colliders.Length; i++)
		{
			if (!IsVaildCollider(colliders[i]))
			{
				continue;
			}
			((Component)(object)colliders[i]).gameObject.TryGetComponent<MonsterView>(out var component);
			if (component != null && component.Entity != null)
			{
				float sqrMagnitude = (GetOwnerEntity().transform.position - colliders[i].bounds.center).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					nearestCollider = colliders[i];
					num = sqrMagnitude;
				}
			}
		}
		return (Object)(object)nearestCollider != null;
	}

	private int CompareColliders(Collider a, Collider b)
	{
		if ((Object)(object)a == null && (Object)(object)b == null)
		{
			return 0;
		}
		if ((Object)(object)a == null)
		{
			return 1;
		}
		if ((Object)(object)b == null)
		{
			return -1;
		}
		float sqrMagnitude = (((Component)(object)a).transform.position + a.bounds.center).sqrMagnitude;
		float sqrMagnitude2 = (((Component)(object)b).transform.position + b.bounds.center).sqrMagnitude;
		return -sqrMagnitude.CompareTo(sqrMagnitude2);
	}
}
