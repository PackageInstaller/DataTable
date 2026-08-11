namespace Ase;

public class WeaponMechanismFormulaData : FormulaZoneDataBase
{
	public float weaponMechanism;

	public float weaponMechanismRatio;

	public float skillAddition;

	public float treeAndBuffAddition;

	public float extraTreeAndBuffAddition;

	public override string FormulaDataName => "技能增伤乘区";

	public override void OnFormulaSettlement()
	{
		base.result = (1f + weaponMechanism * (1f + weaponMechanismRatio) + skillAddition) * (1f + treeAndBuffAddition + extraTreeAndBuffAddition);
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据:(1 + 武器增伤({weaponMechanism}) * 武器机制伤害提升倍率({weaponMechanismRatio}) + 技能伤害加成({skillAddition.Round2()})) * (1 + 行为树&Buff增伤({treeAndBuffAddition.Round2()}) + 额外行为树&Buff增伤({extraTreeAndBuffAddition.Round2()})) = {base.result}";
	}
}
