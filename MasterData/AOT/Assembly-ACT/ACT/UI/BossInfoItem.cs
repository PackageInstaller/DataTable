using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.World;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class BossInfoItem : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler
{
	[Header("解锁状态")]
	[SerializeField]
	public GameObject _unlockRoot;

	[SerializeField]
	private BImage _backGroundImage;

	[SerializeField]
	private LocalizeStringEvent _bossName;

	[SerializeField]
	public CommonScrollBagComponent _rewardScrollBag;

	[SerializeField]
	private CommonCoinComponent _costComponent;

	[SerializeField]
	public ActButton _confirmButton1;

	[SerializeField]
	private LocalizeStringEvent _belongAreaContent1;

	[FormerlySerializedAs("_unlockRoot")]
	[Header("未解锁状态")]
	[SerializeField]
	private GameObject _lockRoot;

	[SerializeField]
	private LocalizeStringEvent _belongAreaContent2;

	[SerializeField]
	public ActButton _confirmButton2;

	public GameObject btnPrompt_leftStick;

	public GameObject btnPrompt_confirm;

	public GameObject btnPrompt_goto;

	public GameObject doubleRewardRoot;

	public LocalizeStringEvent doubleRewardText;

	private ImageAssetStation m_Station;

	public Action<BossInfoItem> OnSelectItem;

	private int _worldBossMonsterID;

	private WorldBossMonster _worldMonsterData;

	private EntityEnemyData _entityEnemyData;

	private ACT.Config.MapArea _mapAreaData;

	public BetterAnimation anim;

	private List<ItemUnifierProxy> _rewards;

	public new virtual ImageAssetStation Station
	{
		get
		{
			if (m_Station != null)
			{
				return m_Station;
			}
			IBaseUIView componentInParent = GetComponentInParent<IBaseUIView>();
			m_Station = componentInParent.Station;
			return m_Station;
		}
		set
		{
			m_Station = value;
		}
	}

	public int WorldBossMonsterID
	{
		get
		{
			return _worldBossMonsterID;
		}
		set
		{
			if (_worldBossMonsterID != value)
			{
				_worldBossMonsterID = value;
				UpdateStyle();
			}
		}
	}

	private void Awake()
	{
		_confirmButton1.SetBtnClick(TrackMonster);
		_confirmButton2.SetBtnClick(OpenMapView);
		_rewards = ListPool<ItemUnifierProxy>.Get();
	}

	protected override void OnUnityDestroy()
	{
		_confirmButton1.OnClick.RemoveListener(TrackMonster);
		_confirmButton2.OnClick.RemoveListener(OpenMapView);
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		ListPool<ItemUnifierProxy>.Release(_rewards);
	}

	public override void PlayCustomAnimation(float delaySecond = 0f)
	{
		gameObject.SetActive(value: true);
		anim.GetSequence("Show").Goto(0f).SetDelay(delaySecond)
			.Play();
		base.PlayCustomAnimation(delaySecond);
	}

	private void TrackMonster()
	{
		WorldBossMonster data = CoreUtils.GetData(_worldBossMonsterID, RuntimeConfigs.data.worldBossMonsters);
		if (data.bossType != 1)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
			{
				RaidEntranceId = data.worldBossRaidId
			});
		}
	}

	private void UpdateDisplayBossRaidName()
	{
		WorldBossMonster data = CoreUtils.GetData(_worldBossMonsterID, RuntimeConfigs.data.worldBossMonsters);
		RaidEntranceData data2 = CoreUtils.GetData(data.worldBossRaidId, RuntimeConfigs.data.raidEntranceDatas);
		if (data2 == null)
		{
			return;
		}
		ACT.Config.Raid raid = null;
		for (int i = 0; i < data2.raidId.Length; i++)
		{
			ACT.Config.Raid data3 = CoreUtils.GetData(data2.raidId[i], RuntimeConfigs.data.raids);
			if (data3 != null && Model<RaidModel>.Interface.IsUnlock(data3))
			{
				raid = data3;
			}
		}
		_bossName.SetTable("shortcommon");
		_bossName.StringReference.TableEntryReference = raid?.raidName ?? 0;
		RefreshDoubleRewardTag(data.worldBossRaidId);
	}

	public void RefreshEntranceLevel()
	{
		if (_worldBossMonsterID > 0 && (!(_unlockRoot != null) || _unlockRoot.activeSelf))
		{
			UpdateDisplayBossRaidName();
		}
	}

	private void RefreshDoubleRewardTag(int raidEntranceId)
	{
		doubleRewardRoot.SetActive(value: false);
		bool activityIsOpening = Model<ActivityCenterModel>.Interface.GetActivityIsOpening(Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId());
		List<int> raidTypeList = Model<ActivityCenterModel>.Interface.GetRaidTypeList(Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId());
		if (raidTypeList != null && raidTypeList.Count > 0)
		{
			int raidTypeByEntranceId = Model<RaidModel>.Interface.GetRaidTypeByEntranceId(raidEntranceId);
			bool flag = raidTypeList.Contains(raidTypeByEntranceId);
			doubleRewardRoot.SetActive(activityIsOpening & flag);
			doubleRewardText.SetTable("shortcommon");
		}
	}

	private void UpdateStyle()
	{
		RefreshBossConfig();
		int enemyType = _entityEnemyData.enemyType;
		bool flag = Model<MonsterHandModel>.Interface.IsUnlockByenemyType(enemyType);
		UpdatePromptStyle(flag);
		if (!flag)
		{
			UpdateLockedStyle();
		}
		else
		{
			UpdateUnlockedStyle();
		}
	}

	private void RefreshBossConfig()
	{
		_worldMonsterData = CoreUtils.GetData(_worldBossMonsterID, RuntimeConfigs.data.worldBossMonsters);
		_entityEnemyData = CoreUtils.GetData(_worldMonsterData.worldBossID, RuntimeConfigs.data.entityEnemyDatas);
		_mapAreaData = CoreUtils.GetData(_entityEnemyData.nativePlace, RuntimeConfigs.data.mapAreas);
	}

	private void UpdatePromptStyle(bool isUnlock)
	{
		btnPrompt_confirm.SetActive(isUnlock);
		btnPrompt_goto.SetActive(!isUnlock);
	}

	private void UpdateLockedStyle()
	{
		UpdateLockRootStyle();
		doubleRewardRoot.SetActive(value: false);
	}

	private void UpdateUnlockedStyle()
	{
		UpdateUnlockRootStyle();
		UpdateBossNameStyle();
		UpdateBossImageStyle();
		UpdateRewardScrollBagStyle();
		UpdateCostComponentStyle();
	}

	private void UpdateLockRootStyle()
	{
		_lockRoot.SetActive(value: true);
		if (_mapAreaData == null)
		{
			Debug.LogError($"世界BossId {_worldBossMonsterID} 的 mapAreaData is null");
			return;
		}
		_belongAreaContent2.SetTable(LocalizeTable.ShortCommon);
		_belongAreaContent2.StringReference.TableEntryReference = _mapAreaData.name;
		_unlockRoot.SetActive(value: false);
		btnPrompt_leftStick.SetActive(value: false);
	}

	private void UpdateUnlockRootStyle()
	{
		_lockRoot.SetActive(value: false);
		_unlockRoot.SetActive(value: true);
		_belongAreaContent1.SetTable(LocalizeTable.ShortCommon);
		_belongAreaContent1.StringReference.TableEntryReference = _mapAreaData.name;
	}

	private void UpdateBossNameStyle()
	{
		UpdateDisplayBossRaidName();
	}

	private void UpdateBossImageStyle()
	{
		Station.LoadImageAsync(168, _worldMonsterData.listBanner, _backGroundImage).Forget();
	}

	private void UpdateRewardScrollBagStyle()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		foreach (ItemKv item in _worldMonsterData.worldBossRewardItemShow)
		{
			_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
		}
		_rewards.Sort(SortUtility.SortItemUnifierProxy1);
		_rewardScrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.Hide;
		_rewardScrollBag.ItemSource = _rewards;
		btnPrompt_leftStick.SetActive(_rewards.Count > 0);
	}

	private void UpdateCostComponentStyle()
	{
		_costComponent.Refresh(_worldMonsterData.worldBossCost.First());
	}

	private void OpenMapView()
	{
		ACT.Config.MapArea data = CoreUtils.GetData(CoreUtils.GetData(CoreUtils.GetData(_worldBossMonsterID, RuntimeConfigs.data.worldBossMonsters).worldBossID, RuntimeConfigs.data.entityEnemyDatas).nativePlace, RuntimeConfigs.data.mapAreas);
		ACT.World.MapArea id = (ACT.World.MapArea)data.id;
		if (MapUtility.AreaUnlock(id))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
			{
				missionOpen = true,
				initMapArea = id
			});
		}
		else
		{
			string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", data.name);
			GameUtility.OpenToolTip(2426, "Common", new List<string> { localizeString });
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		OnSelectItem?.Invoke(this);
	}
}
