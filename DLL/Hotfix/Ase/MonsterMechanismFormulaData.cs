using System.Text;

namespace Ase;

public class MonsterMechanismFormulaData : FormulaZoneDataBase
{
	public int siteLevel;

	public float partAddition;

	public float partAdditionRatio;

	public float flawAddition;

	public float flawAdditionRatio;

	public bool monsterConverselyState;

	public float stateAddition;

	public float converselyAdditionRatio;

	public bool monsterFuryState;

	public float furyAddition;

	public float furyAdditionRatio;

	public bool monsterWeakState;

	public float weakAdditionRatio;

	public override string FormulaDataName => "怪物机制乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + (partAddition + partAdditionRatio + flawAddition + flawAdditionRatio + stateAddition);
		if (monsterConverselyState)
		{
			base.result += converselyAdditionRatio;
		}
		if (monsterFuryState)
		{
			base.result += furyAddition + furyAdditionRatio;
		}
		if (monsterWeakState)
		{
			base.result += weakAdditionRatio;
		}
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(FormulaDataName + "的最终数据:1");
		stringBuilder.Append($" + 部位加成系数[部位等级({siteLevel}) 加成系数({partAddition})] + 部位加成倍率({partAdditionRatio})");
		stringBuilder.Append($" + 破绽加成系数({flawAddition})  + 黄红破绽加成倍率({flawAdditionRatio})");
		stringBuilder.Append($" + 状态加成系数({stateAddition})");
		if (monsterConverselyState)
		{
			stringBuilder.Append($" + 倒地加成倍率({converselyAdditionRatio})");
		}
		if (monsterFuryState)
		{
			stringBuilder.Append($" + OD加成系数({furyAddition}) + OD加成倍率({furyAdditionRatio})");
		}
		if (monsterWeakState)
		{
			stringBuilder.Append($" + Break加成倍率({weakAdditionRatio})");
		}
		stringBuilder.Append($" = {base.result}");
		return stringBuilder.ToString();
	}
}
