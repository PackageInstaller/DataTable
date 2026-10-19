using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.UI.DataProxy;
using Lumin.LoungeSystem.UI;
using UnityEngine;

namespace ACT.Model;

public class FavorabilityModel : Model<FavorabilityModel>
{
	private List<ItemUnifierProxy> items = new List<ItemUnifierProxy>();

	private List<ItemUnifierProxy> favorabilityGiftLists = new List<ItemUnifierProxy>();

	private readonly GiftComparer _giftComparer = new GiftComparer();

	public List<UnlockEntry> UnlockEntries = new List<UnlockEntry>();

	public Dictionary<int, FavorabilityData> CharacterFavorInfoDic = new Dictionary<int, FavorabilityData>();

	public int gotLikeability;

	public int curLikeabilityLv;

	public int curLikeabilityExp;

	public int curSendGiftCount;

	private int beforeSendGiftFavorValue;

	private int beforeSendGiftFavorLevel;

	private static readonly string[] TwoDigits = new string[100];

	public int GotLikeability
	{
		get
		{
			return gotLikeability;
		}
		set
		{
			gotLikeability = value;
		}
	}

	public int CurLikeabilityLv
	{
		get
		{
			int pendingClickCharacterId = LoungeUIScene.instance.PendingClickCharacterId;
			int item = Model<LoungeModel>.Interface.GetCharacterFavorInfo(pendingClickCharacterId).Item1;
			if (item <= curLikeabilityLv)
			{
				return curLikeabilityLv;
			}
			return item;
		}
		set
		{
			curLikeabilityLv = value;
		}
	}

	public int CurLikeabilityExp
	{
		get
		{
			int pendingClickCharacterId = LoungeUIScene.instance.PendingClickCharacterId;
			var (num, num2) = Model<LoungeModel>.Interface.GetCharacterFavorInfo(pendingClickCharacterId);
			if (num == CurLikeabilityLv)
			{
				if (curLikeabilityExp <= num2)
				{
					return num2;
				}
				return curLikeabilityExp;
			}
			if (num <= CurLikeabilityLv)
			{
				return curLikeabilityExp;
			}
			return num2;
		}
		set
		{
			curLikeabilityExp = value;
		}
	}

	public int CurSendGiftCount
	{
		get
		{
			return curSendGiftCount;
		}
		set
		{
			curSendGiftCount = value;
		}
	}

	public int BeforeSendGiftFavorValue
	{
		get
		{
			return beforeSendGiftFavorValue;
		}
		set
		{
			beforeSendGiftFavorValue = value;
		}
	}

	public int BeforeSendGiftFavorLevel
	{
		get
		{
			return beforeSendGiftFavorLevel;
		}
		set
		{
			beforeSendGiftFavorLevel = value;
		}
	}

	private void MyNumberUtils()
	{
		for (int i = 0; i < 100; i++)
		{
			TwoDigits[i] = i.ToString("00");
		}
	}

	public string ToTwoDigitString(int n)
	{
		if (n < 0 || n >= 100)
		{
			return n.ToString("00");
		}
		return TwoDigits[n];
	}

	protected override void Init()
	{
		MyNumberUtils();
	}

	protected override void UnInit()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(items);
		ItemUnifierProxy.ItemUnifierPool.Release(favorabilityGiftLists);
		GotLikeability = 0;
		CurLikeabilityLv = 0;
		CurLikeabilityExp = 0;
		CurSendGiftCount = 0;
		beforeSendGiftFavorValue = 0;
		beforeSendGiftFavorLevel = 0;
		CharacterFavorInfoDic.Clear();
	}

	public void UpdateCharacterFavorInfoDic(int characterId, int likeabilityLevel, int likeabilityExp)
	{
		if (characterId <= 0)
		{
			return;
		}
		if (likeabilityLevel <= 0)
		{
			(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(characterId);
			if (characterFavorInfo.Item1 <= 0)
			{
				return;
			}
			(likeabilityLevel, likeabilityExp) = characterFavorInfo;
		}
		CharacterFavorInfoDic[characterId] = new FavorabilityData
		{
			LikeabilityLevel = likeabilityLevel,
			LikeabilityExp = likeabilityExp
		};
	}

	public void UpdateCharacterFavorInfoDic(int characterId, int likeabilityLevel, int likeabilityExp, int gotLikeability)
	{
		if (characterId <= 0)
		{
			return;
		}
		if (likeabilityLevel > 0)
		{
			UpdateCharacterFavorInfoDic(characterId, likeabilityLevel, likeabilityExp);
		}
		else
		{
			if (gotLikeability <= 0)
			{
				return;
			}
			(int, int) baseFavorInfo = GetBaseFavorInfo(characterId);
			if (baseFavorInfo.Item1 > 0)
			{
				(int, int) tuple = AdvanceFavorByDelta(characterId, baseFavorInfo.Item1, baseFavorInfo.Item2, gotLikeability);
				if (tuple.Item1 > 0)
				{
					CharacterFavorInfoDic[characterId] = new FavorabilityData
					{
						LikeabilityLevel = tuple.Item1,
						LikeabilityExp = tuple.Item2
					};
				}
			}
		}
	}

	private (int level, int exp) GetBaseFavorInfo(int characterId)
	{
		if (CharacterFavorInfoDic.TryGetValue(characterId, out var value) && value != null && value.LikeabilityLevel > 0)
		{
			return (level: value.LikeabilityLevel, exp: value.LikeabilityExp);
		}
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(characterId);
		return (level: characterFavorInfo.Item1, exp: characterFavorInfo.Item2);
	}

	private (int level, int exp) AdvanceFavorByDelta(int characterId, int level, int exp, int delta)
	{
		if (level <= 0)
		{
			return (level: 0, exp: 0);
		}
		List<FavorabilityLevel> favorabilityLevelConfigs = GetFavorabilityLevelConfigs(characterId);
		if (favorabilityLevelConfigs == null || favorabilityLevelConfigs.Count == 0)
		{
			return (level: level, exp: Mathf.Max(0, exp + delta));
		}
		int num = favorabilityLevelConfigs.Max((FavorabilityLevel c) => c.favorabilityLevel);
		int num2 = Mathf.Clamp(level, 1, num);
		int num3 = Mathf.Max(0, exp) + Mathf.Max(0, delta);
		for (; num2 < num; num2++)
		{
			int item = GetFavorabilityEachLvAndFavorabilityTotal(characterId, num2).Item1;
			if (item <= 0 || num3 < item)
			{
				break;
			}
			num3 -= item;
		}
		if (num2 >= num)
		{
			int item2 = GetFavorabilityEachLvAndFavorabilityTotal(characterId, num).Item1;
			if (item2 > 0)
			{
				num3 = Mathf.Min(num3, item2);
			}
		}
		return (level: num2, exp: num3);
	}

	public (int level, int exp) GetPreviewFavorabilityResult(int characterId, int currentLevel, int currentExp, float previewAddedFavorability)
	{
		int level = Mathf.Max(0, currentLevel);
		int exp = Mathf.Max(0, currentExp);
		int delta = Mathf.Max(0, Mathf.FloorToInt(previewAddedFavorability));
		return AdvanceFavorByDelta(characterId, level, exp, delta);
	}

	public List<ItemUnifierProxy> SortGiftsWithComparer(List<ItemUnifierProxy> gifts)
	{
		_giftComparer.SetCharacterId(LoungeUIScene.instance.PendingClickCharacterId);
		gifts.Sort(_giftComparer);
		return gifts;
	}

	public (List<int>, List<int>) GetGiftPreference(int characterId)
	{
		List<int> item = new List<int>();
		List<int> item2 = new List<int>();
		try
		{
			EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[characterId];
			if (entityCharacterData != null && entityCharacterData.presentId != null)
			{
				int[][] presentId = entityCharacterData.presentId;
				if (presentId.Length != 0 && presentId[0] != null)
				{
					item = presentId[0].ToList();
				}
				if (presentId.Length > 1 && presentId[1] != null)
				{
					item2 = presentId[1].ToList();
				}
			}
		}
		catch (Exception exception)
		{
			Debug.Log("未找到对应characterId的配置==" + characterId);
			Debug.LogException(exception);
		}
		return (item, item2);
	}

	public float[] GetPresentFavorability()
	{
		return RuntimeConfigs.data.game.presentFavorability;
	}

	public int GetFavorabilityGiftType(int giftId)
	{
		return RuntimeConfigs.data.presentDates[giftId].type;
	}

	public GiftPreference GetGiftPreference(int giftId, int characterId)
	{
		if (!RuntimeConfigs.data.entityCharacterDatas.TryGetValue(characterId, out var value) || value?.presentId == null)
		{
			return GiftPreference.Normal;
		}
		int favorabilityGiftType = GetFavorabilityGiftType(giftId);
		int[][] presentId = value.presentId;
		if (presentId.Length != 0 && ContainsGiftType(presentId[0], favorabilityGiftType))
		{
			return GiftPreference.Favorite;
		}
		if (presentId.Length > 1 && ContainsGiftType(presentId[1], favorabilityGiftType))
		{
			return GiftPreference.Like;
		}
		return GiftPreference.Normal;
	}

	private static bool ContainsGiftType(int[] giftTypes, int targetType)
	{
		if (giftTypes == null)
		{
			return false;
		}
		for (int i = 0; i < giftTypes.Length; i++)
		{
			if (giftTypes[i] == targetType)
			{
				return true;
			}
		}
		return false;
	}

	public List<ItemUnifierProxy> GetGiftItemUnifier()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(items);
		ItemUnifierProxy.ItemUnifierPool.GetList(G.localPlayer.Inventory.Items, items);
		ItemUnifierProxy.ItemUnifierPool.Release(favorabilityGiftLists);
		foreach (ItemUnifierProxy item in items)
		{
			if (RuntimeConfigs.data.itemDatas.TryGetValue(item.Id, out var value))
			{
				if (value != null)
				{
					if (value.type == 22 && item.Count > 0)
					{
						favorabilityGiftLists.Add(item);
					}
				}
				else
				{
					Debug.LogWarning($"ItemData for ID {item.Id} is null.");
				}
			}
			else
			{
				Debug.LogWarning($"Item ID {item.Id} not found in itemDatas configuration.");
			}
		}
		return favorabilityGiftLists;
	}

	public (int, int) GetFavorabilityEachLvAndFavorabilityTotal(int characterId, int favorabilityLevel)
	{
		foreach (KeyValuePair<int, FavorabilityLevel> favorabilityLevel2 in RuntimeConfigs.data.favorabilityLevels)
		{
			if (favorabilityLevel2.Value.characterId == characterId && favorabilityLevel2.Value.favorabilityLevel == favorabilityLevel)
			{
				return (favorabilityLevel2.Value.favorabilityEachLv, favorabilityLevel2.Value.favorabilityTotal);
			}
		}
		return (-1, -1);
	}

	public float CalculateGiftFavorability(int giftId, int characterId, int giftCount)
	{
		int giftPreference = (int)GetGiftPreference(giftId, characterId);
		float num = 0f;
		int num2 = 0;
		if (RuntimeConfigs.data.presentDates.TryGetValue(giftId, out var value))
		{
			if (value != null)
			{
				num2 = value.value;
			}
			else
			{
				Debug.LogWarning($"ItemData for ID {giftId} is null.");
			}
		}
		else
		{
			Debug.LogWarning($"Item ID {giftId} not found in itemDatas configuration.");
		}
		return (float)num2 * giftPreference switch
		{
			0 => RuntimeConfigs.data.game.presentFavorability[0], 
			1 => RuntimeConfigs.data.game.presentFavorability[1], 
			2 => RuntimeConfigs.data.game.presentFavorability[2], 
			_ => RuntimeConfigs.data.game.presentFavorability[0], 
		} * (float)giftCount;
	}

	public int GetPresentDailyMax()
	{
		return RuntimeConfigs.data.game.presentDailyMax;
	}

	public (int, int) GetTodaySendGiftCount()
	{
		int item = ((G.localPlayer.DailyData.DailySentCharacterGiftCount > CurSendGiftCount) ? G.localPlayer.DailyData.DailySentCharacterGiftCount : CurSendGiftCount);
		int presentDailyMax = GetPresentDailyMax();
		return (item, presentDailyMax);
	}

	public int GetMaxFavorabilityStage()
	{
		return RuntimeConfigs.data.favorabilityStages.Count;
	}

	public int GetLoungereGreetFavorability()
	{
		return RuntimeConfigs.data.game.loungereGreetFavorability;
	}

	public int GetFavorabilityName(int stage)
	{
		if (RuntimeConfigs.data.favorabilityStages.TryGetValue(stage, out var value))
		{
			if (value != null)
			{
				return value.name;
			}
			Debug.LogWarning($"ItemData for ID {stage} is null.");
		}
		else
		{
			Debug.LogWarning($"Item ID {stage} not found in itemDatas configuration.");
		}
		return -1;
	}

	public int GetFavorabilityTotal(int stage, int characterId)
	{
		if (stage == 0)
		{
			stage = 1;
		}
		foreach (KeyValuePair<int, FavorabilityLevel> favorabilityLevel in RuntimeConfigs.data.favorabilityLevels)
		{
			if (favorabilityLevel.Value.characterId == characterId && favorabilityLevel.Value.favorabilityStage == stage)
			{
				return favorabilityLevel.Value.favorabilityTotal + favorabilityLevel.Value.favorabilityEachLv;
			}
		}
		return -1;
	}

	public int GetFavorabilityEachLv(int stage, int characterId)
	{
		if (stage == 0)
		{
			stage = 1;
		}
		foreach (KeyValuePair<int, FavorabilityLevel> favorabilityLevel in RuntimeConfigs.data.favorabilityLevels)
		{
			if (favorabilityLevel.Value.characterId == characterId && favorabilityLevel.Value.favorabilityStage == stage)
			{
				return favorabilityLevel.Value.favorabilityEachLv;
			}
		}
		return -1;
	}

	public bool GetCurrCharacterFavorabilityLevelIsMax(int characterId)
	{
		(int, int) characterFavorInfo = Model<LoungeModel>.Interface.GetCharacterFavorInfo(characterId);
		int item = GetFavorabilityEachLvAndFavorabilityTotal(characterId, characterFavorInfo.Item1).Item1;
		if (characterFavorInfo.Item1 < GetMaxFavorabilityStage())
		{
			return false;
		}
		return characterFavorInfo.Item2 >= item;
	}

	public int[] GetDramaId(int characterId, int stage)
	{
		int[] result = new int[0];
		foreach (KeyValuePair<int, FavorabilityLevel> favorabilityLevel in RuntimeConfigs.data.favorabilityLevels)
		{
			if (favorabilityLevel.Value.characterId == characterId && favorabilityLevel.Value.favorabilityStage == stage)
			{
				return favorabilityLevel.Value.dramaId;
			}
		}
		return result;
	}

	public int[] GetPointId(int characterId, int stage)
	{
		int[] result = new int[0];
		foreach (KeyValuePair<int, FavorabilityLevel> favorabilityLevel in RuntimeConfigs.data.favorabilityLevels)
		{
			if (favorabilityLevel.Value.characterId == characterId && favorabilityLevel.Value.favorabilityStage == stage)
			{
				return favorabilityLevel.Value.pointId;
			}
		}
		return result;
	}

	public List<FavorabilityLevel> GetFavorabilityLevelConfigs(int characterId)
	{
		List<FavorabilityLevel> list = new List<FavorabilityLevel>();
		foreach (KeyValuePair<int, FavorabilityLevel> favorabilityLevel in RuntimeConfigs.data.favorabilityLevels)
		{
			if (favorabilityLevel.Value.characterId == characterId)
			{
				list.Add(favorabilityLevel.Value);
			}
		}
		return list;
	}

	public List<UnlockEntry> GetFavorabilityLevelList(int characterId, int beforeSendGiftFavorLevel, int curLikeabilityLv)
	{
		UnlockEntries.Clear();
		if (characterId <= 0 || beforeSendGiftFavorLevel < 0 || curLikeabilityLv < 0)
		{
			return UnlockEntries;
		}
		if (curLikeabilityLv <= beforeSendGiftFavorLevel)
		{
			return UnlockEntries;
		}
		List<FavorabilityLevel> favorabilityLevelConfigs = GetFavorabilityLevelConfigs(characterId);
		if (favorabilityLevelConfigs == null || favorabilityLevelConfigs.Count == 0)
		{
			Debug.LogWarning($"角色 {characterId} 的好感度配置未找到");
			return UnlockEntries;
		}
		favorabilityLevelConfigs.Sort((FavorabilityLevel a, FavorabilityLevel b) =>
		{
			int favorabilityLevel = a.favorabilityLevel;
			return favorabilityLevel.CompareTo(b.favorabilityLevel);
		});
		foreach (FavorabilityLevel item in favorabilityLevelConfigs)
		{
			if (item.favorabilityLevel > beforeSendGiftFavorLevel && item.favorabilityLevel <= curLikeabilityLv)
			{
				if (item.dramaId != null && item.dramaId.Length != 0)
				{
					int[] dramaId = item.dramaId;
					foreach (int entryId in dramaId)
					{
						UnlockEntries.Add(new UnlockEntry
						{
							Type = UnlockEntryType.Drama,
							EntryId = entryId,
							Level = item.favorabilityLevel,
							Stage = item.favorabilityStage
						});
					}
				}
				if (item.pointId != null && item.pointId.Length != 0)
				{
					int[] dramaId = item.pointId;
					foreach (int entryId2 in dramaId)
					{
						UnlockEntries.Add(new UnlockEntry
						{
							Type = UnlockEntryType.Point,
							EntryId = entryId2,
							Level = item.favorabilityLevel,
							Stage = item.favorabilityStage
						});
					}
				}
				if (item.storyId != null && item.storyId.Length != 0)
				{
					int[] dramaId = item.storyId;
					foreach (int entryId3 in dramaId)
					{
						UnlockEntries.Add(new UnlockEntry
						{
							Type = UnlockEntryType.Story,
							EntryId = entryId3,
							Level = item.favorabilityLevel,
							Stage = item.favorabilityStage
						});
					}
				}
				if (item.audioId != null && item.audioId.Length != 0)
				{
					int[] dramaId = item.audioId;
					foreach (int entryId4 in dramaId)
					{
						UnlockEntries.Add(new UnlockEntry
						{
							Type = UnlockEntryType.Audio,
							EntryId = entryId4,
							Level = item.favorabilityLevel,
							Stage = item.favorabilityStage
						});
					}
				}
			}
			else if (item.favorabilityLevel > curLikeabilityLv)
			{
				break;
			}
		}
		return UnlockEntries;
	}

	public int GetFavorabilityLevelByPreviewAddedFavorability(int characterId, int currFavorabilityLevel, float currentFavorability, float previewAddedFavorability)
	{
		List<FavorabilityLevel> favorabilityLevelConfigs = GetFavorabilityLevelConfigs(characterId);
		if (favorabilityLevelConfigs == null || favorabilityLevelConfigs.Count == 0)
		{
			Debug.LogWarning($"角色 {characterId} 的好感度配置未找到");
			return currFavorabilityLevel;
		}
		int num = favorabilityLevelConfigs.Max((FavorabilityLevel c) => c.favorabilityLevel);
		if (num <= 0)
		{
			return currFavorabilityLevel;
		}
		int num2 = Mathf.Clamp(currFavorabilityLevel, 1, num);
		float num3 = Mathf.Max(0f, currentFavorability) + Mathf.Max(0f, previewAddedFavorability);
		for (; num2 < num; num2++)
		{
			int item = GetFavorabilityEachLvAndFavorabilityTotal(characterId, num2).Item1;
			if (item <= 0 || num3 < (float)item)
			{
				break;
			}
			num3 -= (float)item;
		}
		if (num2 >= num)
		{
			int item2 = GetFavorabilityEachLvAndFavorabilityTotal(characterId, num).Item1;
			if (item2 > 0)
			{
				num3 = Mathf.Min(num3, item2);
			}
		}
		return num2;
	}
}
