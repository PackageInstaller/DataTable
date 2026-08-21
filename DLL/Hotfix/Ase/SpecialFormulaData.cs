using System.Text;

namespace Ase;

public class SpecialFormulaData : FormulaZoneDataBase
{
	public bool isCalcLight;

	public float minLight;

	public float maxLight;

	public string needCalcLightKey;

	public float attackerLight;

	public float defenderLight;

	public float realLight;

	public float lightAddition;

	public override string FormulaDataName => "特殊机制乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f;
		if (isCalcLight)
		{
			base.result *= lightAddition;
		}
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine(FormulaDataName + "的最终数据:");
		stringBuilder.AppendLine($"光等数据: = [是否计算光等({isCalcLight})] [计算光等属性key({needCalcLightKey})] 攻击者光等({attackerLight}) 防御者光等（{defenderLight}）计算后的实际光等({realLight}) 实际光等加成({lightAddition})");
		stringBuilder.AppendLine($"{FormulaDataName}: 1 * 光等加成({lightAddition}) = {base.result}");
		return stringBuilder.ToString();
	}
}
