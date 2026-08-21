using Ase.ECS;

namespace Ase;

public class AIDamageFormulaZone : DamageFormulaZoneBase<AIDamageFormulaData>
{
	private const string SpSkillTag = "Skill4";

	public override bool CheckIsCalcFormulaZone()
	{
		if (!base.CheckIsCalcFormulaZone())
		{
			return false;
		}
		dataBase.isAttackerAI = attacker is HeroEntity heroEntity && heroEntity.IsAi;
		dataBase.isDefenderAI = defender is HeroEntity heroEntity2 && heroEntity2.IsAi;
		dataBase.isAttackerAI |= attacker is SummonedEntity { Parent: HeroEntity parent } && parent.IsAi;
		dataBase.isDefenderAI |= defender is SummonedEntity { Parent: HeroEntity parent2 } && parent2.IsAi;
		if (dataBase.isAttackerAI || dataBase.isDefenderAI)
		{
			dataBase.accountLevel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Level ?? 1;
			return true;
		}
		return false;
	}

	protected override void OnCalcFormulaZone()
	{
		CalcAIDamageModify();
		CalcHitModify();
	}

	protected void CalcAIDamageModify()
	{
		if (!dataBase.isAttackerAI)
		{
			return;
		}
		if (!BattleFormulaUtility.GetConstantConfigValue(110, out dataBase.damageConstantA) || !BattleFormulaUtility.GetConstantConfigValue(111, out dataBase.damageConstantB))
		{
			dataBase.damageModify = 1f;
			return;
		}
		dataBase.damageModify = dataBase.damageConstantA + dataBase.accountLevel * dataBase.damageConstantB;
		dataBase.aiDamageRatio = dataDamage.GetAttackerProperty("AiDamageRatio");
		HeroSkillData obj = attacker.GetComponent<SkillComponent>()?.GetSkillData(dataDamage.BelongToSkillId);
		dataBase.isSpSkill = obj?.GetSkillLabelList().Contains("Skill4") ?? false;
		if (!dataBase.isSpSkill || !BattleFormulaUtility.GetConstantConfigValue(10210, out dataBase.aiSpDamageModify))
		{
			dataBase.aiSpDamageModify = 1f;
		}
	}

	protected void CalcHitModify()
	{
		if (dataBase.isDefenderAI)
		{
			if (!BattleFormulaUtility.GetConstantConfigValue(112, out dataBase.hitConstantA) || !BattleFormulaUtility.GetConstantConfigValue(113, out dataBase.hitConstantB))
			{
				dataBase.hitModify = 1f;
			}
			else
			{
				dataBase.hitModify = dataBase.hitConstantA + dataBase.accountLevel * dataBase.hitConstantB;
			}
		}
	}
}
