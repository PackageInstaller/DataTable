using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改架势Progress", "Action", new string[] { "change", "posture", "progress", "damage", "hit", "attack" })]
public class ActionChangePostureProgress : ConfigAction
{
	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().ServerSetRevivePostureProgress(value.Return(memory));
	}
}
