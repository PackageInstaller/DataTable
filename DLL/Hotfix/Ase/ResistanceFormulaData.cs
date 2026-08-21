namespace Ase;

public class ResistanceFormulaData : FormulaZoneDataBase
{
	public float resistance;

	public override string FormulaDataName => "抗性乘区";

	public override void OnFormulaSettlement()
	{
		if (resistance <= 0f)
		{
			base.result = 1f - resistance / 2f;
		}
		else if (0f <= resistance && resistance < 0.75f)
		{
			base.result = 1f - resistance;
		}
		else if (resistance >= 0.75f)
		{
			base.result = 1f - 1f / (1f + resistance * 4f);
		}
	}

	public override string ToString()
	{
		if (resistance <= 0f)
		{
			return $"{FormulaDataName}的最终数据: 1 - 抗性({resistance}) / 2 = {base.result}";
		}
		if (0f <= resistance && resistance < 0.75f)
		{
			return $"{FormulaDataName}的最终数据: 1 - 抗性({resistance}) = {base.result}";
		}
		if (resistance >= 0.75f)
		{
			return $"{FormulaDataName}的最终数据: 1 - 1 / (抗性({resistance}) * 4) = {base.result}";
		}
		return $"{FormulaDataName}的最终数据:{resistance}";
	}
}
