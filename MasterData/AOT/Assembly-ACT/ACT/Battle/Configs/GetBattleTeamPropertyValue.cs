using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取战斗队伍属性值", "Function", new string[] { "get", "battle", "team", "property", "value", "float", "int" })]
public class GetBattleTeamPropertyValue : ConfigFunction<float>
{
	public int teamIndex;

	[Tooltip("要对什么属性进行修改")]
	public uint property;

	public GetCoefficientType sub;

	protected override float Evaluate(ActionMemory memory)
	{
		if (MonoECS.instance.localPlayer.GetTeamCharacter(teamIndex).TryGetCompAbility(out CompAbility component))
		{
			return component.GetProperty(property).GetPropertyCoefficient(sub);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("实体引用无效，返回默认值0");
		}
		return 0f;
	}
}
