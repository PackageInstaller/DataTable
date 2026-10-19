using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;

namespace ACT.Utility;

public static class GameWorldUtility
{
	private sealed class GameWorldEnterData
	{
		public SceneStatus TargetSceneStatus;

		public int RaidId;

		public int TempleId;

		public int AbyssStageIndex;

		public int AbyssGroupId;

		public List<TeamUsage> AbyssTeamUsages;

		public TeamUsage TeamUsage;

		public int TrainingWorldId;

		public int TrainingSceneId;
	}

	private static bool _isSwitching;

	private static GameWorld GetGameWorldDataByWorldId(int worldId)
	{
		if (RuntimeConfigs.data.gameWorlds.TryGetValue(worldId, out var value))
		{
			return value;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"找不到id为：{worldId}的GameWorld表数据");
		}
		return null;
	}

	private static GameWorld GetGameWorldDataBySceneId(int sceneId)
	{
		foreach (GameWorld value in RuntimeConfigs.data.gameWorlds.Values)
		{
			if (value.config == sceneId)
			{
				return value;
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"找不到SceneId为：{sceneId}的GameWorld表数据");
		}
		return null;
	}

	public static void EnterGameWorldByWorldId(int worldId)
	{
		SwitchGameWorldAsync(GetGameWorldDataByWorldId(worldId)).Forget();
	}

	public static void EnterGameWorldBySceneId(int sceneId)
	{
		SwitchGameWorldAsync(GetGameWorldDataBySceneId(sceneId)).Forget();
	}

	private static async UniTask SwitchGameWorldAsync(GameWorld gameWorldData)
	{
		if (_isSwitching || !CreateEnterSubWorldData(gameWorldData, out var enterContext))
		{
			return;
		}
		_isSwitching = true;
		try
		{
			SceneStatus sceneStatus = MonoECS.instance.sceneStatus;
			bool needsLeaveCurrentWorld = sceneStatus != SceneStatus.Main;
			if (needsLeaveCurrentWorld)
			{
				if (!(await LeaveCurrentSubWorld(sceneStatus)))
				{
					return;
				}
				await Singleton<GameManager>.instance.worldManager.LeaveWorld();
			}
			if (!(await EnterTargetWorldServiceAsync(enterContext)))
			{
				if (needsLeaveCurrentWorld)
				{
					await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
				}
			}
			else
			{
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(enterContext.TargetSceneStatus);
			}
		}
		finally
		{
			_isSwitching = false;
		}
	}

	private static bool CreateEnterSubWorldData(GameWorld gameWorldData, out GameWorldEnterData enterData)
	{
		enterData = null;
		if (gameWorldData == null)
		{
			return false;
		}
		SceneStatus type = (SceneStatus)gameWorldData.type;
		enterData = new GameWorldEnterData
		{
			TargetSceneStatus = type
		};
		switch (type)
		{
		case SceneStatus.Raid:
		{
			ACT.Config.Raid raidData = GetRaidData(gameWorldData.config);
			if (raidData == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("找不到对应的Raid表数据");
				}
				return false;
			}
			enterData.RaidId = raidData.id;
			GameWorldEnterData obj = enterData;
			int[] tryRole = raidData.tryRole;
			obj.TeamUsage = ((tryRole != null && tryRole.Length > 0) ? Model<RaidModel>.Interface.GetRaidTrialTeamUsage(raidData.id) : CreateMainWorldTeamUsage());
			return true;
		}
		case SceneStatus.Temple:
		{
			InstanceDungeon templeData = GetTempleData(gameWorldData.config);
			if (templeData == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("找不到对应的InstanceDungeon表数据");
				}
				return false;
			}
			enterData.TempleId = templeData.id;
			enterData.TeamUsage = CreateMainWorldTeamUsage();
			return true;
		}
		case SceneStatus.Abyss:
		{
			if (!TryGetAbyssStageData(gameWorldData.id, out var abyssData, out var abyssStageIndex))
			{
				return false;
			}
			TeamUsage teamUsage = CreateMainWorldTeamUsage();
			if (teamUsage.CharacterUsage.Count == 0)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"深渊[{abyssData.id}]上半场没有可上阵角色");
				}
				return false;
			}
			enterData.AbyssStageIndex = abyssStageIndex;
			enterData.AbyssGroupId = Model<AbyssModel>.Interface.GroupId;
			enterData.AbyssTeamUsages = new List<TeamUsage> { teamUsage };
			if (abyssData.subabyss.Length > 1)
			{
				TeamUsage teamUsage2 = CreateAbyssSecondHalfTeamUsage(teamUsage);
				if (teamUsage2.CharacterUsage.Count == 0)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"深渊[{abyssData.id}]下半场没有可上阵角色");
					}
					return false;
				}
				enterData.AbyssTeamUsages.Add(teamUsage2);
			}
			return true;
		}
		case SceneStatus.Trainingground:
			enterData.TrainingWorldId = gameWorldData.id;
			enterData.TrainingSceneId = gameWorldData.config;
			return true;
		default:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"不支持进入类型为[{gameWorldData.type}]的子世界[{gameWorldData.id}]");
			}
			return false;
		}
	}

	private static UniTask<bool> LeaveCurrentSubWorld(SceneStatus sceneStatus)
	{
		UniTaskCompletionSource<bool> complateSource = new UniTaskCompletionSource<bool>();
		switch (sceneStatus)
		{
		case SceneStatus.Raid:
			G.service.LeaveRaid((bool b) =>
			{
				complateSource.TrySetResult(b);
			});
			break;
		case SceneStatus.Temple:
			G.service.LeaveTemple((bool b) =>
			{
				complateSource.TrySetResult(b);
			}, resetData: false);
			break;
		case SceneStatus.Abyss:
			G.service.LeaveAbyss((bool b) =>
			{
				complateSource.TrySetResult(b);
			});
			break;
		case SceneStatus.Trainingground:
			G.service.LeaveTrainingGround((bool b) =>
			{
				complateSource.TrySetResult(b);
			});
			break;
		default:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"不支持离开类型为[{sceneStatus}]的子世界");
			}
			complateSource.TrySetResult(result: false);
			break;
		}
		return complateSource.Task;
	}

	private static UniTask<bool> EnterTargetWorldServiceAsync(GameWorldEnterData enterData)
	{
		UniTaskCompletionSource<bool> complateSource = new UniTaskCompletionSource<bool>();
		switch (enterData.TargetSceneStatus)
		{
		case SceneStatus.Raid:
			G.service.RaidEnterInfo(enterData.RaidId, enterData.TeamUsage, (bool b) =>
			{
				complateSource.TrySetResult(b);
			}, enterByGM: true);
			break;
		case SceneStatus.Temple:
			if (!Model<TempleModel>.Interface.IsTempleUnlocked(enterData.TempleId))
			{
				G.service.UnlockTemple(enterData.TempleId, (bool b) =>
				{
					Model<TempleModel>.Interface.OnTempleUnlocked(enterData.TempleId);
					G.service.EnterTempleChallenge(enterData.TempleId, enterData.TeamUsage, (bool result) =>
					{
						complateSource.TrySetResult(result);
					});
				});
			}
			else
			{
				G.service.EnterTempleChallenge(enterData.TempleId, enterData.TeamUsage, (bool b) =>
				{
					complateSource.TrySetResult(b);
				});
			}
			break;
		case SceneStatus.Abyss:
			G.service.AbyssEnter(enterData.AbyssStageIndex, enterData.AbyssGroupId, enterData.AbyssTeamUsages, (bool b) =>
			{
				complateSource.TrySetResult(b);
			}, enterByGM: true);
			break;
		case SceneStatus.Trainingground:
			Model<TrainingGroundModel>.Interface.enemyConfig.worldId = enterData.TrainingWorldId;
			Model<TrainingGroundModel>.Interface.enemyConfig.sceneId = enterData.TrainingSceneId;
			G.service.EnterTrainingGround((bool b) =>
			{
				complateSource.TrySetResult(b);
			});
			break;
		default:
			complateSource.TrySetResult(result: false);
			break;
		}
		return complateSource.Task;
	}

	private static TeamUsage CreateMainWorldTeamUsage()
	{
		TeamUsage teamUsage = CreateEmptyTeamUsage();
		TeamInfo teamInfo = G.localPlayer?.teamInfo;
		if (teamInfo == null || teamInfo.MainTeamIdx < 0 || teamInfo.MainTeamIdx >= teamInfo.PresetTeams.Count)
		{
			return teamUsage;
		}
		PresetTeam presetTeam = teamInfo.PresetTeams[teamInfo.MainTeamIdx];
		for (int i = 0; i < presetTeam.CharacterIds.Count && i < BattleConsts.TEAMCAPITAL; i++)
		{
			int num = presetTeam.CharacterIds[i];
			if (num > 0)
			{
				teamUsage.CharacterUsage.Add(new TeamCharacterUsage
				{
					CharacterId = num,
					IsTrial = false
				});
			}
		}
		return teamUsage;
	}

	private static TeamUsage CreateAbyssSecondHalfTeamUsage(TeamUsage firstHalfTeamUsage)
	{
		HashSet<int> hashSet = new HashSet<int>();
		foreach (TeamCharacterUsage item in firstHalfTeamUsage.CharacterUsage)
		{
			if (item.CharacterId > 0)
			{
				hashSet.Add(item.CharacterId);
			}
		}
		TeamUsage teamUsage = CreateEmptyTeamUsage();
		MapField<int, CharacterRepository> mapField = G.localPlayer?.characterRepository;
		if (mapField == null || !mapField.TryGetValue(0, out var value))
		{
			return teamUsage;
		}
		foreach (Character value2 in value.Characters.Values)
		{
			if (value2 == null || value2.Id <= 0 || hashSet.Contains(value2.Id))
			{
				continue;
			}
			EntityCharacterData data = CoreUtils.GetData(value2.Id, RuntimeConfigs.data.entityCharacterDatas);
			if (data == null || !data.isProtagonist)
			{
				teamUsage.CharacterUsage.Add(new TeamCharacterUsage
				{
					CharacterId = value2.Id,
					IsTrial = false
				});
				if (teamUsage.CharacterUsage.Count >= BattleConsts.TEAMCAPITAL)
				{
					break;
				}
			}
		}
		return teamUsage;
	}

	private static TeamUsage CreateEmptyTeamUsage()
	{
		return new TeamUsage
		{
			BattleCharacterIdx = 0,
			EquipPotionId = 0
		};
	}

	private static bool TryGetAbyssStageData(int subAbyssWorldId, out AbyssData abyssData, out int abyssStageIndex)
	{
		abyssData = null;
		abyssStageIndex = -1;
		if (!RuntimeConfigs.data.subabyssDatas.ContainsKey(subAbyssWorldId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"找不到子深渊[{subAbyssWorldId}]的表数据");
			}
			return false;
		}
		if (!RuntimeConfigs.data.abyssGroupDatas.TryGetValue(Model<AbyssModel>.Interface.GroupId, out var value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"找不到当前深渊期数[{Model<AbyssModel>.Interface.GroupId}]的表数据");
			}
			return false;
		}
		for (int i = 0; i < value.abyssInclude.Length; i++)
		{
			if (!RuntimeConfigs.data.abyssDatas.TryGetValue(value.abyssInclude[i], out var value2))
			{
				continue;
			}
			int[] subabyss = value2.subabyss;
			for (int j = 0; j < subabyss.Length; j++)
			{
				if (subabyss[j] == subAbyssWorldId)
				{
					abyssData = value2;
					abyssStageIndex = i;
					return true;
				}
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"当前深渊期数[{Model<AbyssModel>.Interface.GroupId}]中不包含子深渊[{subAbyssWorldId}]");
		}
		return false;
	}

	private static ACT.Config.Raid GetRaidData(int sceneId)
	{
		return RuntimeConfigs.data.raids.Values.FirstOrDefault((ACT.Config.Raid data) => data.sceneId == sceneId);
	}

	private static InstanceDungeon GetTempleData(int sceneId)
	{
		return RuntimeConfigs.data.instanceDungeons.Values.FirstOrDefault((InstanceDungeon data) => data.senceid == sceneId);
	}
}
