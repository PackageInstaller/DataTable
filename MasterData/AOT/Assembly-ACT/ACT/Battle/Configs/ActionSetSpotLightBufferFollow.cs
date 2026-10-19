using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置SpotLightBuffer跟随", "Action", new string[] { "set", "spot", "light", "buffer", "follow" })]
public class ActionSetSpotLightBufferFollow : ConfigAction
{
	public bool follow;

	public ConfigFunction<float> velocity;

	public ConfigFunction<float> followTime;

	public override void Do(ActionMemory memory)
	{
		if (memory.target.IsValid && memory.target.entity.TryGetCompSpotLightBuffer(out CompSpotLightBuffer component))
		{
			Singleton<GameManager>.instance.ecsManager.systemSpotLightBuffer.SetFollowPlayer(memory.target.entity, component, follow, followTime.Return(memory), velocity.Return(memory));
		}
	}
}
