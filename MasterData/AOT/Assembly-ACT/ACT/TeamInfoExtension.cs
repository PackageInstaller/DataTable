using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using UnityEngine;

namespace ACT;

public class TeamInfoExtension
{
	public static void SetTeamInfo(int teamIndex, TeamUsage teams, int subTeamIdx = 0)
	{
		if (G.localPlayer?.teamInfo?.Teams == null)
		{
			Debug.LogWarning("Cannot set team info: teamInfo or Teams is null");
			return;
		}
		if (!G.localPlayer.teamInfo.Teams.TryGetValue(teamIndex, out var value))
		{
			value = new TeamList();
			G.localPlayer.teamInfo.Teams.Add(teamIndex, value);
		}
		while (value.Teams.Count <= subTeamIdx)
		{
			value.Teams.Add(new Team());
		}
		Team team = value.Teams[subTeamIdx];
		team.CharacterIds.Clear();
		team.ExtraCharacterIds.Clear();
		team.BattleCharacterIdx = 0;
		foreach (TeamCharacterUsage item in teams.CharacterUsage)
		{
			if (item.IsTrial)
			{
				EntityCharacterProbation entityCharacterProbation = RuntimeConfigs.data.entityCharacterProbations[item.CharacterId];
				team.ExtraCharacterIds.Add(entityCharacterProbation.characterId);
			}
			else
			{
				team.CharacterIds.Add(item.CharacterId);
			}
		}
		team.EquipPotionId = teams.EquipPotionId;
		team.EquippedTrialPotion = teams.IsTrialPotion != 0;
	}

	public static void SetTeamInfos(int teamIndex, List<TeamUsage> teams)
	{
		for (int i = 0; i < teams.Count; i++)
		{
			SetTeamInfo(teamIndex, teams[i], i);
		}
	}

	public static void ReleaseTeamInfo(int teamIndex)
	{
		G.localPlayer.teamInfo.Teams.Remove(teamIndex);
	}

	public static List<int> GetTrailCharacterIds(TeamUsage usage)
	{
		List<int> list = new List<int>();
		foreach (TeamCharacterUsage item in usage.CharacterUsage)
		{
			if (item.IsTrial)
			{
				list.Add(item.CharacterId);
			}
		}
		return list;
	}

	public static List<int> GetTrailCharacterIds(List<TeamUsage> usages)
	{
		List<int> list = new List<int>();
		foreach (TeamUsage usage in usages)
		{
			foreach (TeamCharacterUsage item in usage.CharacterUsage)
			{
				if (item.IsTrial)
				{
					list.Add(item.CharacterId);
				}
			}
		}
		return list;
	}

	public static Team GetTeamInfo()
	{
		TeamInfo teamInfo = G.localPlayer.teamInfo;
		int sceneStatus = (int)G.localPlayer.Profile.SceneStatus;
		if (teamInfo.Teams.TryGetValue(sceneStatus, out var value))
		{
			if (GetTeamIdx() < 0)
			{
				Debug.LogWarning($"No snapshot team found for scene status: {sceneStatus}");
				return null;
			}
			return value.Teams[GetTeamIdx()];
		}
		Debug.LogWarning($"No snapshot team found for scene status: {sceneStatus}");
		return null;
	}

	public static int GetTeamIdx()
	{
		int num = 0;
		if (G.localPlayer.Profile.SceneStatus == SceneStatus.Abyss)
		{
			return Model<AbyssModel>.Interface.CurAbyssSubStageIndex;
		}
		return 0;
	}
}
