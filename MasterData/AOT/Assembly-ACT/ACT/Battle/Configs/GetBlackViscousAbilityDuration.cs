using ACT.World.Asset;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取黑粘液技能持续时间", "Function", new string[] { "get", "black", "viscous", "ability", "duration" })]
public class GetBlackViscousAbilityDuration : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		Ability ability = memory.ability;
		Entity entity;
		if (ability != null)
		{
			Entity caster = ability.caster;
			if (caster.IsValid)
			{
				entity = memory.ability.caster;
				goto IL_004c;
			}
		}
		entity = (memory.caster.IsValid ? memory.caster : default(Entity));
		goto IL_004c;
		IL_004c:
		if (entity.GetCompStateObject()?.StateWorldAssetData is IGetBlackViscousAbDuration getBlackViscousAbDuration)
		{
			return getBlackViscousAbDuration.GetAbilityDuration();
		}
		return 0f;
	}
}
