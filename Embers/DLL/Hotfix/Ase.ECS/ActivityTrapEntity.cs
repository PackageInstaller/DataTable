using System;

namespace Ase.ECS;

public class ActivityTrapEntity : BattleEntity
{
	public override bool IsSyncPhysicsEntity => false;

	protected override Type[] GetEntityComps()
	{
		return new Type[7]
		{
			typeof(EntityViewComponent),
			typeof(EntityBoneComponent),
			typeof(HitColliderComponent),
			typeof(DataNodeComponent),
			typeof(EntityPointMaterialComponent),
			typeof(TransformComponent),
			typeof(MonsterDestroyComponent)
		};
	}

	public float GetTriggerTime()
	{
		if (userData is DRBattleEntityConfig dRBattleEntityConfig)
		{
			return dRBattleEntityConfig.Time;
		}
		return 0f;
	}
}
