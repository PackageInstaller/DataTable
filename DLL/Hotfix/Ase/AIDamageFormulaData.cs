using System.Text;

namespace Ase;

public class AIDamageFormulaData : FormulaZoneDataBase
{
	public bool isAttackerAI;

	public bool isDefenderAI;

	public float damageModify;

	public float damageConstantA;

	public float damageConstantB;

	public float hitModify;

	public float hitConstantA;

	public float hitConstantB;

	public float accountLevel;

	public float aiDamageRatio;

	public bool isSpSkill;

	public float aiSpDamageModify;

	public override string FormulaDataName => "AI伤害机制乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f;
		if (isAttackerAI)
		{
			base.result *= damageModify * (1f + aiDamageRatio);
			if (isSpSkill)
			{
				base.result *= aiSpDamageModify;
			}
		}
		if (isDefenderAI)
		{
			base.result *= hitModify;
		}
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(FormulaDataName + "的最终数据:");
		if (isAttackerAI)
		{
			if (!isSpSkill)
			{
				stringBuilder.Append($"攻击者为AI:(AI伤害修正常数A({damageConstantA}) + 玩家账号等级({accountLevel}) * AI伤害修正常数B({damageConstantB})) * (1 + AI伤害调整系数({aiDamageRatio}))");
			}
			else
			{
				stringBuilder.Append($"(攻击者为AI:(AI伤害修正常数A({damageConstantA}) + 玩家账号等级({accountLevel}) * AI伤害修正常数B({damageConstantB})) * (1 + AI伤害调整系数({aiDamageRatio}))) * AI大招伤害修正({aiSpDamageModify})");
			}
		}
		if (isDefenderAI)
		{
			stringBuilder.Append($"受击者为AI:AI承伤修正常数A({hitConstantA}) + 玩家账号等级({accountLevel}) * AI承伤修正常数B({hitConstantB})");
		}
		stringBuilder.Append($" = {base.result}");
		return stringBuilder.ToString();
	}
}
