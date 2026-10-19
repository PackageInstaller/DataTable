using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取战斗队伍存活角色数量", "Function", new string[] { "get", "battle", "team", "character", "alive", "count", "value", "float", "int" })]
public class GetBattleTeamCharacterAliveCount : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		int num = 0;
		for (int i = 0; i < 3; i++)
		{
			if (MonoECS.instance.localPlayer.GetTeamCharacter(i).IsAlive())
			{
				num++;
			}
		}
		return num;
	}
}
