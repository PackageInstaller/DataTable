using System.Text;

namespace Ase;

public class DefenceFormulaData : FormulaZoneDataBase
{
	public float defenceBase;

	public float igoreDefence;

	public float defence;

	public float defenceConstant;

	public float defenceLevelConstant;

	public float defenceLevel;

	public bool isMonsterDefender;

	public float damageReduceRatio;

	public float damageReduceModify;

	public float damageAddModify;

	public bool isDamageProbability;

	public float damageProbabilityAddition;

	public bool isExtraReduceDamage;

	public float extraReduceDamage;

	public float envReduceDamage;

	public override string FormulaDataName => "防御乘区";

	public override void OnFormulaSettlement()
	{
		damageReduceRatio = 1f - defence / (defence + defenceLevel * defenceLevelConstant + defenceConstant);
		base.result = damageReduceRatio * (1f - (damageReduceModify + extraReduceDamage + (isDamageProbability ? damageProbabilityAddition : 0f)) + damageAddModify) * (1f - envReduceDamage);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine(FormulaDataName + "的最终数据:");
		if (isMonsterDefender)
		{
			stringBuilder.AppendLine($" 防御值({defence}) = (怪物等级({defenceLevel}) * {5} + {500}) * (1 - 无视防御({igoreDefence}));");
		}
		else
		{
			stringBuilder.AppendLine($" 防御值({defence}) = 基础防御值({defenceBase}) * (1 - 无视防御({igoreDefence}));");
		}
		stringBuilder.AppendLine($" 防御承伤率({damageReduceRatio}) = 1 - 防御值({defence}) / (防御值({defence}) + 防御等级({defenceLevel}) * 防御等级常数({defenceLevelConstant}) + 防御常数({defenceConstant}));");
		stringBuilder.Append($" 最终结果: 防御承伤率({damageReduceRatio}) * (1 - (属性减伤({damageReduceModify}) + 额外减伤({extraReduceDamage}) + 概率减伤({isDamageProbability} ? {damageProbabilityAddition} : 0)) + 易伤修正({damageAddModify})) * (1 - 环境减伤({envReduceDamage})) = {base.result}");
		return stringBuilder.ToString();
	}
}
