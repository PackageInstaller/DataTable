using System.Collections.Generic;
using System.Linq;
using ACT;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;

namespace Runtime.Model;

public class InviteCharacterModel : Model<InviteCharacterModel>
{
	private int m_currSelectIndex = -1;

	public List<InviteCharacterConfirmPanelData> InviteCharacterList = new List<InviteCharacterConfirmPanelData>();

	public List<TempInviteCharacter> TempInviteCharacterList = new List<TempInviteCharacter>();

	private int singleInviteCharacterPointId;

	public int CurrSelectIndex
	{
		get
		{
			return m_currSelectIndex;
		}
		set
		{
			m_currSelectIndex = value;
		}
	}

	public int SingleInviteCharacterPointId
	{
		get
		{
			return singleInviteCharacterPointId;
		}
		set
		{
			singleInviteCharacterPointId = value;
		}
	}

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		m_currSelectIndex = -1;
		InviteCharacterList?.Clear();
		TempInviteCharacterList?.Clear();
	}

	public List<Character> SortCharactersList(int pointId = 0)
	{
		if (pointId == 0)
		{
			List<Character> bagCharacters = CharacterDataHelper.GetBagCharacters();
			List<Character> list = FilterCharacter(bagCharacters);
			CharacterComparer comparer = new CharacterComparer();
			list.Sort(comparer);
			return list;
		}
		List<Character> bagCharacters2 = CharacterDataHelper.GetBagCharacters();
		int[] characterId = CoreUtils.GetData(pointId, RuntimeConfigs.data.pointLists).characterId;
		List<Character> list2 = new List<Character>();
		int[] array = characterId;
		foreach (int num in array)
		{
			foreach (Character item in bagCharacters2)
			{
				if (item.Id == num)
				{
					list2.Add(item);
					break;
				}
			}
		}
		CharacterComparer comparer2 = new CharacterComparer();
		list2.Sort(comparer2);
		return list2;
	}

	private List<Character> FilterCharacter(List<Character> characters)
	{
		HashSet<int> loungeAllowedCharacterIds = GetLoungeAllowedCharacterIds();
		List<Character> list = new List<Character>(characters.Count);
		foreach (Character character in characters)
		{
			if (loungeAllowedCharacterIds.Contains(character.Id))
			{
				list.Add(character);
			}
		}
		return list;
	}

	private static HashSet<int> GetLoungeAllowedCharacterIds()
	{
		HashSet<int> hashSet = new HashSet<int>();
		foreach (PointList value in RuntimeConfigs.data.pointLists.Values)
		{
			if (value.characterId != null)
			{
				int[] characterId = value.characterId;
				foreach (int item in characterId)
				{
					hashSet.Add(item);
				}
			}
		}
		return hashSet;
	}

	public LoungeInteractPointUseType GetCharacterStateInLounge(int characterId)
	{
		if (Model<LoungeModel>.Interface.CharacterToIndex.TryGetValue(characterId, out var value))
		{
			if (Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(value, out var value2))
			{
				return value2.useType;
			}
			return LoungeInteractPointUseType.LoungeInteractPointUseEmpty;
		}
		return LoungeInteractPointUseType.LoungeInteractPointUseEmpty;
	}

	public int GetStatePriority(LoungeInteractPointUseType useType)
	{
		return useType switch
		{
			LoungeInteractPointUseType.LoungeInteractPointUseEmpty => 0, 
			LoungeInteractPointUseType.LoungeInteractPointUseGlobal => 1, 
			LoungeInteractPointUseType.LoungeInteractPointUseRand => 1, 
			LoungeInteractPointUseType.LoungeInteractPointUseInvite => 2, 
			_ => 3, 
		};
	}

	public InviteCharacterRoomPointEnum GetCharacterRoomPointState(int currSelectCharacterId, int pointId)
	{
		foreach (TempInviteCharacter tempInviteCharacter in TempInviteCharacterList)
		{
			if (pointId == tempInviteCharacter.pointId)
			{
				return InviteCharacterRoomPointEnum.ExistCharacter;
			}
		}
		if (Model<LoungeModel>.Interface.CurGlobalStoryId != 0)
		{
			LoungeStory data = CoreUtils.GetData(Model<LoungeModel>.Interface.CurGlobalStoryId, RuntimeConfigs.data.loungeStorys);
			if (data != null && data.characterId.Contains(currSelectCharacterId))
			{
				return InviteCharacterRoomPointEnum.GlobalStory;
			}
		}
		switch (GetCharacterStateInLounge(currSelectCharacterId))
		{
		case LoungeInteractPointUseType.LoungeInteractPointUseInvite:
		case LoungeInteractPointUseType.LoungeInteractPointUseRand:
		{
			int characterLoungePointId = GetCharacterLoungePointId(currSelectCharacterId);
			if (pointId != characterLoungePointId)
			{
				return InviteCharacterRoomPointEnum.Empty;
			}
			if (Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(pointId, out var value2) && value2.character.Contains(currSelectCharacterId))
			{
				return InviteCharacterRoomPointEnum.ExistCharacter;
			}
			return InviteCharacterRoomPointEnum.Empty;
		}
		case LoungeInteractPointUseType.LoungeInteractPointUseGlobal:
			return InviteCharacterRoomPointEnum.Empty;
		default:
		{
			if (Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(pointId, out var value) && value != null)
			{
				if (value.character.Count == 0)
				{
					return GetEmptyRoomPointState(currSelectCharacterId, (value.id != 0) ? value.id : pointId);
				}
				if (value.useType == LoungeInteractPointUseType.LoungeInteractPointUseInvite)
				{
					return InviteCharacterRoomPointEnum.ExistCharacter;
				}
				return InviteCharacterRoomPointEnum.Empty;
			}
			return GetEmptyRoomPointState(currSelectCharacterId, pointId);
		}
		}
	}

	private InviteCharacterRoomPointEnum GetEmptyRoomPointState(int currSelectCharacterId, int pointId)
	{
		if (!GetCharacterCanEnterPoint(pointId).Contains(currSelectCharacterId))
		{
			return InviteCharacterRoomPointEnum.Forbid;
		}
		foreach (int item in GetStoryListByCharacterId(currSelectCharacterId))
		{
			if (!RuntimeConfigs.data.loungeStorys.TryGetValue(item, out var value))
			{
				continue;
			}
			int[] pointId2 = value.pointId;
			for (int i = 0; i < pointId2.Length; i++)
			{
				if (pointId2[i] == pointId && IsLoungeStoryAvailable(item))
				{
					if (CanShowChatRoomStateOnMap(currSelectCharacterId))
					{
						return InviteCharacterRoomPointEnum.ChatAndStory;
					}
					return InviteCharacterRoomPointEnum.Story;
				}
			}
		}
		if (CanShowChatRoomStateOnMap(currSelectCharacterId))
		{
			return InviteCharacterRoomPointEnum.Chat;
		}
		return InviteCharacterRoomPointEnum.Invite;
	}

	public List<int> GetStoryListByCharacterId(int characterId)
	{
		List<int> list = new List<int>();
		if (RuntimeConfigs.data.characterStoryLists.TryGetValue(characterId, out var value))
		{
			int[] storyId = value.storyId;
			foreach (int item in storyId)
			{
				list.Add(item);
			}
		}
		return list;
	}

	public List<int> GetCharacterCanEnterPoint(int pointId)
	{
		List<int> result = new List<int>();
		PointList data = CoreUtils.GetData(pointId, RuntimeConfigs.data.pointLists);
		if (data != null)
		{
			return data.characterId.ToList();
		}
		return result;
	}

	public bool CurrSelectCharacterIsInTempInviteCharacterList(int characterId)
	{
		int pointId;
		return TryGetTempInvitePointId(characterId, out pointId);
	}

	public bool TryGetTempInvitePointId(int characterId, out int pointId)
	{
		pointId = 0;
		if (TempInviteCharacterList.Count == 0)
		{
			return false;
		}
		foreach (TempInviteCharacter tempInviteCharacter in TempInviteCharacterList)
		{
			if (tempInviteCharacter.characterId == characterId)
			{
				pointId = tempInviteCharacter.pointId;
				return true;
			}
		}
		return Model<LoungeModel>.Interface.CharacterCanGreet(characterId);
	}

	public bool CanShowSideIconForCharacter(int characterId)
	{
		if (!CharacterHasActivePlot(characterId))
		{
			return CharacterHasChatForSideIcon(characterId);
		}
		return true;
	}

	public void ClearTempInviteCharacterList()
	{
		TempInviteCharacterList.Clear();
	}

	private bool IsMissionGroupUnlocked(int missionGroupId)
	{
		if (missionGroupId != 0)
		{
			return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(missionGroupId);
		}
		return true;
	}

	private bool IsLoungeStoryUnlocked(int storyId)
	{
		if (RuntimeConfigs.data.loungeStorys.TryGetValue(storyId, out var value))
		{
			return IsMissionGroupUnlocked(value.missionGroupId);
		}
		return false;
	}

	private bool IsLoungeStoryTriggered(int storyId)
	{
		bool value;
		return Model<LoungeModel>.Interface.TriggeredStories.TryGetValue(storyId, out value) & value;
	}

	private bool IsLoungeStoryAvailable(int storyId)
	{
		if (IsLoungeStoryUnlocked(storyId))
		{
			return !IsLoungeStoryTriggered(storyId);
		}
		return false;
	}

	private bool TryGetCharacterLoungePointData(int characterId, out int pointId, out LoungePoint pointData)
	{
		pointId = 0;
		pointData = null;
		if (!Model<LoungeModel>.Interface.CharacterToIndex.TryGetValue(characterId, out var value))
		{
			return false;
		}
		if (Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(value, out pointData))
		{
			pointId = ((pointData.id != 0) ? pointData.id : value);
			return true;
		}
		foreach (KeyValuePair<int, LoungePoint> item in Model<LoungeModel>.Interface.IndexToCharacter)
		{
			if (item.Value.character.Contains(characterId))
			{
				pointId = ((item.Value.id != 0) ? item.Value.id : item.Key);
				pointData = item.Value;
				return true;
			}
		}
		return false;
	}

	public bool CharacterHasStory(int characterId)
	{
		foreach (int item in GetStoryListByCharacterId(characterId))
		{
			if (IsLoungeStoryAvailable(item))
			{
				return true;
			}
		}
		return false;
	}

	public bool HasUntriggeredStoryAtPoint(int characterId, int pointId)
	{
		foreach (int item in GetStoryListByCharacterId(characterId))
		{
			if (!RuntimeConfigs.data.loungeStorys.TryGetValue(item, out var value) || !IsLoungeStoryAvailable(item))
			{
				continue;
			}
			bool flag = false;
			int[] pointId2 = value.pointId;
			for (int i = 0; i < pointId2.Length; i++)
			{
				if (pointId2[i] == pointId)
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsShowPlotIcon(int characterId, int pointId)
	{
		return HasUntriggeredStoryAtPoint(characterId, pointId);
	}

	public bool IsShowChatIcon(int characterId)
	{
		if (Model<LoungeModel>.Interface.IsCharacterCheckedIn(characterId) && TryGetCharacterLoungePointData(characterId, out var _, out var pointData) && pointData.character.Contains(characterId))
		{
			return pointData.performID != 0;
		}
		return false;
	}

	public bool CanShowChatRoomStateOnMap(int characterId)
	{
		return Model<LoungeModel>.Interface.CharacterCanGreet(characterId);
	}

	public bool CharacterHasActivePlot(int characterId)
	{
		if (Model<LoungeModel>.Interface.CharacterToIndex.ContainsKey(characterId))
		{
			if (TryGetCharacterLoungePointData(characterId, out var _, out var pointData) && pointData.character.Contains(characterId))
			{
				return IsLoungeStoryAvailable(pointData.waitStory);
			}
			return false;
		}
		return CharacterHasStory(characterId);
	}

	public bool CharacterHasChat(int characterId)
	{
		return IsShowChatIcon(characterId);
	}

	public bool HasPlotAtPoint(int characterId, int pointId)
	{
		if (!Model<LoungeModel>.Interface.CharacterToIndex.ContainsKey(characterId))
		{
			return HasUntriggeredStoryAtPoint(characterId, pointId);
		}
		if (!TryGetCharacterLoungePointData(characterId, out var pointId2, out var pointData))
		{
			return false;
		}
		if (pointId2 != pointId)
		{
			return false;
		}
		if (pointData.character.Contains(characterId))
		{
			return IsLoungeStoryAvailable(pointData.waitStory);
		}
		return false;
	}

	public int GetCharacterLoungePointId(int characterId)
	{
		if (Model<LoungeModel>.Interface.CharacterToIndex.TryGetValue(characterId, out var value))
		{
			if (Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(value, out var value2))
			{
				return value2.id;
			}
			return value;
		}
		foreach (KeyValuePair<int, LoungePoint> item in Model<LoungeModel>.Interface.IndexToCharacter)
		{
			if (item.Value.character.Contains(characterId))
			{
				return item.Key;
			}
		}
		return 0;
	}

	public bool HasChatAtPoint(int characterId, int pointId)
	{
		if (!CharacterHasChatForSideIcon(characterId))
		{
			return false;
		}
		if (!Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(pointId, out var value))
		{
			return false;
		}
		if (value.character.Contains(characterId))
		{
			return true;
		}
		if (!Model<LoungeModel>.Interface.IsCharacterCheckedIn(characterId) && TryGetTempInvitePointId(characterId, out var pointId2))
		{
			return pointId2 == pointId;
		}
		if (value.character.Count == 0 && GetCharacterCanEnterPoint(pointId).Contains(characterId))
		{
			return true;
		}
		return false;
	}

	public void GetSideIconDisplay(int characterId, int pointId, out bool plotBright, out bool plotDark, out bool chatBright, out bool chatDark)
	{
		if (!CanShowSideIconForCharacter(characterId))
		{
			plotBright = (plotDark = (chatBright = (chatDark = false)));
			return;
		}
		bool flag = HasPlotAtPoint(characterId, pointId);
		bool flag2 = HasChatAtPoint(characterId, pointId);
		bool flag3 = CharacterHasActivePlot(characterId);
		bool flag4 = CharacterHasChatForSideIcon(characterId);
		plotBright = flag;
		plotDark = flag3 && !flag;
		chatBright = flag2;
		chatDark = flag4 && !flag2;
	}

	private bool CharacterHasChatForSideIcon(int characterId)
	{
		if (Model<LoungeModel>.Interface.IsCharacterCheckedIn(characterId))
		{
			return IsShowChatIcon(characterId);
		}
		return Model<LoungeModel>.Interface.CharacterCanGreet(characterId);
	}
}
