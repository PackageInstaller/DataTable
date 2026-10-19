using ACT.World.Asset;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取伤害区域技能持续时间", "Function", new string[] { "damage", "area", "ability", "duration" })]
public class FunctionDamageAreaAbilityDuration : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		return ((WalkureDamageAreaData)(memory.owner.GetCompStateObject()?.StateWorldAssetData))?.DamageAbilityDuration ?? 0f;
	}
}
