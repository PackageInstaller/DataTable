using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class WildBossModel : Model<WildBossModel>
{
	private List<Entity> _wildBossBattleList = new List<Entity>();

	private Dictionary<int, bool> _wildBossCanBattleDic = new Dictionary<int, bool>();

	public const int FreeDiamond = 97;

	public const int unknowMonsterSpriteId = 99;

	private const int WildBossMainId = 1;

	private const int TipsId = 1874;

	private Action _updateDataAction;

	public int TakeRewardCount { get; private set; }

	public int BoughtCount { get; private set; }

	public int ExtraCount { get; private set; }

	public int CanTakeRewardCount => BaseTakeRewardCount + ExtraCount - TakeRewardCount;

	public int CanBuyMaxCount => Mathf.Min(RewardBuyingNums - BoughtCount, RewardBuyingNums - ExtraCount);

	public int CurCollectionUid { get; private set; }

	public bool InWildBossBattle { get; private set; }

	public int BaseTakeRewardCount => CoreUtils.GetData(1, RuntimeConfigs.data.wildBossMains).rewardsNums;

	public int RewardBuyingNums => CoreUtils.GetData(1, RuntimeConfigs.data.wildBossMains).rewardsBuyingNums;

	public int PerCostPrice => CoreUtils.GetData(1, RuntimeConfigs.data.wildBossMains).price[0].count;

	public int RaidMessageId => CoreUtils.GetData(1, RuntimeConfigs.data.wildBossMains).raidMessage;

	public int RaidTitleId => CoreUtils.GetData(1, RuntimeConfigs.data.wildBossMains).raidMessageTitle;

	public long InWildTimeStamp { get; private set; }

	public event Action UpdateDataAction
	{
		add
		{
			_updateDataAction = (Action)Delegate.Combine(_updateDataAction, value);
		}
		remove
		{
			_updateDataAction = (Action)Delegate.Remove(_updateDataAction, value);
		}
	}

	public void UpdateDataByNtf(DailyData data)
	{
		BoughtCount = data.WildBossRewardBoughtCount;
		TakeRewardCount = data.WildBossTakeRewardCount;
		ExtraCount = data.WildBossRewardExtraCount;
		_updateDataAction?.Invoke();
	}

	public bool CheckWildBossCanBattle(int monsterPointId)
	{
		return _wildBossCanBattleDic.GetValueOrDefault(monsterPointId, defaultValue: false);
	}

	private void SetWildBossCanBattle(int monsterPointId, bool value)
	{
		_wildBossCanBattleDic[monsterPointId] = value;
	}

	private void OnServiceStateRefresh(BaseEventContent obj)
	{
		if (obj is ServiceStateRefresh serviceStateRefresh && Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(serviceStateRefresh.swid) is MonsterPointData { serviceSaveTag: ServiceSaveTag.WildBoss } monsterPointData)
		{
			SetWildBossCanBattle(monsterPointData.monsterPointId, serviceStateRefresh.stateId == 0);
		}
	}

	public void CacheData(int collectionUId)
	{
		CurCollectionUid = collectionUId;
	}

	public string GetRemainTime(int monsterPointId)
	{
		TimeSpan nextRefreshTime = GetNextRefreshTime(monsterPointId);
		if (nextRefreshTime == default(TimeSpan))
		{
			return string.Empty;
		}
		int num = (int)nextRefreshTime.TotalHours;
		if (num > 24)
		{
			return string.Format("{0}{1}", nextRefreshTime.Days, LocalizationUtility.GetLocalizeString("Common", 609)) + string.Format("{0}{1}", nextRefreshTime.Hours, LocalizationUtility.GetLocalizeString("Common", 41000109));
		}
		int minutes = nextRefreshTime.Minutes;
		int seconds = nextRefreshTime.Seconds;
		string text = string.Empty;
		if (num > 0 && minutes > 0)
		{
			text += string.Format("{0}{1}", num, LocalizationUtility.GetLocalizeString("Common", 41000109));
			text += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
		}
		else if (num > 0 && minutes == 0)
		{
			text += string.Format("{0}{1}", num, LocalizationUtility.GetLocalizeString("Common", 41000109));
		}
		else if (num == 0 && minutes > 0 && seconds > 0)
		{
			text += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
			text += string.Format("{0}{1}", seconds, LocalizationUtility.GetLocalizeString("Common", 624));
		}
		else if (num == 0 && minutes > 0 && seconds == 0)
		{
			text += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
		}
		else if (num == 0 && minutes == 0 && seconds > 0)
		{
			text += string.Format("{0}{1}", seconds, LocalizationUtility.GetLocalizeString("Common", 624));
		}
		return text;
	}

	public TimeSpan GetNextRefreshTime(int monsterPointId)
	{
		int[] refreshTime = GetRefreshTime(monsterPointId);
		if (refreshTime.Length == 0)
		{
			Debug.LogError($"野外boss怪点id->{monsterPointId}不在wildBossUses表中？请检查配置！");
			return default;
		}
		System.DateTime now = TimeManager.ServerTime.Now;
		int num = (int)((now.DayOfWeek == DayOfWeek.Sunday) ? ((DayOfWeek)7) : now.DayOfWeek);
		int num2 = 7;
		int[] array = refreshTime;
		for (int i = 0; i < array.Length; i++)
		{
			int num3 = array[i] - num;
			if (num3 <= 0)
			{
				num3 += 7;
			}
			if (num3 < num2)
			{
				num2 = num3;
			}
		}
		long num4 = new DateTimeOffset(now.Date.AddDays(num2).AddHours(4.0)).ToUnixTimeMilliseconds() - TimeManager.ServerTime.NowTimestamp;
		if (num4 < 0)
		{
			num4 = 0L;
		}
		return TimeSpan.FromMilliseconds(num4);
	}

	public int[] GetRefreshTime(int monsterPointId)
	{
		int[] result = new int[0];
		foreach (KeyValuePair<int, WildBossUse> wildBossUse in RuntimeConfigs.data.wildBossUses)
		{
			if (wildBossUse.Value.monsterID == monsterPointId)
			{
				result = wildBossUse.Value.refreshTime;
				break;
			}
		}
		return result;
	}

	protected override void Init()
	{
		InWildBossBattle = false;
		InWildTimeStamp = 0L;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, OnServiceStateRefresh);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, InitWildBossCanBattleData);
	}

	private void InitWildBossCanBattleData(BaseEventContent baseEventContent)
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (!worldManager.HasActiveWorld || !G.localPlayer.Maps.TryGetValue(worldManager.ActiveWorldId, out var value))
		{
			return;
		}
		foreach (KeyValuePair<int, int> serviceSaveStateId in value.ServiceSaveStateIds)
		{
			if (worldManager.GetWorldStateAssetDataBySGOID(serviceSaveStateId.Key) is MonsterPointData { serviceSaveTag: ServiceSaveTag.WildBoss } monsterPointData)
			{
				SetWildBossCanBattle(monsterPointData.monsterPointId, serviceSaveStateId.Value == 0);
			}
		}
	}

	protected override void UnInit()
	{
		_wildBossBattleList?.Clear();
		_wildBossCanBattleDic.Clear();
		InWildBossBattle = false;
		InWildTimeStamp = 0L;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, OnServiceStateRefresh);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, InitWildBossCanBattleData);
	}

	public void BuyRewardCountView(Action action = null)
	{
		if (Model<WildBossModel>.Interface.CanBuyMaxCount <= 0)
		{
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1874));
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPWILDBOSSBUYREWARD, new PopUpWildBossBuyRewardViewData
		{
			OnBuySuccessAction = action
		});
	}

	public void StartWildBossBattle(Entity entity)
	{
		if (!entity.IsValid)
		{
			return;
		}
		if (_wildBossBattleList == null)
		{
			_wildBossBattleList = new List<Entity>();
		}
		_wildBossBattleList.RemoveAll((Entity battleEntity) => !battleEntity.IsValid);
		if (!_wildBossBattleList.Contains(entity))
		{
			_wildBossBattleList.Add(entity);
			if (!InWildBossBattle)
			{
				InWildBossBattle = _wildBossBattleList.Count > 0;
				InWildTimeStamp = TimeManager.LocalTime.NowTimestamp;
				MonoECS.instance?.chTimeStatisticsManager?.ResetRecording();
			}
		}
	}

	public void EndWildBossBattle(Entity entity)
	{
		if (_wildBossBattleList == null)
		{
			InWildBossBattle = false;
			return;
		}
		_wildBossBattleList.RemoveAll((Entity battleEntity) => !battleEntity.IsValid || battleEntity == entity);
		if (!InWildBossBattle || _wildBossBattleList.Count > 0)
		{
			return;
		}
		InWildBossBattle = false;
		MonoECS.instance?.chTimeStatisticsManager?.StopRecording();
		if (!entity.IsAlive())
		{
			CompStateObject? compStateObject = entity.GetCompStateObject();
			if (compStateObject != null && compStateObject.StateWorldAssetData?.serviceSaveTag == ServiceSaveTag.WildBoss)
			{
				WorldBossFightEvent evt = EventTrackSolver.Instance.GetEvt<WorldBossFightEvent>();
				evt.entity = entity;
				evt.duration = TimeSpan.FromMilliseconds(TimeManager.LocalTime.NowTimestamp - Model<WildBossModel>.Interface.InWildTimeStamp).TotalSeconds;
				evt.result = ((!entity.IsAlive()) ? 1 : 0);
				EventTrackSolver.Instance.Dispatch(evt);
			}
		}
		InWildTimeStamp = 0L;
	}

	public Entity GetCurrentWildBoss()
	{
		if (_wildBossBattleList.Count > 0)
		{
			return _wildBossBattleList.First((Entity x) => x.IsValid);
		}
		return Entity.Invalid;
	}
}
