namespace Ase;

public abstract class FormulaZoneDataBase
{
	public bool isExcuteFormula;

	public abstract string FormulaDataName { get; }

	public float result { get; protected set; }

	public abstract void OnFormulaSettlement();

	public virtual void OnDefaultSettlement()
	{
		result = 1f;
	}
}
