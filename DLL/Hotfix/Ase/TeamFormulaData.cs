namespace Ase;

public class TeamFormulaData : FormulaZoneDataBase
{
	public float teamDamageAddition;

	public override string FormulaDataName => "组队乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + teamDamageAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: 1 + 组队增伤({teamDamageAddition}) = {base.result}";
	}
}
