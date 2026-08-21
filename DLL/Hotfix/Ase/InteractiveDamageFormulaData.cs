namespace Ase;

public class InteractiveDamageFormulaData : FormulaZoneDataBase
{
	public float interactiveDamage;

	public override string FormulaDataName => "交互物伤害乘区";

	public override void OnFormulaSettlement()
	{
		base.result = interactiveDamage;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据:交互物配置伤害({interactiveDamage}) = {base.result}";
	}
}
