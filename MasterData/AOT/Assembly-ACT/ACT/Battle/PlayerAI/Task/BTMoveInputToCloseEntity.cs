using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.PlayerAI.Task;

[TaskCategory("ACT/Player")]
[TaskDescription("玩家移动输入")]
public class BTMoveInputToCloseEntity : Action
{
	public SharedFloat distance = 1f;

	public bool useRayCastCheckBlock = true;

	public override TaskStatus OnUpdate()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		Entity entity = Owner.ToEntity();
		if (!entity.IsValid || mainEntity.InTag(MotionTag_backUp.ForbidPlayerAIMoveInput))
		{
			return TaskStatus.Success;
		}
		Vector3 physicsPosition = mainEntity.GetCompTransform().physicsPosition;
		float num = distance.Value * distance.Value;
		Vector3 attachPointPosition = entity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
		foreach (Entity hatred in Singleton<GameManager>.instance.ecsManager.systemHatred.hatredList)
		{
			if (!hatred.IsLogicAvailable())
			{
				continue;
			}
			float sqrMagnitude = (hatred.GetCompTransform().physicsPosition - physicsPosition).sqrMagnitude;
			bool flag = sqrMagnitude < num;
			if (flag)
			{
				if (useRayCastCheckBlock)
				{
					Vector3 direction = hatred.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT) - attachPointPosition;
					RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
					int num2 = Physics.RaycastNonAlloc(attachPointPosition, direction, cacheHits, direction.magnitude, BattleConsts.enviromentMask);
					PhysicsUtility.Release(cacheHits);
					flag &= num2 == 0;
				}
				if (flag)
				{
					num = sqrMagnitude;
				}
			}
		}
		return TaskStatus.Success;
	}
}
