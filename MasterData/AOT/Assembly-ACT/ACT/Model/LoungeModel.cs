using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;

namespace ACT.Model;

public class LoungeModel : Model<LoungeModel>
{
	private Dictionary<int, LoungePoint> m_indexToCharacter = new Dictionary<int, LoungePoint>();

	private Dictionary<int, int> m_characterToIndex = new Dictionary<int, int>();

	private Dictionary<int, bool> triggeredStories = new Dictionary<int, bool>();

	private readonly Dictionary<int, LoungeCharacterGreetInfo> m_greetInfo = new Dictionary<int, LoungeCharacterGreetInfo>();

	private int curGlobalStoryId;

	private int todayInvitationCount;

	public int DailySentCharacterGiftCount => G.localPlayer.DailyData.DailySentCharacterGiftCount;

	public int CurGlobalStoryId
	{
		get
		{
			return curGlobalStoryId;
		}
		set
		{
			curGlobalStoryId = value;
		}
	}

	public Dictionary<int, LoungePoint> IndexToCharacter => m_indexToCharacter;

	public int TodayInvitationCount
	{
		get
		{
			return todayInvitationCount;
		}
		set
		{
			todayInvitationCount = value;
		}
	}

	public Dictionary<int, int> CharacterToIndex => m_characterToIndex;

	public Dictionary<int, bool> TriggeredStories => triggeredStories;

	public IReadOnlyDictionary<int, LoungeCharacterGreetInfo> GreetInfo => m_greetInfo;

	public int MaxConditionGreetCountPerDay => RuntimeConfigs.data.game.loungereGreetConditionNum;

	public int MaxCommonGreetCountPerDay => RuntimeConfigs.data.game.loungereGreetCommonNum;

	public (int, int) GetCharacterFavorInfo(int characterId)
	{
		if (Model<FavorabilityModel>.Interface.CharacterFavorInfoDic.TryGetValue(characterId, out var value))
		{
			return (value.LikeabilityLevel, value.LikeabilityExp);
		}
		if (CharacterDataHelper.TryGetBagCharacterById(characterId, out var character))
		{
			return (character.LikeabilityLevel, character.LikeabilityExp);
		}
		return (1, 0);
	}

	public void OnLoungeNtf(Lounge loungeInfo)
	{
		if (loungeInfo == null)
		{
			return;
		}
		if (loungeInfo.TriggeredStories.Count > 0)
		{
			foreach (int key in loungeInfo.TriggeredStories.Keys)
			{
				if (triggeredStories.TryGetValue(key, out var _))
				{
					triggeredStories[key] = loungeInfo.TriggeredStories[key];
				}
				else
				{
					triggeredStories.Add(key, loungeInfo.TriggeredStories[key]);
				}
			}
		}
		if (loungeInfo.CurrentGlobalStoryID != 0)
		{
			curGlobalStoryId = loungeInfo.CurrentGlobalStoryID;
		}
		if (loungeInfo.TodayInvitationCount != 0)
		{
			todayInvitationCount = loungeInfo.TodayInvitationCount;
		}
		SyncGreetInfo(loungeInfo);
		if (loungeInfo.LoungeInteractPoints.Count <= 0)
		{
			return;
		}
		foreach (int key2 in loungeInfo.LoungeInteractPoints.Keys)
		{
			if (m_indexToCharacter.ContainsKey(key2))
			{
				m_indexToCharacter[key2].character.Clear();
				m_indexToCharacter[key2].character.AddRange(loungeInfo.LoungeInteractPoints[key2].Character);
				m_indexToCharacter[key2].id = key2;
				m_indexToCharacter[key2].performID = loungeInfo.LoungeInteractPoints[key2].PerformID;
				m_indexToCharacter[key2].idleID = loungeInfo.LoungeInteractPoints[key2].IdleID;
				m_indexToCharacter[key2].waitStory = loungeInfo.LoungeInteractPoints[key2].WaitStory;
				m_indexToCharacter[key2].useType = loungeInfo.LoungeInteractPoints[key2].UseType;
				m_indexToCharacter[key2].name = CoreUtils.GetData(key2, RuntimeConfigs.data.pointLists).name;
			}
			else
			{
				LoungePoint loungePoint = new LoungePoint();
				loungePoint.character.AddRange(loungeInfo.LoungeInteractPoints[key2].Character);
				loungePoint.id = key2;
				loungePoint.performID = loungeInfo.LoungeInteractPoints[key2].PerformID;
				loungePoint.idleID = loungeInfo.LoungeInteractPoints[key2].IdleID;
				loungePoint.waitStory = loungeInfo.LoungeInteractPoints[key2].WaitStory;
				loungePoint.useType = loungeInfo.LoungeInteractPoints[key2].UseType;
				loungePoint.name = CoreUtils.GetData(key2, RuntimeConfigs.data.pointLists).name;
				m_indexToCharacter.Add(key2, loungePoint);
			}
			foreach (int item in loungeInfo.LoungeInteractPoints[key2].Character)
			{
				if (!m_characterToIndex.ContainsKey(item))
				{
					m_characterToIndex[item] = loungeInfo.LoungeInteractPoints[key2].Id;
				}
			}
		}
	}

	public void CreateTempData(int characterId, int idKey)
	{
		if (characterId == 0)
		{
			if (m_indexToCharacter.ContainsKey(idKey))
			{
				m_indexToCharacter[idKey].character.Clear();
				m_indexToCharacter[idKey].id = idKey;
				m_indexToCharacter[idKey].performID = 0;
				m_indexToCharacter[idKey].performToday = false;
				m_indexToCharacter[idKey].waitStory = 0;
				m_indexToCharacter[idKey].useType = LoungeInteractPointUseType.LoungeInteractPointUseEmpty;
			}
			else
			{
				LoungePoint loungePoint = new LoungePoint();
				loungePoint.character.Clear();
				loungePoint.id = idKey;
				loungePoint.performID = 0;
				loungePoint.performToday = false;
				loungePoint.waitStory = 0;
				loungePoint.useType = LoungeInteractPointUseType.LoungeInteractPointUseEmpty;
				m_indexToCharacter.Add(idKey, loungePoint);
			}
		}
		else if (m_indexToCharacter.ContainsKey(idKey))
		{
			m_indexToCharacter[idKey].character.Clear();
			m_indexToCharacter[idKey].character.Add(characterId);
			m_indexToCharacter[idKey].id = idKey;
			m_indexToCharacter[idKey].performID = 0;
			m_indexToCharacter[idKey].performToday = false;
			m_indexToCharacter[idKey].waitStory = 610108;
			m_indexToCharacter[idKey].useType = LoungeInteractPointUseType.LoungeInteractPointUseInvite;
		}
		else
		{
			LoungePoint loungePoint2 = new LoungePoint();
			loungePoint2.character.Add(characterId);
			loungePoint2.id = idKey;
			loungePoint2.performID = 0;
			loungePoint2.performToday = false;
			loungePoint2.waitStory = 610108;
			loungePoint2.useType = LoungeInteractPointUseType.LoungeInteractPointUseInvite;
			m_indexToCharacter.Add(idKey, loungePoint2);
		}
		m_characterToIndex[characterId] = idKey;
	}

	public bool CheckCondition(int condition = 0)
	{
		if (condition == 0)
		{
			return true;
		}
		if (CoreUtils.GetData(condition, RuntimeConfigs.data.missionGroups) != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(condition))
		{
			return true;
		}
		return false;
	}

	protected override void Init()
	{
		m_indexToCharacter = new Dictionary<int, LoungePoint>();
		m_characterToIndex = new Dictionary<int, int>();
		triggeredStories = new Dictionary<int, bool>();
		m_greetInfo.Clear();
		curGlobalStoryId = 0;
		todayInvitationCount = 0;
	}

	protected override void UnInit()
	{
		ClearData();
	}

	public void ClearData()
	{
		m_indexToCharacter.Clear();
		triggeredStories.Clear();
		m_characterToIndex.Clear();
		m_greetInfo.Clear();
		curGlobalStoryId = 0;
		todayInvitationCount = 0;
	}

	private void SyncGreetInfo(Lounge loungeInfo)
	{
		if (loungeInfo.GreetInfo == null || loungeInfo.GreetInfo.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<int, LoungeCharacterGreetInfo> item in loungeInfo.GreetInfo)
		{
			m_greetInfo[item.Key] = item.Value.Clone();
		}
	}

	public bool TryGetCharacterGreetInfo(int characterId, out LoungeCharacterGreetInfo greetInfo)
	{
		return m_greetInfo.TryGetValue(characterId, out greetInfo);
	}

	public bool IsLoungeAllowedCharacter(int characterId)
	{
		foreach (PointList value in RuntimeConfigs.data.pointLists.Values)
		{
			if (value.characterId == null)
			{
				continue;
			}
			int[] characterId2 = value.characterId;
			for (int i = 0; i < characterId2.Length; i++)
			{
				if (characterId2[i] == characterId)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool HasCharacterGreetConfig(int characterId)
	{
		foreach (CharacterGreet value in RuntimeConfigs.data.characterGreets.Values)
		{
			if (value.characterId == characterId)
			{
				return true;
			}
		}
		return false;
	}

	public bool HasRemainingConditionGreet(int characterId)
	{
		if (!TryGetCharacterGreetInfo(characterId, out var greetInfo))
		{
			return MaxConditionGreetCountPerDay > 0;
		}
		return greetInfo.TodayConditionGreetCount < MaxConditionGreetCountPerDay;
	}

	public bool HasRemainingCommonGreet(int characterId)
	{
		if (!TryGetCharacterGreetInfo(characterId, out var greetInfo))
		{
			return MaxCommonGreetCountPerDay > 0;
		}
		return greetInfo.TodayNotConditionGreetCount < MaxCommonGreetCountPerDay;
	}

	public bool HasRemainingGreetQuota(int characterId)
	{
		if (!HasRemainingConditionGreet(characterId))
		{
			return HasRemainingCommonGreet(characterId);
		}
		return true;
	}

	public bool CharacterCanGreet(int characterId)
	{
		if (IsLoungeAllowedCharacter(characterId) && HasCharacterGreetConfig(characterId))
		{
			return HasRemainingGreetQuota(characterId);
		}
		return false;
	}

	public int GetInteractGreetId(int characterId)
	{
		if (TryGetCharacterGreetInfo(characterId, out var greetInfo) && greetInfo.LastNotTriggerGreetID != 0)
		{
			return greetInfo.LastNotTriggerGreetID;
		}
		bool value = default;
		foreach (CharacterGreet value2 in RuntimeConfigs.data.characterGreets.Values)
		{
			if (value2.characterId == characterId && !((TryGetCharacterGreetInfo(characterId, out greetInfo) && greetInfo.TriggeredGreet.TryGetValue(value2.id, out value)) & value) && (value2.missionGroupId == 0 || !CheckCondition(value2.missionGroupId)))
			{
				return value2.id;
			}
		}
		return 0;
	}

	public bool IsCharacterCheckedIn(int characterId)
	{
		if (!CharacterToIndex.TryGetValue(characterId, out var value))
		{
			return false;
		}
		if (!IndexToCharacter.TryGetValue(value, out var value2))
		{
			return false;
		}
		if (value2.character.Contains(characterId))
		{
			if (value2.useType != LoungeInteractPointUseType.LoungeInteractPointUseInvite)
			{
				return value2.useType == LoungeInteractPointUseType.LoungeInteractPointUseRand;
			}
			return true;
		}
		return false;
	}

	public bool TryGetPointCharacterInfo(int pointId, out LoungePoint info)
	{
		return m_indexToCharacter.TryGetValue(pointId, out info);
	}
}
