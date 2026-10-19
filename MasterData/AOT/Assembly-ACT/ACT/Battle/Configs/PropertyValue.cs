using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取属性值", "Function", new string[] { "property", "value", "float", "int" })]
public class PropertyValue : ConfigFunction<float>
{
	public MemoryEntityRef source;

	public uint property;

	public GetCoefficientType sub = GetCoefficientType.Total;

	protected override float Evaluate(ActionMemory memory)
	{
		Entity entityReference = memory.GetEntityReference(source);
		if (!entityReference.IsValid && LuminApplication.LogEnabled)
		{
			Debug.LogWarning("实体引用无效，返回默认值0");
		}
		return entityReference.GetCompAbility().GetProperty(property).GetPropertyCoefficient(sub);
	}
}
