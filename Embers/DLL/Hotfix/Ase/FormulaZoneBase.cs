namespace Ase;

public abstract class FormulaZoneBase
{
	protected FormulaDataParams dataParams;

	protected virtual void OnInit(FormulaDataParams param)
	{
		dataParams = param;
	}

	public virtual FormulaZoneDataBase CalcFormulaZone(FormulaDataParams param)
	{
		OnInit(param);
		FormulaZoneDataBase dataBase = GetDataBase();
		dataBase.isExcuteFormula = CheckIsCalcFormulaZone();
		if (dataBase.isExcuteFormula)
		{
			OnCalcFormulaZone();
			OnFormulaSettlement();
		}
		else
		{
			OnNoExcuteFormulaZone();
			dataBase.OnDefaultSettlement();
		}
		return dataBase;
	}

	protected abstract FormulaZoneDataBase GetDataBase();

	protected abstract void OnCalcFormulaZone();

	protected virtual void OnNoExcuteFormulaZone()
	{
	}

	protected abstract void OnFormulaSettlement();

	public virtual bool CheckIsCalcFormulaZone()
	{
		return true;
	}
}
