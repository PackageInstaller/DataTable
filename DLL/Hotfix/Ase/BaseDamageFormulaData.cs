using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BaseDamageFormulaData : FormulaZoneDataBase
{
	public class PropertyDamageAddition
	{
		public string propertyKey;

		public float value;

		public float addition;

		public override string ToString()
		{
			return $"属性({propertyKey}) 值({value}) 加成({addition})";
		}
	}

	public List<PropertyDamageAddition> propertyAdditionList = new List<PropertyDamageAddition>();

	public float propertyAddition;

	public float talentDamageRaito;

	public float fixAddition;

	public float fixedValue;

	public float damageAdditionRatio;

	public float talentFixDamageRatio;

	public override string FormulaDataName => "基础伤害乘区";

	public override void OnFormulaSettlement()
	{
		base.result = (propertyAddition * talentDamageRaito + fixAddition * talentFixDamageRatio + fixedValue) * (1f + damageAdditionRatio);
	}

	public override void OnDefaultSettlement()
	{
		base.result = fixedValue;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (PropertyDamageAddition propertyAddition in propertyAdditionList)
		{
			stringBuilder.Append(propertyAddition.ToString());
			stringBuilder.Append(",");
		}
		return $"{FormulaDataName}的最终数据:(属性伤害加成[{stringBuilder}]; 属性伤害总加成({this.propertyAddition} * 燃点等级伤害系数({talentDamageRaito}) + 固定伤害({fixAddition}) * 燃点等级固定伤害系数({talentFixDamageRatio}) + 独立固定伤害({fixedValue})) * (1 + 伤害系数调整({damageAdditionRatio})) = {base.result}";
	}
}
