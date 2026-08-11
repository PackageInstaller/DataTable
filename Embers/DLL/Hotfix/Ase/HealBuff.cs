namespace Ase;

public class HealBuff : BuffOperationBase<BuffDataHeal>
{
	protected override void OnExecute()
	{
		CureProcess();
		CureLog();
	}

	private void CureProcess()
	{
		CureProgressBase cureProgressNonAlloc = BattleFormulaUtility.GetCureProgressNonAlloc();
		if (cureProgressNonAlloc != null)
		{
			CureFormulaDataParams cureFormulaDataParams = CureFormulaDataParams.Create(base.buffOwner, base.buffFrom, base.config.LayerOverlying, base.buff.GetLayer(), dataBase.healRatioList, dataBase.healPropertyList, dataBase.healAdditionFromList, dataBase.healAddTypeList, dataBase.healFixAddition, 0f, 0f, dataBase.skillId, isExcuteFormula: true);
			cureFormulaDataParams.isCreateByBullet = dataBase.isCreateByBullet;
			cureProgressNonAlloc.ProgressStart(cureFormulaDataParams);
			BattleFormulaUtility.ReleaseCureProgress(cureProgressNonAlloc);
		}
	}

	private void CureLog()
	{
		_ = BattleProgressLog.IsOpen;
	}
}
