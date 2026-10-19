using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("计算浮点除法", "Function", new string[] { "float", "division", "value", "int" })]
public class FloatDivision : ConfigFunction<float>
{
	public enum CalType
	{
		onlyInt,
		needDecimal
	}

	public ConfigFunction<float> v1;

	public ConfigFunction<float> v2;

	public CalType calType;

	protected override float Evaluate(ActionMemory memory)
	{
		float num = v1.Return(memory);
		float num2 = v2.Return(memory);
		if (Mathf.Approximately(num2, 0f))
		{
			Debug.LogWarning("FloatDivision: 除数为 0，已返回 0。");
			return 0f;
		}
		return calType switch
		{
			CalType.onlyInt => (int)(num / num2), 
			CalType.needDecimal => num / num2, 
			_ => num / num2, 
		};
	}
}
