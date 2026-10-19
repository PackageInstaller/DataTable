using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取主控实体属性值", "Function", new string[] { "get", "main", "entity", "property", "value", "float", "int" })]
public class GetMainEntityPropertyValue : ConfigFunction<float>
{
	[Tooltip("要对什么属性进行修改")]
	public uint property;

	public GetCoefficientType sub;

	protected override float Evaluate(ActionMemory memory)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			return mainEntity.GetCompAbility().GetProperty(property).GetPropertyCoefficient(sub);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("实体引用无效，返回默认值0");
		}
		return 0f;
	}
}
