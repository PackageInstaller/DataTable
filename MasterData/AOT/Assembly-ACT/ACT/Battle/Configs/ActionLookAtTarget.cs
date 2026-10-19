using System.Collections.Generic;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行朝向目标", "Action", new string[] { "lookat", "target", "retarget", "aim" })]
public class ActionLookAtTarget : ConfigAction
{
	public bool usePos;

	public BaseFindTargets findTargetsCondition;

	public ConfigFunction<Vector3> pos;

	public bool useFunctionEntity;

	public ConfigFunction<EntityReference> entityBehave;

	public bool opAlliance;

	public override void Do(ActionMemory memory)
	{
		if (usePos)
		{
			Vector3 vector = pos.Return(memory);
			bool flag = memory.target.entity.GetCompTransform().physicsPosition.x - vector.x > 0f;
			memory.target.entity.SetFaceLeft(flag);
			memory.target.entity.GetCompMotion().layer0Peak.startFaceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
			memory.target.entity.GetCompPhysics().SetDirImmediately();
			return;
		}
		if (useFunctionEntity)
		{
			Vector3 physicsPosition = entityBehave.Return(memory).entity.GetCompTransform().physicsPosition;
			bool flag2 = memory.target.entity.GetCompTransform().physicsPosition.x - physicsPosition.x > 0f;
			memory.target.entity.SetFaceLeft(flag2);
			memory.target.entity.GetCompMotion().layer0Peak.startFaceDir = ((!flag2) ? FaceDir.Right : FaceDir.Left);
			memory.target.entity.GetCompPhysics().SetDirImmediately();
			return;
		}
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		WhereTargets whereTargets = new WhereTargets
		{
			alliance = (opAlliance ? memory.owner.GetAlliance() : memory.owner.GetAlliance().GetOp()),
			canBeAttack = true
		};
		findTargetsCondition.FindTargets(memory, list, whereTargets);
		if (list.Count > 0)
		{
			Entity entity = list[0].entity;
			EntityType entityType = entity.GetEntityType();
			if (entityType == EntityType.Monster || entityType == EntityType.Character || entityType == EntityType.Boss || entityType == EntityType.Trajectory || entityType == EntityType.Elite)
			{
				bool flag3 = memory.target.entity.GetCompTransform().physicsPosition.x - entity.GetCompTransform().physicsPosition.x > 0f;
				memory.target.entity.SetFaceLeft(flag3);
				memory.target.entity.GetCompMotion().layer0Peak.startFaceDir = ((!flag3) ? FaceDir.Right : FaceDir.Left);
				memory.target.entity.GetCompPhysics().SetDirImmediately();
			}
		}
		ListPool<FindTargetResult>.Release(list);
	}
}
