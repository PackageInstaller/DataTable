using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
using Runtime.UI.CommonComponent.CommonScrollBag;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class WildBossInfoItem : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler
{
	[Header("解锁状态")]
	[SerializeField]
	public GameObject _unlockRoot;

	[SerializeField]
	private BImage _backGroundImage;

	[SerializeField]
	private BImage _bossHeadIcon;

	[SerializeField]
	private LocalizeStringEvent _bossName;

	[SerializeField]
	public CommonScrollBagComponent _rewardScrollBag;

	[SerializeField]
	public ActButton _confirmButton1;

	[SerializeField]
	private LocalizeStringEvent _belongAreaContent1;

	[SerializeField]
	private TMP_Text refreshTimeContent;

	[FormerlySerializedAs("_unlockRoot")]
	[Header("未解锁状态")]
	[SerializeField]
	private GameObject _lockRoot;

	[SerializeField]
	private LocalizeStringEvent _belongAreaContent2;

	[SerializeField]
	public ActButton _confirmButton2;

	public GameObject btnPrompt_confirm;

	public GameObject btnPrompt_leftStick;

	public CommonTimerComponent commonTimer;

	private ImageAssetStation m_Station;

	public Action<WildBossInfoItem> OnSelectItem;

	private int _wildBossId;

	private WildBossUse _wildBossUse;

	public BetterAnimation anim;

	private int _monsterPointId;

	private EntityData _monsterData;

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

	public int WildBossId
	{
		get
		{
			return _wildBossId;
		}
		set
		{
			_wildBossId = value;
			_wildBossUse = CoreUtils.GetData(_wildBossId, RuntimeConfigs.data.wildBossUses);
			if (_wildBossUse == null)
			{
				Debug.LogError($"WildBossInfoItem wildBossUse is null. wildBossId:{_wildBossId}");
				return;
			}
			_monsterPointId = _wildBossUse.monsterID;
			TryGetWildBossConfig(out var _, out var _, out var _, out var enemyId);
			_monsterData = CoreUtils.GetData(enemyId, RuntimeConfigs.data.entityDatas);
			if (_monsterData == null)
			{
				Debug.LogError($"WildBossInfoItem monsterData is null. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}, enemyId:{enemyId}");
			}
			else
			{
				UpdateStyle();
			}
		}
	}

	private void Awake()
	{
		_confirmButton1.SetBtnClick(MonsterPointJump);
		_confirmButton2.SetBtnClick(OpenMapView);
		_rewards = ListPool<ItemUnifierProxy>.Get();
		commonTimer.IsCountDown = true;
	}

	protected override void OnUnityDestroy()
	{
		_confirmButton1.OnClick.RemoveListener(MonsterPointJump);
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

	private void MonsterPointJump()
	{
		if (TryGetWildBossConfig(out var _, out var _, out var mapAreaData, out var _))
		{
			if (!MapUtility.AreaUnlock(mapAreaData.id))
			{
				string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", mapAreaData.name);
				GameUtility.OpenToolTip(2426, "Common", new List<string> { localizeString });
			}
			else
			{
				Singleton<NewUIManager>.instance.BackToBattleMain();
				MapUtility.MapTransferByMonsterPoint((ACT.World.MapArea)mapAreaData.id, _monsterPointId);
			}
		}
	}

	private void UpdateDisplayBossRaidName()
	{
		_bossName.SetTable("shortcommon");
		_bossName.StringReference.TableEntryReference = _monsterData.nameLocal;
	}

	private void UpdateStyle()
	{
		if (TryGetWildBossConfig(out var _, out var _, out var mapAreaData, out var _))
		{
			if (!Model<MonsterHandModel>.Interface.WildBossUnLock(_monsterPointId))
			{
				UpdateLockedStyle(mapAreaData);
			}
			else
			{
				UpdateUnlockedStyle(mapAreaData);
			}
		}
	}

	private void UpdateLockedStyle(ACT.Config.MapArea mapAreaData)
	{
		UpdateLockRootStyle(mapAreaData);
	}

	private void UpdateUnlockedStyle(ACT.Config.MapArea mapAreaData)
	{
		bool canBattle = Model<WildBossModel>.Interface.CheckWildBossCanBattle(_monsterPointId);
		UpdateUnlockRootStyle(mapAreaData);
		UpdateConfirmButtonStyle(canBattle);
		UpdateBossNameStyle();
		UpdateBossImageStyle();
		UpdateRewardScrollBagStyle();
		UpdateRefreshTimeContentStyle();
		UpdateCommonTimerStyle(canBattle);
		btnPrompt_confirm.SetActive(value: true);
	}

	private void UpdateLockRootStyle(ACT.Config.MapArea mapAreaData)
	{
		_lockRoot.SetActive(value: true);
		_belongAreaContent2.SetTable(LocalizeTable.ShortCommon);
		_belongAreaContent2.StringReference.TableEntryReference = mapAreaData.name;
		_unlockRoot.SetActive(value: false);
		btnPrompt_leftStick.SetActive(value: false);
		btnPrompt_confirm.SetActive(value: false);
	}

	private void UpdateUnlockRootStyle(ACT.Config.MapArea mapAreaData)
	{
		_lockRoot.SetActive(value: false);
		_unlockRoot.SetActive(value: true);
		_belongAreaContent1.SetTable(LocalizeTable.ShortCommon);
		_belongAreaContent1.StringReference.TableEntryReference = mapAreaData.name;
	}

	private void UpdateConfirmButtonStyle(bool canBattle)
	{
		_confirmButton1.gameObject.SetActive(canBattle);
	}

	private void UpdateBossNameStyle()
	{
		UpdateDisplayBossRaidName();
	}

	private void UpdateBossImageStyle()
	{
		Station.LoadImageAsync(167, _wildBossUse.monsterBannerID, _bossHeadIcon).Forget();
		Station.LoadImageAsync(168, _wildBossUse.monsterBgID, _backGroundImage).Forget();
	}

	private void UpdateRewardScrollBagStyle()
	{
		int num = Model<WorldLevelModel>.Interface.GetCurWorldLevel() - 1;
		if (num >= _wildBossUse.rewards.Length || num < 0)
		{
			Debug.Log($"Current world level {num} is out of valid range [0, {_wildBossUse.rewards.Length}), skipping reward display.");
			return;
		}
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		foreach (ItemKv item in CoreUtils.GetData(_wildBossUse.rewards[num], RuntimeConfigs.data.collections).certain)
		{
			_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
		}
		_rewards.Sort(SortUtility.SortItemUnifierProxy1);
		_rewardScrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.Hide;
		_rewardScrollBag.ItemSource = _rewards;
		btnPrompt_leftStick.SetActive(_rewards.Count > 0);
	}

	private void UpdateRefreshTimeContentStyle()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < _wildBossUse.refreshTime.Length; i++)
		{
			switch (_wildBossUse.refreshTime[i])
			{
			case 1:
				stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Monday));
				break;
			case 2:
				stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Tuesday));
				break;
			case 3:
				stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Wednesday));
				break;
			case 4:
				stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Thursday));
				break;
			case 5:
				stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Friday));
				break;
			case 6:
				stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Saturday));
				break;
			case 7:
				stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Sunday));
				break;
			}
			if (i != _wildBossUse.refreshTime.Length - 1)
			{
				stringBuilder.Append("/");
			}
		}
		refreshTimeContent.SetText(stringBuilder);
	}

	private void UpdateCommonTimerStyle(bool canBattle)
	{
		if (canBattle)
		{
			commonTimer.gameObject.SetActive(value: false);
			return;
		}
		commonTimer.gameObject.SetActive(value: true);
		TimeSpan nextRefreshTime = Model<WildBossModel>.Interface.GetNextRefreshTime(_monsterPointId);
		CommonTimerComponent commonTimerComponent = commonTimer;
		System.DateTime minValue = System.DateTime.MinValue;
		commonTimerComponent.Time = minValue.Add(nextRefreshTime);
	}

	private bool TryGetWildBossConfig(out EnemySpawn enemySpawn, out EntityEnemyData entityEnemyData, out ACT.Config.MapArea mapAreaData, out int enemyId)
	{
		enemySpawn = CoreUtils.GetData(_monsterPointId, RuntimeConfigs.data.enemySpawns);
		entityEnemyData = null;
		mapAreaData = null;
		enemyId = 0;
		if (enemySpawn == null)
		{
			Debug.LogError($"WildBossInfoItem enemySpawn is null. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}");
			return false;
		}
		Maybe maybe = enemySpawn.enemy?.FirstOrDefault();
		if (maybe == null)
		{
			Debug.LogError($"WildBossInfoItem enemySpawn.enemy is null or empty. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}, enemySpawnId:{enemySpawn.id}");
			return false;
		}
		enemyId = maybe.id;
		entityEnemyData = CoreUtils.GetData(enemyId, RuntimeConfigs.data.entityEnemyDatas);
		if (entityEnemyData == null)
		{
			Debug.LogError($"WildBossInfoItem entityEnemyData is null. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}, enemyId:{enemyId}");
			return false;
		}
		mapAreaData = CoreUtils.GetData(entityEnemyData.nativePlace, RuntimeConfigs.data.mapAreas);
		if (mapAreaData == null)
		{
			Debug.LogError($"WildBossInfoItem mapAreaData is null. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}, enemyId:{enemyId}, nativePlace:{entityEnemyData.nativePlace}");
			return false;
		}
		return true;
	}

	private void OpenMapView()
	{
		if (_monsterData == null)
		{
			Debug.LogError($"WildBossInfoItem monsterData is null when opening map. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}");
			return;
		}
		EntityEnemyData data = CoreUtils.GetData(_monsterData.id, RuntimeConfigs.data.entityEnemyDatas);
		if (data == null)
		{
			Debug.LogError($"WildBossInfoItem entityEnemyData is null when opening map. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}, enemyId:{_monsterData.id}");
			return;
		}
		ACT.Config.MapArea data2 = CoreUtils.GetData(data.nativePlace, RuntimeConfigs.data.mapAreas);
		if (data2 == null)
		{
			Debug.LogError($"WildBossInfoItem mapAreaData is null when opening map. wildBossId:{_wildBossId}, monsterPointId:{_monsterPointId}, enemyId:{_monsterData.id}, nativePlace:{data.nativePlace}");
			return;
		}
		ACT.World.MapArea id = (ACT.World.MapArea)data2.id;
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
			string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", data2.name);
			GameUtility.OpenToolTip(2426, "Common", new List<string> { localizeString });
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		OnSelectItem?.Invoke(this);
	}
}
