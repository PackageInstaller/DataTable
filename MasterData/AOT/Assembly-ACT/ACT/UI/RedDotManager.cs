using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;
using Google.Protobuf.Collections;

namespace ACT.UI;

public class RedDotManager : Singleton<RedDotManager>
{
	public class RedDotData
	{
		public string path;

		public bool isactive;
	}

	private readonly RedDotTrie redDotTrie;

	private readonly HashSet<string> registeredPaths;

	public Dictionary<int, List<RedDotData>> systemOpenRedDots = new Dictionary<int, List<RedDotData>>();

	public event Action<string, bool> OnRedDotStateChanged;

	public RedDotManager()
	{
		redDotTrie = new RedDotTrie();
		registeredPaths = new HashSet<string>();
	}

	public override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemUnLock);
		InitTrieNode();
	}

	public override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemUnLock);
		ClearAllRedDots();
	}

	private void OnSystemUnLock(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt systemOpenEvt && systemOpenRedDots.TryGetValue(systemOpenEvt.systemId, out var value))
		{
			systemOpenRedDots.Remove(systemOpenEvt.systemId);
			for (int i = 0; i < value.Count; i++)
			{
				StaticRegisterInitTrieNode(value[i].path, value[i].isactive);
			}
		}
	}

	public void InitCharacterTrieNode(MapField<int, bool> CharactersReds)
	{
		if (CharactersReds == null)
		{
			return;
		}
		foreach (KeyValuePair<int, bool> CharactersRed in CharactersReds)
		{
			string nodeFullPath = string.Format(RedDotPathDefine.CharacterNew, CharactersRed.Key);
			StaticRegisterInitTrieNode(nodeFullPath, CharactersRed.Value, 1017);
		}
	}

	public void InitMapExploreTrieNode(MapField<int, AreaExploreRedPoint> MapExploreReds)
	{
		if (MapExploreReds == null)
		{
			return;
		}
		foreach (AreaExploreRedPoint value in MapExploreReds.Values)
		{
			int id = value.Id;
			string text = "";
			if (value.Typ == 2)
			{
				id = MapUtility.GetAreaBySubArea(value.Id);
				text = string.Format(RedDotPathDefine.MapExploreReward + "|{1}|IsNew", id, value.Id);
			}
			else
			{
				text = string.Format(RedDotPathDefine.MapExploreReward + "|IsNew", id);
			}
			if (Singleton<RedDotManager>.instance.IsPathRegistered(text))
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(text, value.Show);
			}
			else
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(text, value.Show, 1028);
			}
		}
	}

	public void InitAccountDecorationTrieNode(MapField<int, bool> redPoints, string pathFormat, int systemId)
	{
		if (redPoints == null || string.IsNullOrEmpty(pathFormat))
		{
			return;
		}
		foreach (KeyValuePair<int, bool> redPoint in redPoints)
		{
			string nodeFullPath = string.Format(pathFormat, redPoint.Key);
			if (Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, redPoint.Value);
			}
			else
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, redPoint.Value, systemId);
			}
		}
	}

	public bool GeCharacterTabRedpointState(int characterId)
	{
		if (G.localPlayer.redPoints.Characters.TryGetValue(characterId, out var value))
		{
			return value;
		}
		return false;
	}

	public void InitTrieNode()
	{
		try
		{
			RegisterStaticNodes(new string[1] { RedDotPathDefine.GaCha });
			RegisterStaticNodes(new string[4]
			{
				RedDotPathDefine.HasLegendMission,
				RedDotPathDefine.HasInventory,
				RedDotPathDefine.HasDailyReward,
				RedDotPathDefine.HasExtraReward
			}, active: false, 1008);
			StaticRegisterInitTrieNode(RedDotPathDefine.HasQuestionnaire, active: false, 7001);
			StaticRegisterInitTrieNode(RedDotPathDefine.HasFeedback, active: false, 7002);
			StaticRegisterInitTrieNode(RedDotPathDefine.HasAbyssReward, active: false, 1015);
			RegisterStaticNodes(new string[7]
			{
				RedDotPathDefine.SewerTempleReward,
				RedDotPathDefine.ArumTempleReward,
				RedDotPathDefine.TepcTempleReward,
				RedDotPathDefine.CraterTempleReward,
				RedDotPathDefine.ArsenalTempleReward,
				RedDotPathDefine.VoidTempleReward,
				RedDotPathDefine.WalkureTempleReward
			});
			RegisterStaticNodes(new string[1] { RedDotPathDefine.HasUnReadMail });
			RegisterStaticNodes(new string[6]
			{
				RedDotPathDefine.HasUnReadTutorial,
				RedDotPathDefine.TutorialUnReadAll,
				RedDotPathDefine.TutorialUnReadBattle,
				RedDotPathDefine.TutorialUnReadMonster,
				RedDotPathDefine.TutorialUnReadSystem,
				RedDotPathDefine.TutorialUnReadExplore
			});
			RegisterStaticNodes(new string[4]
			{
				RedDotPathDefine.SystemGuide,
				RedDotPathDefine.SystemGuideTab,
				RedDotPathDefine.SystemGuideLevelReward,
				RedDotPathDefine.SystemGuideChapterReward
			});
			RegisterStaticNodes(new string[1] { RedDotPathDefine.WorldLevelTab });
			RegisterStaticNodes(new string[8]
			{
				RedDotPathDefine.ActivityCenter,
				RedDotPathDefine.Activity_PlayerLevel,
				RedDotPathDefine.Activity_TotalRecharge,
				RedDotPathDefine.Activity_OneTreat,
				RedDotPathDefine.Activity_OneTreatTask,
				RedDotPathDefine.Activity_OneTreatMain,
				RedDotPathDefine.Activity_MainlineMotivation,
				RedDotPathDefine.Activity_LimitedTimeMapExploration
			});
			RegisterStaticNodes(new string[1] { RedDotPathDefine.SNSMain });
			RegisterStaticNodes(new string[1] { RedDotPathDefine.Map });
			RegisterStaticNodes(new string[1] { RedDotPathDefine.Rogue });
			RegisterStaticNodes(new string[1] { RedDotPathDefine.Lounge });
			RegisterStaticNodes(new string[8]
			{
				RedDotPathDefine.Treasure,
				RedDotPathDefine.Treasure_Precious,
				RedDotPathDefine.Treasure_Fragmented,
				RedDotPathDefine.Treasure_WaterfallSeal,
				RedDotPathDefine.Treasure_Relic,
				RedDotPathDefine.Treasure_BygoneOldObject,
				RedDotPathDefine.Treasure_LeftOver,
				RedDotPathDefine.Treasure_EnergyControl
			});
			RegisterStaticNodes(new string[5]
			{
				RedDotPathDefine.Character,
				RedDotPathDefine.CharacterOver,
				RedDotPathDefine.CharacterEquipment,
				RedDotPathDefine.CharacterSkill,
				RedDotPathDefine.CharacterElite
			});
			Dictionary<string, bool> dictionary = new Dictionary<string, bool>();
			dictionary.Add(RedDotPathDefine.CharacterOver, value: false);
			dictionary.Add(RedDotPathDefine.CharacterEquipment, value: false);
			dictionary.Add(RedDotPathDefine.CharacterSkill, value: false);
			dictionary.Add(RedDotPathDefine.CharacterElite, value: false);
			SetMultipleRedDots(dictionary);
			RegisterStaticNodes(new string[5]
			{
				RedDotPathDefine.EscMore,
				RedDotPathDefine.AccountDecoration,
				RedDotPathDefine.AccountDecorationAvatar,
				RedDotPathDefine.AccountDecorationAvatarFrame,
				RedDotPathDefine.AccountDecorationTitle
			}, active: false, 1054);
			RegisterStaticNodes(new string[1] { RedDotPathDefine.EscBattlePass }, active: false, 1044);
			RegisterStaticNodes(new string[4]
			{
				RedDotPathDefine.BattlePassRewardTab,
				RedDotPathDefine.BattlePassTaskTab,
				RedDotPathDefine.BattlePassDailyTask,
				RedDotPathDefine.BattlePassRoundTask
			});
			RegisterStaticNodes(new string[11]
			{
				RedDotPathDefine.NewAccomplishment,
				RedDotPathDefine.NewAccomplishmentTask,
				RedDotPathDefine.NewAccomplishmentExplore,
				RedDotPathDefine.NewAccomplishmentBattle,
				RedDotPathDefine.NewAccomplishmentCultivate,
				RedDotPathDefine.NewAccomplishmentOther,
				RedDotPathDefine.NewAccomplishmentTaskTab,
				RedDotPathDefine.NewAccomplishmentExploreTab,
				RedDotPathDefine.NewAccomplishmentBattleTab,
				RedDotPathDefine.NewAccomplishmentCultivateTab,
				RedDotPathDefine.NewAccomplishmentOtherTab
			});
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private void RegisterStaticNodes(string[] paths, bool active = false, int systemid = 0)
	{
		foreach (string nodeFullPath in paths)
		{
			StaticRegisterInitTrieNode(nodeFullPath, active, systemid);
		}
	}

	public bool StaticRegisterInitTrieNode(string nodeFullPath, bool active = false, int systemId = 0)
	{
		if (systemId != 0 && !Singleton<SystemUnlockManager>.instance.IsSystemUnlock(systemId))
		{
			if (systemOpenRedDots.TryGetValue(systemId, out var value))
			{
				value.Add(new RedDotData
				{
					path = nodeFullPath,
					isactive = active
				});
			}
			else
			{
				systemOpenRedDots[systemId] = new List<RedDotData>
				{
					new RedDotData
					{
						path = nodeFullPath,
						isactive = active
					}
				};
			}
			_ = LuminApplication.LogEnabled;
			return false;
		}
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		if (IsPathRegistered(nodeFullPath))
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		try
		{
			AddNode(nodeFullPath);
			SetLeafNodeActive(nodeFullPath, active);
			registeredPaths.Add(nodeFullPath);
			return true;
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
	}

	public bool DynamicRegisterInitTrieNode(string nodeFullPath, bool active = false, int systemId = 0)
	{
		if (systemId != 0 && !Singleton<SystemUnlockManager>.instance.IsSystemUnlock(systemId))
		{
			if (systemOpenRedDots.TryGetValue(systemId, out var value))
			{
				value.Add(new RedDotData
				{
					path = nodeFullPath,
					isactive = active
				});
			}
			else
			{
				systemOpenRedDots[systemId] = new List<RedDotData>
				{
					new RedDotData
					{
						path = nodeFullPath,
						isactive = active
					}
				};
			}
			_ = LuminApplication.LogEnabled;
			return false;
		}
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		try
		{
			AddNode(nodeFullPath);
			SetLeafNodeActive(nodeFullPath, active);
			registeredPaths.Add(nodeFullPath);
			return true;
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
	}

	public RedDotTrieNode GetNode(string nodeFullPath)
	{
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			_ = LuminApplication.LogEnabled;
			return null;
		}
		return redDotTrie.GetNode(nodeFullPath);
	}

	public RedDotTrieNode GetNode(List<string> nodeFullPathList)
	{
		if (nodeFullPathList == null || nodeFullPathList.Count == 0)
		{
			_ = LuminApplication.LogEnabled;
			return null;
		}
		return redDotTrie.GetNode(nodeFullPathList);
	}

	private RedDotTrieNode AddNode(string nodeFullPath)
	{
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			throw new ArgumentException("红点路径不能为空");
		}
		return redDotTrie.AddNode(nodeFullPath);
	}

	public bool RemoveNode(string nodeFullPath)
	{
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		try
		{
			redDotTrie.RemoveNode(nodeFullPath);
			return true;
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
	}

	public void RemoveRegisteredPaths(string fullpath)
	{
		registeredPaths.Remove(fullpath);
	}

	public void SetLeafNodeActive(string nodeFullPath, bool active)
	{
		if (!string.IsNullOrEmpty(nodeFullPath) && !IsInSystemRedDot(nodeFullPath, active) && IsLeafNodeActive(nodeFullPath) != active)
		{
			redDotTrie.SetLeafNodeActive(nodeFullPath, active);
			OnRedDotStateChanged?.Invoke(nodeFullPath, active);
			ReportLeafNodeChanged(nodeFullPath, active);
		}
	}

	private void ReportLeafNodeChanged(string nodeFullPath, bool active)
	{
		RedDotEvent evt = EventTrackSolver.Instance.GetEvt<RedDotEvent>();
		evt.redDotPath = nodeFullPath;
		evt.status = (active ? 1 : 2);
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private bool IsInSystemRedDot(string nodeFullPath, bool active)
	{
		foreach (KeyValuePair<int, List<RedDotData>> systemOpenRedDot in systemOpenRedDots)
		{
			for (int i = 0; i < systemOpenRedDot.Value.Count; i++)
			{
				if (nodeFullPath.Equals(systemOpenRedDot.Value[i].path))
				{
					systemOpenRedDot.Value[i].isactive = active;
					return true;
				}
			}
		}
		return false;
	}

	public bool IsLeafNodeActive(string nodeFullPath)
	{
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			return false;
		}
		return redDotTrie.LeafNodeIsActive(nodeFullPath);
	}

	public bool IsNodeActive(string nodeFullPath)
	{
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			return false;
		}
		return redDotTrie.NodeIsActive(nodeFullPath);
	}

	public bool IsPathRegistered(string nodeFullPath)
	{
		if (!string.IsNullOrEmpty(nodeFullPath))
		{
			return GetNode(nodeFullPath) != null;
		}
		return false;
	}

	public IReadOnlyCollection<string> GetAllRegisteredPaths()
	{
		return registeredPaths;
	}

	public string DumpRegisteredRedDotsTree(string activeColor = "#5BD46D", string inactiveColor = "#9A9A9A")
	{
		StringBuilder stringBuilder = new StringBuilder(512);
		RedDotTrieNode rootNode = redDotTrie.rootNode;
		stringBuilder.AppendLine("[RedDotTree]");
		if (rootNode == null)
		{
			stringBuilder.AppendLine("<color=#FF4D4F>Root is null</color>");
			return stringBuilder.ToString();
		}
		stringBuilder.AppendLine(FormatNodeWithColor(rootNode.nodeName, rootNode.isActive, activeColor, inactiveColor) ?? "");
		List<RedDotTrieNode> list = rootNode.childNodeDic.Values.OrderBy((RedDotTrieNode n) => n.nodeName).ToList();
		for (int num = 0; num < list.Count; num++)
		{
			AppendNodeTree(stringBuilder, list[num], "", num == list.Count - 1, activeColor, inactiveColor);
		}
		return stringBuilder.ToString();
	}

	public void LogRegisteredRedDotsTree(string activeColor = "#5BD46D", string inactiveColor = "#9A9A9A")
	{
		DumpRegisteredRedDotsTree(activeColor, inactiveColor);
		_ = LuminApplication.LogEnabled;
	}

	private void AppendNodeTree(StringBuilder builder, RedDotTrieNode node, string prefix, bool isLast, string activeColor, string inactiveColor)
	{
		if (node != null)
		{
			string value = (isLast ? "└─ " : "├─ ");
			builder.Append(prefix).Append(value).AppendLine(FormatNodeWithColor(node.nodeName, node.isActive, activeColor, inactiveColor));
			List<RedDotTrieNode> list = node.childNodeDic.Values.OrderBy((RedDotTrieNode n) => n.nodeName).ToList();
			string prefix2 = prefix + (isLast ? "   " : "│  ");
			for (int num = 0; num < list.Count; num++)
			{
				AppendNodeTree(builder, list[num], prefix2, num == list.Count - 1, activeColor, inactiveColor);
			}
		}
	}

	private static string FormatNodeWithColor(string nodeName, bool isActive, string activeColor, string inactiveColor)
	{
		string text = (isActive ? activeColor : inactiveColor);
		string text2 = (isActive ? "ACTIVE" : "INACTIVE");
		return "<color=" + text + ">" + nodeName + "</color> <color=" + text + ">[" + text2 + "]</color>";
	}

	public void ClearAllRedDots()
	{
		RedDotTrieNode[] array = redDotTrie.rootNode.childNodeDic.Values.ToArray();
		for (int num = array.Length - 1; num >= 0; num--)
		{
			SetLeafNodeActive(array[num].nodeName, active: false);
			RemoveNode(array[num].nodeName);
		}
		if (registeredPaths.Count > 0)
		{
			foreach (string registeredPath in registeredPaths)
			{
				registeredPaths.Remove(registeredPath);
			}
		}
		if (systemOpenRedDots.Count > 0)
		{
			systemOpenRedDots.Clear();
		}
	}

	public void SetMultipleRedDots(Dictionary<string, bool> stateMap)
	{
		if (stateMap == null)
		{
			return;
		}
		foreach (KeyValuePair<string, bool> item in stateMap)
		{
			SetLeafNodeActive(item.Key, item.Value);
		}
	}

	public void RefreshUnLockSystemRedDot(int systemId)
	{
		if ((RuntimeConfigs.data.systemOpens.TryGetValue(systemId, out var value) && !value.systemUnlockPrompts) || !(G.localPlayer.redPoints.Systems.TryGetValue(systemId, out var value2) & value2))
		{
			return;
		}
		RedPoints redPoints = new RedPoints();
		redPoints.Systems[systemId] = false;
		G.service.RefreshRedDot(redPoints, (bool b) =>
		{
			if (b)
			{
				G.localPlayer.redPoints.Systems[systemId] = false;
				RefreshSystemUnlockRedDot evt = Singleton<EventManager>.instance.GetEvt<RefreshSystemUnlockRedDot>();
				evt.systemId = systemId;
				evt.isActive = false;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshHUDSystemOpenRedDot, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		});
	}
}
