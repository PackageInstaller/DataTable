using Ase.ECS;

namespace Ase;

public class CureFormulaZoneBase<T> : FormulaZoneBase where T : FormulaZoneDataBase, new()
{
	protected CureFormulaDataParams cureFormulaData;

	protected BaseEntity cureEntity;

	protected BaseEntity doctorEntity;

	protected T dataBase;

	protected override void OnInit(FormulaDataParams param)
	{
		base.OnInit(param);
		dataBase = new T();
		cureFormulaData = param as CureFormulaDataParams;
		if (cureFormulaData != null)
		{
			cureEntity = cureFormulaData.cureEntity;
			doctorEntity = cureFormulaData.doctorEntity;
		}
	}

	public override bool CheckIsCalcFormulaZone()
	{
		return cureFormulaData.isExcuteFormula;
	}

	protected override void OnCalcFormulaZone()
	{
	}

	protected override FormulaZoneDataBase GetDataBase()
	{
		return dataBase;
	}

	protected override void OnFormulaSettlement()
	{
		dataBase.OnFormulaSettlement();
	}
}
