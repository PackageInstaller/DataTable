using ACT.Core;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取技能等级", "Function", new string[] { "get", "skil", "level", "value", "float", "int" })]
public class GetSkilLevel : ConfigFunction<float>
{
	public int skillID;

	protected override float Evaluate(ActionMemory memory)
	{
		RuntimeConfigs.data.skillDetailLevelDatas.TryGetValue(skillID, out var value);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"{memory.target.entity}正在获取{skillID}的技能等级{value.level}");
		}
		return value.level;
	}
}
