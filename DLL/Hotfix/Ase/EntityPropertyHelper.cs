using Ase.ECS;

namespace Ase;

public static class EntityPropertyHelper
{
	public static float GetEntityCrit(this BaseEntity entity, BaseWeaknessData weaknessData, HitColliderVariableData hbData, bool monsterCollapseState, bool odState, BaseEntity defenseEntity)
	{
		float num = entity.GetProperty("Crit");
		if (weaknessData != null && weaknessData.IsWarnWeakness)
		{
			num += entity.GetProperty("HighWeaknessCritAddition");
		}
		if (hbData != null && hbData.IsHbPart)
		{
			num += entity.GetProperty("HBCritAddition");
		}
		if (monsterCollapseState)
		{
			num += entity.GetProperty("KnockDownCritAddition");
		}
		if (odState)
		{
			num += entity.GetProperty("ODCritAddition");
		}
		return num;
	}
}
