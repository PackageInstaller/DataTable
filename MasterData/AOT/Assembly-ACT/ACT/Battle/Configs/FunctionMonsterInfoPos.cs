using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取怪物信息位置", "Function", new string[] { "monster", "info", "pos", "vector", "position", "rotation", "quaternion" })]
public class FunctionMonsterInfoPos : ConfigFunction<Vector3>
{
	public string infoPosName;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		if (!memory.target.entity.IsBattleBehaveNotCharacter())
		{
			_ = LuminApplication.LogEnabled;
			return Vector3.zero;
		}
		CompAI compAI = memory.target.entity.GetCompAI();
		for (int i = 0; i < compAI.infoPosNames.Count; i++)
		{
			if (compAI.infoPosNames[i] == infoPosName)
			{
				return compAI.infoPos[i];
			}
		}
		_ = LuminApplication.LogEnabled;
		return Vector3.zero;
	}
}
