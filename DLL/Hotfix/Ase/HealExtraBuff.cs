#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class HealExtraBuff : BuffOperationBase<BuffDataHealExtra>
{
	protected override void OnExecute()
	{
		NewCureProcess();
		CureLog();
	}

	private void NewCureProcess()
	{
		float maxHp = GetMaxHp();
		CureProgressBase cureProgressNonAlloc = BattleFormulaUtility.GetCureProgressNonAlloc();
		if (cureProgressNonAlloc != null)
		{
			CureFormulaDataParams cureDataParams = CureFormulaDataParams.Create(base.buffOwner, base.buffFrom, isLayerEffect: false, 0, null, null, null, null, dataBase.healFixAddition, dataBase.healRatio, maxHp, 0, dataBase.formula);
			cureProgressNonAlloc.ProgressStart(cureDataParams);
			BattleFormulaUtility.ReleaseCureProgress(cureProgressNonAlloc);
		}
	}

	private float GetMaxHp()
	{
		switch (dataBase.teamType)
		{
		case EntityTeamType.Self:
			return base.buffOwner.GetPropertyMax("Hp");
		case EntityTeamType.Creator:
			return base.buffFrom.GetPropertyMax("Hp");
		default:
			Log.Error($"额外治疗buff,阵营类型异常{dataBase.teamType}");
			Toast.ShowError($"额外治疗buff,阵营类型异常{dataBase.teamType}");
			return 0f;
		}
	}

	private void CureLog()
	{
		_ = BattleProgressLog.IsOpen;
	}
}
