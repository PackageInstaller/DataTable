using Ase.ECS;

namespace Ase;

public class AIBeCureFormulaZone : CureFormulaZoneBase<AIBeCureFormulaData>
{
	public override bool CheckIsCalcFormulaZone()
	{
		if (!base.CheckIsCalcFormulaZone())
		{
			return false;
		}
		if (cureEntity is HeroEntity { IsAi: not false })
		{
			dataBase.accountLevel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Level ?? 1;
			return true;
		}
		return false;
	}

	protected override void OnCalcFormulaZone()
	{
		CalcAIBeCureAddition();
	}

	protected void CalcAIBeCureAddition()
	{
		dataBase.accountLevel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Level ?? 1;
		BattleFormulaUtility.GetConstantConfigValue(116, out dataBase.cureConstantA);
		BattleFormulaUtility.GetConstantConfigValue(117, out dataBase.cureConstantB);
	}
}
