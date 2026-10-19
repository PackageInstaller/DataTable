using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Enemy牵引", "Action", new string[] { "enemy", "traction", "move", "movement", "position", "velocity" })]
public class ActionEnemyTraction : ConfigAction
{
	[Flags]
	public enum TractionType
	{
		vertical = 1,
		horizontal = 2
	}

	public EnemyTractionType enemyTractionType;

	public TractionType type = TractionType.vertical;

	public TargetBounds enemyTractionBounds = new TargetBounds
	{
		center = new Vector3(0f, 1f, 1f),
		size = new Vector3(4f, 0.5f, 0.5f)
	};

	public override void Do(ActionMemory memory)
	{
		if (enemyTractionBounds.size.z <= 0f)
		{
			return;
		}
		Entity entity = memory.target.entity;
		if (!entity.IsBehaveEntity() || !entity.GetMono().TryGetAttachPoint("waist", out var attackPoint))
		{
			return;
		}
		Vector3 position = attackPoint.position;
		Vector2 zero = Vector2.zero;
		Bounds bounds = new Bounds
		{
			center = memory.owner.GetCompTransform().physicsPosition + memory.owner.GetCompPhysics().faceDirRot * enemyTractionBounds.center,
			size = new Vector3(enemyTractionBounds.bounds.size.z, enemyTractionBounds.bounds.size.y, enemyTractionBounds.bounds.size.x)
		};
		MonsterWeigtType monsterWeigtType = entity.GetConfig().monsterWeigtType;
		if (monsterWeigtType != MonsterWeigtType.Small && monsterWeigtType != MonsterWeigtType.Normal)
		{
			return;
		}
		CompPhysics compPhysics = entity.GetCompPhysics();
		CompMotion compMotion = entity.GetCompMotion();
		switch (enemyTractionType)
		{
		case EnemyTractionType.onlyAirHitEnemy:
			if (compPhysics.isGrounded || compMotion.curMotionState != MotionState.Hit)
			{
				return;
			}
			break;
		case EnemyTractionType.allHitEnemyAllOk:
			if (compMotion.curMotionState != MotionState.Hit)
			{
				return;
			}
			break;
		}
		if (!bounds.Contains(position))
		{
			if (type.HasFlag(TractionType.vertical))
			{
				zero.y = Mathf.Clamp(position.y, bounds.min.y, bounds.max.y) - position.y;
			}
			if (type.HasFlag(TractionType.horizontal))
			{
				zero.x = Mathf.Clamp(position.x, bounds.min.x, bounds.max.x) - position.x;
			}
		}
		CompTransform compTransform = entity.GetCompTransform();
		CompTime compTime = entity.GetCompTime();
		if (zero.sqrMagnitude > 0f)
		{
			compTransform.SetTraction(zero, compTime.physicsFixedDeltalTime);
		}
	}
}
