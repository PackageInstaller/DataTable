using ACT.Battle;
using Bamboo.ECS;

namespace ACT.EventTrack;

public static class TrackEvtUtils
{
	public static int CharacterDieCount()
	{
		MonoECS instance = MonoECS.instance;
		int num = 0;
		for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
		{
			Entity teamCharacter = instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				num += ((!teamCharacter.GetCompAbility().alive) ? 1 : 0);
			}
		}
		return num;
	}
}
