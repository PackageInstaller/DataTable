using NodeCanvas.Framework;
using ParadoxNotion.Design;
using Sirenix.Utilities;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取给定坐标的最近可到达坐标", 0)]
[Description("计算最近可到达给定坐标的点，并将结果存储在指定的变量中。")]
[Category("✫ DragonLost/Transform")]
public class GetNearestCanMovePoint : ActionTaskBase
{
	[Name("获取结果", 0)]
	[Description("存储最近可到达坐标的变量。")]
	public BBParameter<Vector3> resultPosition;

	[Name("目标坐标", 0)]
	[Description("要计算最近可到达点的目标坐标。")]
	public BBParameter<Vector3> targetPosition;

	protected override void OnExecute()
	{
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_0109: Unknown result type (might be due to invalid IL or missing references)
		base.OnExecute();
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取给定坐标的最近可到达坐标 目标坐标 {targetPosition.value}", ownerEntity);
		}
		ColllisionComponent typeOfComponent = GetOwnerEntity().GetTypeOfComponent<ColllisionComponent>();
		if (typeOfComponent != null)
		{
			CapsuleCollider bodyCollider = typeOfComponent.GetBodyCollider();
			if ((Object)(object)bodyCollider != null)
			{
				Vector3 vector = typeOfComponent.transform.position + typeOfComponent.transform.rotation * (bodyCollider.center + -Vector3.up * (bodyCollider.height * 0.5f));
				Vector3 vector2 = typeOfComponent.transform.position + typeOfComponent.transform.rotation * (bodyCollider.center + Vector3.up * (bodyCollider.height * 0.5f));
				RaycastHit[] array = (RaycastHit[])(object)new RaycastHit[16];
				PhysicsScene physicsScene = GetOwnerEntity().GetWorld().GetPhysicsScene();
				((PhysicsScene)(ref physicsScene)).CapsuleCast(vector, vector2, bodyCollider.radius, (targetPosition.value - typeOfComponent.transform.position).normalized, array, (targetPosition.value - typeOfComponent.transform.position).magnitude, -1, (QueryTriggerInteraction)1);
				array.Sort(CompareHit);
				if (TryGetNearestHitPonit(array, out var nearestCollider, out var hitPoint))
				{
					Vector3 vector3 = default(Vector3);
					float value = default(float);
					if (Physics.ComputePenetration((Collider)(object)bodyCollider, hitPoint, typeOfComponent.transform.rotation, nearestCollider, ((Component)(object)nearestCollider).transform.position, ((Component)(object)nearestCollider).transform.rotation, ref vector3, ref value))
					{
						value = Utility.Math.Round(value, 10000f);
						vector3.y = 0f;
						Vector3 vector4 = vector3 * (value + 0.01f);
						Vector3 value2 = hitPoint + vector4;
						value2.y = targetPosition.value.y;
						resultPosition.value = value2;
						if (LockstepData.Instance != null)
						{
							LockstepData.Instance?.WriteAuthorityEntityId($"获取给定坐标的最近可到达坐标 获取结果 {resultPosition.value} result[0].point {hitPoint} " + $"resolutionMovement  {vector4}", ownerEntity);
						}
					}
				}
				else
				{
					resultPosition.value = targetPosition.value;
				}
			}
		}
		OnActionFinish();
	}

	private bool IsVaildCollider(Collider collider)
	{
		if ((Object)(object)collider == null)
		{
			return false;
		}
		if (((Component)(object)collider).gameObject.CompareTag("AirWall"))
		{
			return !collider.isTrigger;
		}
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("Battle"))
		{
			return false;
		}
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("AreaTrigger"))
		{
			return false;
		}
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			return false;
		}
		return !collider.isTrigger;
	}

	private int CompareHit(RaycastHit a, RaycastHit b)
	{
		if (((RaycastHit)(ref a)).transform == null || ((RaycastHit)(ref b)).transform == null)
		{
			return 0;
		}
		if (((RaycastHit)(ref a)).transform == null)
		{
			return 1;
		}
		if (((RaycastHit)(ref b)).transform == null)
		{
			return -1;
		}
		float sqrMagnitude = ((RaycastHit)(ref a)).transform.position.sqrMagnitude;
		float sqrMagnitude2 = ((RaycastHit)(ref b)).transform.position.sqrMagnitude;
		return -sqrMagnitude.CompareTo(sqrMagnitude2);
	}

	private bool TryGetNearestHitPonit(RaycastHit[] raycastHits, out Collider nearestCollider, out Vector3 hitPoint)
	{
		float num = float.MaxValue;
		bool result = false;
		hitPoint = Vector3.zero;
		nearestCollider = null;
		for (int i = 0; i < raycastHits.Length; i++)
		{
			if (IsVaildCollider(((RaycastHit)(ref raycastHits[i])).collider))
			{
				float sqrMagnitude = (GetOwnerEntity().transform.position - ((RaycastHit)(ref raycastHits[i])).point).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					nearestCollider = ((RaycastHit)(ref raycastHits[i])).collider;
					hitPoint = ((RaycastHit)(ref raycastHits[i])).point;
					num = sqrMagnitude;
					result = true;
				}
			}
		}
		return result;
	}
}
