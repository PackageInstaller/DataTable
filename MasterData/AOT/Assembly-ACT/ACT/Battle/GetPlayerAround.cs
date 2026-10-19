using ACT.Battle.ECS.System;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/应该要废弃的,直接用CheckDistanceWithApostion")]
[TaskDescription("检查角色是否在范围内或范围外，玩家处于判定范围返还success，不在判定范围返还failure")]
public class GetPlayerAround : Conditional
{
	public SharedFloat distance = 1f;

	public Condition condition;

	public DistanceType distanceType;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("找到目标的时候同时设置为仇恨目标")]
	public bool setHatred;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("使用导航位置/物理位置计算距离")]
	public bool navPosition;

	public bool useRayCastCheckBlock = true;

	private float m_distanceSqr;

	private Entity owner;

	private Vector3 thisPos;

	public override void OnStart()
	{
		owner = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		thisPos = (navPosition ? owner.GetCompNav().navPosition : owner.GetCompTransform().physicsPosition);
		m_distanceSqr = ((distanceType == DistanceType.line) ? Mathf.Pow(distance.Value, 2f) : distance.Value);
		if (owner.GetCompAlliance().alliance == Alliance.Character)
		{
			Entity hatred = owner.GetCompHatred().GetHatred();
			if (hatred.IsValid)
			{
				if (!hatred.IsAlive())
				{
					return TaskStatus.Failure;
				}
				Vector3 physicsPosition = hatred.GetCompTransform().physicsPosition;
				bool flag = distanceType switch
				{
					DistanceType.horizontal => Mathf.Abs(physicsPosition.x - thisPos.x), 
					DistanceType.vertical => Mathf.Abs(physicsPosition.y - thisPos.y), 
					DistanceType.line => (physicsPosition - thisPos).sqrMagnitude, 
					_ => 0f, 
				} < m_distanceSqr;
				switch (condition)
				{
				case Condition.Greater:
				case Condition.GreaterAndEqual:
					flag = !flag;
					break;
				}
				if (flag)
				{
					return TaskStatus.Success;
				}
			}
			else
			{
				SystemHatred systemHatred = Singleton<GameManager>.instance.ecsManager.systemHatred;
				Vector3 attachPointPosition = owner.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
				for (int i = 0; i < systemHatred.hatredList.Count; i++)
				{
					Entity entity = systemHatred.hatredList[i];
					if (!entity.IsLogicAvailable())
					{
						continue;
					}
					Vector3 physicsPosition2 = entity.GetCompTransform().physicsPosition;
					bool flag2 = distanceType switch
					{
						DistanceType.horizontal => Mathf.Abs(physicsPosition2.x - thisPos.x), 
						DistanceType.vertical => Mathf.Abs(physicsPosition2.y - thisPos.y), 
						DistanceType.line => (physicsPosition2 - thisPos).sqrMagnitude, 
						_ => 0f, 
					} < m_distanceSqr;
					switch (condition)
					{
					case Condition.Greater:
					case Condition.GreaterAndEqual:
						flag2 = !flag2;
						break;
					}
					if (!flag2)
					{
						continue;
					}
					if (useRayCastCheckBlock)
					{
						Vector3 direction = entity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT) - attachPointPosition;
						RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
						int num = Physics.RaycastNonAlloc(attachPointPosition, direction, cacheHits, direction.magnitude, BattleConsts.enviromentMask);
						PhysicsUtility.Release(cacheHits);
						flag2 &= num == 0;
					}
					if (flag2)
					{
						if (setHatred)
						{
							owner.SetHatred(entity);
						}
						return TaskStatus.Success;
					}
				}
			}
		}
		else if (owner.GetCompAlliance().alliance == Alliance.Enemy)
		{
			Entity hatred2 = owner.GetCompHatred().GetHatred();
			if (hatred2.IsValid)
			{
				if (hatred2.GetCompAbility().HasAbility("cantBeAttack") && hatred2.IsCharacter())
				{
					return TaskStatus.Failure;
				}
				Vector3 physicsPosition3 = hatred2.GetCompTransform().physicsPosition;
				bool flag3 = distanceType switch
				{
					DistanceType.horizontal => Mathf.Abs(physicsPosition3.x - thisPos.x), 
					DistanceType.vertical => Mathf.Abs(physicsPosition3.y - thisPos.y), 
					DistanceType.line => (physicsPosition3 - thisPos).sqrMagnitude, 
					_ => 0f, 
				} < m_distanceSqr;
				switch (condition)
				{
				case Condition.Greater:
				case Condition.GreaterAndEqual:
					flag3 = !flag3;
					break;
				}
				if (flag3)
				{
					return TaskStatus.Success;
				}
			}
			else
			{
				MPPlayer localPlayer = MonoECS.instance.localPlayer;
				if (localPlayer != null && localPlayer.battleEntity.IsValid)
				{
					Vector3 physicsPosition4 = localPlayer.battleEntity.GetCompTransform().physicsPosition;
					bool flag4 = distanceType switch
					{
						DistanceType.horizontal => Mathf.Abs(physicsPosition4.x - thisPos.x), 
						DistanceType.vertical => Mathf.Abs(physicsPosition4.y - thisPos.y), 
						DistanceType.line => (physicsPosition4 - thisPos).sqrMagnitude, 
						_ => 0f, 
					} < m_distanceSqr;
					switch (condition)
					{
					case Condition.Greater:
					case Condition.GreaterAndEqual:
						flag4 = !flag4;
						break;
					}
					if (!flag4)
					{
						return TaskStatus.Failure;
					}
					if (useRayCastCheckBlock)
					{
						Vector3 attachPointPosition2 = owner.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
						Vector3 direction2 = localPlayer.battleEntity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT) - attachPointPosition2;
						RaycastHit[] cacheHits2 = PhysicsUtility.cacheHits;
						int num2 = Physics.RaycastNonAlloc(attachPointPosition2, direction2, cacheHits2, direction2.magnitude, BattleConsts.enviromentMask);
						PhysicsUtility.Release(cacheHits2);
						flag4 &= num2 == 0;
					}
					if (flag4)
					{
						owner.SetHatred(localPlayer.battleEntity);
						return TaskStatus.Success;
					}
				}
			}
		}
		return TaskStatus.Failure;
	}
}
