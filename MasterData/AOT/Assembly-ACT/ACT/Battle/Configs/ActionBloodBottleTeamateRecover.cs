using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行血瓶队友", "Action", new string[] { "blood", "bottle", "teamate", "recover", "heal", "hp" })]
public class ActionBloodBottleTeamateRecover : ConfigAction
{
	public ConfigFunction<float> getBloodBottleRecoverHPCount;

	public DynamicFloat cost;

	public DynamicFloat Present;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is UseBloodBottle)
		{
			float num = getBloodBottleRecoverHPCount.Return(memory) * Present.GetFloat(memory.ability) + cost.GetFloat(memory.ability);
			Entity switchCharacter = MPPlayer.local.GetSwitchCharacter(0);
			Entity switchCharacter2 = MPPlayer.local.GetSwitchCharacter(1);
			if (switchCharacter.IsValid)
			{
				switchCharacter.GetCompAbility().Recover((int)num, checkAlive: false);
			}
			if (switchCharacter2.IsValid)
			{
				switchCharacter2.GetCompAbility().Recover((int)num, checkAlive: false);
			}
		}
	}
}
