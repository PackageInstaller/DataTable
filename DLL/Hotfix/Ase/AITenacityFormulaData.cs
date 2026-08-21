namespace Ase;

public class AITenacityFormulaData : FormulaZoneDataBase
{
	public bool isAttackerAI;

	public float tenacityConstantA;

	public float tenacityConstantB;

	public float accountLevel;

	public float aiTenacityRatio;

	public bool isSpSkill;

	public float aiSpTenacityModify;

	public override string FormulaDataName => "AI削韧乘区";

	public override void OnFormulaSettlement()
	{
		if (isAttackerAI)
		{
			base.result = (tenacityConstantA + accountLevel * tenacityConstantB) * (1f + aiTenacityRatio);
			if (isSpSkill)
			{
				base.result *= aiSpTenacityModify;
			}
		}
		else
		{
			base.result = 1f;
		}
	}

	public override string ToString()
	{
		if (isAttackerAI && isSpSkill)
		{
			return $"{FormulaDataName}的最终数据: ((削韧修正常数A({tenacityConstantA}) + 账号等级({accountLevel}) * 削韧修正常数B({tenacityConstantB})) * (1 + AI削韧调整系数({aiTenacityRatio}))) * AI大招削韧系数({aiSpTenacityModify}) = {base.result}";
		}
		return $"{FormulaDataName}的最终数据: (削韧修正常数A({tenacityConstantA}) + 账号等级({accountLevel}) * 削韧修正常数B({tenacityConstantB})) * (1 + AI削韧调整系数({aiTenacityRatio})) = {base.result}";
	}
}
