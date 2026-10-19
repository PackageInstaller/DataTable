using System;
using ACT.Game;

namespace ACT.UI;

public class TeamViewData : UIViewData
{
	public bool isRaidTeam;

	public int enterId;

	public int raidId;

	public int multiple;

	public bool bossChallenge;

	public int index;

	public int bossPoint;

	public TeamProfileSource source;

	public int[] subWorldCharacters;

	public int potionId;

	public Action closeAction;

	public int templeId;

	public int choseTeamIndex = G.localPlayer.teamInfo.MainTeamIdx;

	public int RecommendLevel = -1;
}
