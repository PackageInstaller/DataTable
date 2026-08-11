namespace Ase;

public class CritFormulaData : FormulaZoneDataBase
{
	public bool isCrit;

	public float critDamage;

	public override string FormulaDataName => "暴击乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + (isCrit ? critDamage : 0f);
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据:1 + (是否暴击({isCrit} * 暴击伤害({critDamage})) = {base.result}";
	}
}
