using Ase.ECS;

namespace Ase;

public class IntensifyTenacityFormulaZone : TenacityFormulaZoneBase<IntensifyTenacityFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcIntensifyAddition();
		CalcTreeAddition();
	}

	protected void CalcIntensifyAddition()
	{
		dataBase.intensifyAddition = attacker.GetProperty("TenacityAddition");
	}

	protected void CalcTreeAddition()
	{
		SkillAdditionData skillAdditionData = attacker.GetComponent<SkillComponent>()?.GetSkillAddition(dataDamage.BelongToSkillId);
		if (skillAdditionData != null)
		{
			dataBase.treeAddition += skillAdditionData.SkillSpecialTenacity;
		}
		if (tenacityParams.isAttackAngleDenfense)
		{
			dataBase.treeAddition -= defender.GetComponent<EntityDefenceComponent>()?.subTenacityValue ?? 0f;
		}
		if (attacker.GetEntityType() == EntityType.SummonedEntity)
		{
			dataBase.extraTreeAddition += (dataDamage.bulletAttackData?.BulletParentPropertyData?.SkillSpecialTenacity).GetValueOrDefault();
		}
	}
}
