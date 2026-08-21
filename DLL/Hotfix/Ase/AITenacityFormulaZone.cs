using Ase.ECS;

namespace Ase;

public class AITenacityFormulaZone : TenacityFormulaZoneBase<AITenacityFormulaData>
{
	private const string SpSkillTag = "Skill4";

	public override bool CheckIsCalcFormulaZone()
	{
		dataBase.isAttackerAI = base.CheckIsCalcFormulaZone() && attacker is HeroEntity heroEntity && heroEntity.IsAi;
		dataBase.isAttackerAI |= attacker is SummonedEntity { Parent: HeroEntity parent } && parent.IsAi;
		return dataBase.isAttackerAI;
	}

	protected override void OnCalcFormulaZone()
	{
		CalcAITenacity();
	}

	protected void CalcAITenacity()
	{
		if (dataBase.isAttackerAI)
		{
			dataBase.accountLevel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Level ?? 1;
			BattleFormulaUtility.GetConstantConfigValue(114, out dataBase.tenacityConstantA);
			BattleFormulaUtility.GetConstantConfigValue(115, out dataBase.tenacityConstantB);
			dataBase.aiTenacityRatio = dataDamage.GetAttackerProperty("AiTenacityRatio");
			HeroSkillData obj = attacker.GetComponent<SkillComponent>()?.GetSkillData(dataDamage.BelongToSkillId);
			dataBase.isSpSkill = obj?.GetSkillLabelList().Contains("Skill4") ?? false;
			if (!dataBase.isSpSkill || !BattleFormulaUtility.GetConstantConfigValue(10220, out dataBase.aiSpTenacityModify))
			{
				dataBase.aiSpTenacityModify = 1f;
			}
		}
	}
}
