using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.Sound;
using ACT.Sound.Management;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.Chronos;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.WaitSort;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoAbyssListView : BaseUIView<AbyssListViewInputController>
{
	[SerializeField]
	private ActButton _closeButton;

	[SerializeField]
	private GameObject fixedAbyssBG;

	[SerializeField]
	private GameObject cycleAbyssBG;

	public ActToggleGroup ActToggleGroup;

	[SerializeField]
	private ActToggle fixedAbyssTab;

	[SerializeField]
	private ActToggle cycleAbyssTab;

	[SerializeField]
	private ActToggle lockCycleAbyssTab;

	[SerializeField]
	private LoopScrollRect _loopScrollRect;

	[SerializeField]
	private GameObject _nextRefresh;

	[SerializeField]
	private TextMeshProUGUI _nextRefreshTime;

	[SerializeField]
	public ActButton _battleReport;

	[SerializeField]
	private ActButton _detailButton;

	[Header("右侧中间")]
	[SerializeField]
	private CommonSubWorldEntranceTitle _title;

	[SerializeField]
	private GameObject _completeTips;

	[SerializeField]
	private GameObject _first;

	[SerializeField]
	private TextMeshProUGUI _firstDescription;

	[SerializeField]
	private GameObject _second;

	[SerializeField]
	private TextMeshProUGUI _secondDescription;

	[SerializeField]
	private CommonSubWorldEntranceTarget _target;

	[SerializeField]
	private CommonSubWorldEntranceRewards _rewards;

	[SerializeField]
	private GameObject _lockTips;

	[SerializeField]
	private TextMeshProUGUI _lockTipsDescription;

	[SerializeField]
	private ActButton _gotoTeamSubView;

	[SerializeField]
	private GameObject LB;

	[SerializeField]
	private GameObject RB;

	[SerializeField]
	public AbyssTeamSubView _abyssTeamSubView;

	public GameObject GamepadTipsRoot;

	public Dictionary<AbyssListViewControllerType, List<GameObject>> ControlDownPromts;

	public Dictionary<AbyssListViewControllerType, List<GameObject>> ControlPromts;

	public Dictionary<AbyssListViewControllerType, ViewControlLayer> ControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	public TextMeshProUGUI SelectPromptLabel;

	private List<AbyssData> _abyssDatas;

	private uint _audioID;

	private int _groupID;

	private const int JUMP_OFFSET = 4;

	private int _lastSelectItemIndex = -1;

	private int _curSelectItemIndex = -1;

	private Looper _countDown;

	private AbyssListViewControllerType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	private AbyssType _currentAbyssType
	{
		get
		{
			return Model<AbyssModel>.Interface.CurAbyssType;
		}
		set
		{
			Model<AbyssModel>.Interface.CurAbyssType = value;
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		_closeButton.SetBtnClick(OnClose);
		_detailButton.SetBtnClick(OpenDetailView);
		_battleReport.SetBtnClick(OpenHistoryRecordView);
		_gotoTeamSubView.SetBtnClick(() =>
		{
			OpenAbyssTeamPanel(_curSelectItemIndex);
		});
		lockCycleAbyssTab.onToggleClick.RemoveAllListeners();
		lockCycleAbyssTab.onToggleClick.AddListener(OnClickLockCycleAbyssHandle);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreashAbyss, OnRefreshAbyss);
		Model<AbyssModel>.Interface.RefreshAbyssID();
		_currentAbyssType = AbyssType.Fixed;
		if (uiViewData is MonoAbyssListData { AbyssType: AbyssType.Cycle } && Model<AbyssModel>.Interface.GetCycleAbyssIsUnLock())
		{
			_currentAbyssType = AbyssType.Cycle;
		}
		_abyssDatas = ListPool<AbyssData>.Get();
		ActToggleGroup.SetAllToggleOff();
		ActToggleGroup.Init((int)(_currentAbyssType - 1));
		UpdateAbyssData(_currentAbyssType);
		int jumpIndex = GetJumpIndex();
		RefreshUI(jumpIndex);
		Model<AbyssModel>.Interface.RefreshData();
		bool flag = Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.CycleAbyss);
		bool cycleAbyssIsUnLock = Model<AbyssModel>.Interface.GetCycleAbyssIsUnLock();
		cycleAbyssTab.gameObject.SetActive(cycleAbyssIsUnLock && !flag);
		lockCycleAbyssTab.gameObject.SetActive(!cycleAbyssIsUnLock && !flag);
		if (uiViewData != null && uiViewData is MonoAbyssListData { IsOpenAbyssTeamPanel: not false })
		{
			OpenAbyssTeamPanel(_curSelectItemIndex);
		}
		UIRelativeEffect[] array = uiRelativeEffects;
		foreach (UIRelativeEffect uIRelativeEffect in array)
		{
			Singleton<NewUIManager>.instance.PopUIEffectRenderingList(UIController, uIRelativeEffect.uiEffects);
		}
		PlayBgm();
	}

	protected override void ReInit()
	{
		base.ReInit();
		if (uiViewData != null && uiViewData is MonoAbyssListData { IsOpenAbyssTeamPanel: not false })
		{
			OpenAbyssTeamPanel(_curSelectItemIndex);
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreashAbyss, OnRefreshAbyss);
		ListPool<AbyssData>.Release(_abyssDatas);
		if (_countDown.IsValid())
		{
			_countDown.Cancel();
		}
	}

	private void OnRefreshAbyss(BaseEventContent baseEventContent)
	{
		Model<AbyssModel>.Interface.RefreshAbyssID();
		bool flag = Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.CycleAbyss);
		bool cycleAbyssIsUnLock = Model<AbyssModel>.Interface.GetCycleAbyssIsUnLock();
		cycleAbyssTab.gameObject.SetActive(cycleAbyssIsUnLock && !flag);
		lockCycleAbyssTab.gameObject.SetActive(!cycleAbyssIsUnLock && !flag);
		if (_currentAbyssType == AbyssType.Cycle)
		{
			_currentAbyssType = AbyssType.Fixed;
			SwitchAbyssType(2);
		}
	}

	public void SwitchAbyssType(int abyssType)
	{
		if (_currentAbyssType == (AbyssType)abyssType)
		{
			return;
		}
		_currentAbyssType = (AbyssType)abyssType;
		UpdateAbyssData(_currentAbyssType);
		int jumpIndex = 0;
		RepeatedField<AbyssStage> abyssStages = Model<AbyssModel>.Interface.AbyssStages;
		for (int i = 0; i < _abyssDatas.Count; i++)
		{
			if (abyssStages[i].IsUnlock && abyssStages[i].CompletedNum == 0)
			{
				jumpIndex = abyssStages[i].Index;
				break;
			}
		}
		RefreshUI(jumpIndex);
		betterAnimation.GetSequence("RightTabShow").Play();
		PlayBgm();
	}

	private void PlayBgm()
	{
		if (_audioID != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_audioID);
			_audioID = 0u;
		}
		string eventPath = ((_currentAbyssType == AbyssType.Fixed) ? "event:/UI/Interface/Abyss/GreenAmb_Loop" : "event:/UI/Interface/Abyss/RedAmb_Loop");
		_audioID = Singleton<GameManager>.instance.audioManager.PlaySound(eventPath, new AudioPlayOptions
		{
			attachTarget = Camera.main.transform,
			IsLoop = true
		});
	}

	private void UpdateAbyssData(AbyssType abyssType)
	{
		_abyssDatas.Clear();
		int[] array = null;
		foreach (KeyValuePair<int, AbyssGroupData> abyssGroupData in RuntimeConfigs.data.abyssGroupDatas)
		{
			if (abyssGroupData.Value.abyssType != (int)abyssType)
			{
				continue;
			}
			switch (abyssType)
			{
			case AbyssType.Fixed:
				_groupID = abyssGroupData.Key;
				array = abyssGroupData.Value.abyssInclude;
				goto end_IL_008e;
			case AbyssType.Cycle:
				if (TimeManager.ServerTime.NowTimestamp > abyssGroupData.Value.abyssGroupEndTs)
				{
					break;
				}
				_groupID = abyssGroupData.Key;
				array = abyssGroupData.Value.abyssInclude;
				goto end_IL_008e;
			}
			continue;
			end_IL_008e:
			break;
		}
		if (array != null)
		{
			foreach (int key in array)
			{
				_abyssDatas.Add(RuntimeConfigs.data.abyssDatas[key]);
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Abyss/Open");
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		audioManager.PlaySound("event:/UI/Interface/Abyss/Close");
		audioManager.Stop(_audioID);
		_audioID = 0u;
	}

	private async void PlayItemAnimation()
	{
		for (int i = 0; i < _loopScrollRect.Children.Count; i++)
		{
			CommonSubWorldEntranceItem component = _loopScrollRect.Children[i].GetComponent<CommonSubWorldEntranceItem>();
			if (!(component == null))
			{
				component.CanvasGroup.alpha = 0f;
			}
		}
		for (int j = 0; j < _loopScrollRect.Children.Count; j++)
		{
			CommonSubWorldEntranceItem component2 = _loopScrollRect.Children[j].GetComponent<CommonSubWorldEntranceItem>();
			if (component2 != null)
			{
				component2.CanvasGroup.alpha = 1f;
				component2.PlayAnimation();
			}
			await UniTask.Delay(30);
		}
	}

	protected override void OnPushStack()
	{
		base.OnPushStack();
		if (_abyssTeamSubView.gameObject.activeSelf)
		{
			UIRelativeEffect[] array = uiRelativeEffects;
			foreach (UIRelativeEffect uIRelativeEffect in array)
			{
				Singleton<NewUIManager>.instance.PopUIEffectRenderingList(UIController, uIRelativeEffect.uiEffects);
			}
			_abyssTeamSubView.OnPushStack();
		}
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		if (_abyssTeamSubView.gameObject.activeSelf)
		{
			UIRelativeEffect[] array = uiRelativeEffects;
			foreach (UIRelativeEffect uIRelativeEffect in array)
			{
				Singleton<NewUIManager>.instance.PushUIEffectRenderingList(UIController, uIRelativeEffect.uiEffects);
			}
			_abyssTeamSubView.OnPopStack();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		RepeatedField<UniversalItem> cacheQuickStageRewards = Model<AbyssModel>.Interface.GetCacheQuickStageRewards();
		if (cacheQuickStageRewards != null && cacheQuickStageRewards.Count > 0)
		{
			OpenQuickStageRewards(cacheQuickStageRewards);
			Model<AbyssModel>.Interface.CacheQuickStageRewards(null);
		}
	}

	public void OnClose()
	{
		if (_abyssTeamSubView != null && _abyssTeamSubView.gameObject.activeSelf)
		{
			CloseAbyssTeamPanel();
			return;
		}
		Close();
		if (MonoECS.instance.sceneStatus == SceneStatus.Abyss)
		{
			Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
		}
	}

	public void OnClickLockCycleAbyssHandle()
	{
		lockCycleAbyssTab.SetIsOnWithoutNotify(val: false);
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.CycleAbyss))
		{
			GameUtility.OpenToolTip(Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.CycleAbyss));
		}
		else
		{
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2902));
		}
	}

	private int GetJumpIndex()
	{
		int result = 0;
		MonoAbyssListData monoAbyssListData = uiViewData as MonoAbyssListData;
		if (monoAbyssListData != null && monoAbyssListData.AbyssId > 0)
		{
			result = _abyssDatas.FindIndex((AbyssData x) => x.id == monoAbyssListData.AbyssId);
		}
		else
		{
			RepeatedField<AbyssStage> abyssStages = Model<AbyssModel>.Interface.AbyssStages;
			for (int num = 0; num < _abyssDatas.Count; num++)
			{
				if (abyssStages[num].IsUnlock && abyssStages[num].CompletedNum == 0)
				{
					result = abyssStages[num].Index;
					break;
				}
			}
		}
		return result;
	}

	public void OpenDetailView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			titleTextId = 1108,
			descTextId = 1109,
			titleStringType = LocalizationUtility.localizeTableName_Common,
			localizedStringType = LocalizationUtility.localizeTableName_Common
		});
	}

	public void OpenHistoryRecordView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSHISTORYRECORD);
	}

	private async void RefreshUI(int jumpIndex)
	{
		_curSelectItemIndex = jumpIndex;
		int offestIndex = ((jumpIndex >= 4) ? (jumpIndex - 4) : 0);
		_loopScrollRect.ClearCells();
		_loopScrollRect.ClearCellsPool();
		_loopScrollRect.OnItemShow.RemoveAllListeners();
		_loopScrollRect.OnItemShow.AddListener(OnScrollItemShow);
		_loopScrollRect.totalCount = _abyssDatas.Count;
		await UniTask.DelayFrame(1);
		_loopScrollRect.RefillCells();
		_loopScrollRect.ScrollToCellWithinTime(offestIndex, 0f);
		fixedAbyssBG.SetActive(_currentAbyssType == AbyssType.Fixed);
		cycleAbyssBG.SetActive(_currentAbyssType == AbyssType.Cycle);
		CommonSubWorldEntranceItem commonSubWorldEntranceItem = _loopScrollRect.GetItem(jumpIndex) as CommonSubWorldEntranceItem;
		commonSubWorldEntranceItem.SetSelect(value: true);
		_lastSelectItemIndex = commonSubWorldEntranceItem.index;
		ControlLayerDic[AbyssListViewControllerType.Main].DefaultSelect = commonSubWorldEntranceItem.SelectableEx;
		RefreshRight(_abyssDatas[jumpIndex]);
		if (_countDown.IsValid())
		{
			_countDown.Cancel();
		}
		if (_currentAbyssType == AbyssType.Cycle && RuntimeConfigs.data.abyssGroupDatas.TryGetValue(_groupID, out var _))
		{
			RefreshCoutDown();
			_countDown = UpdateTimer.Default.LoopMs(100, RefreshCoutDown);
		}
		_battleReport.gameObject.SetActive(_currentAbyssType == AbyssType.Cycle && Model<AbyssModel>.Interface.GetHistoryRecords().Count > 0);
		_nextRefresh.gameObject.SetActive(_currentAbyssType == AbyssType.Cycle);
		PlayItemAnimation();
	}

	private void RefreshRight(AbyssData abyssData)
	{
		AbyssStage abyssStage = Model<AbyssModel>.Interface.AbyssStages.FirstOrDefault((AbyssStage x) => x.Index == _curSelectItemIndex);
		IsComplete(_curSelectItemIndex);
		List<int> list = new List<int>();
		List<int> completeIndexs = new List<int>();
		List<ItemUnifierProxy> list2 = new List<ItemUnifierProxy>();
		int num = 0;
		bool value = default;
		for (int num2 = 0; num2 < abyssData.abyssReward.Count; num2++)
		{
			int id = abyssData.abyssReward[num2].id;
			int count = abyssData.abyssReward[num2].count;
			bool flag = (abyssStage.Target != null && abyssStage.Target.TargetReward.TryGetValue(id, out value)) & value;
			list.Add(abyssData.abyssReward[num2].id);
			if (!RuntimeConfigs.data.collections.TryGetValue(count, out var value2))
			{
				continue;
			}
			foreach (ItemKv item in value2.certain)
			{
				ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(new Item
				{
					Id = item.id,
					Count = item.count
				});
				itemUnifierProxy.RewardTag = (UniversalItemTag)(num2 + 2);
				list2.Add(itemUnifierProxy);
				if (flag)
				{
					completeIndexs.Add(num);
				}
				num++;
			}
		}
		bool isComplete = abyssStage.Target != null && abyssStage.Target.IsPerfect;
		_title.RefreshUI(abyssData.abyssNameLocal, isComplete, abyssData.abyssRecommendedLevel, abyssStage?.StageMinimumSecs ?? 0);
		_target.RefreshUI(list, abyssStage?.Target);
		_rewards.RefreshUI(list2, Station);
		_rewards.OnItemShowAction = (ItemUIComponentBase item) =>
		{
			if ((object)item != null)
			{
				item.IsComplete = completeIndexs.Contains(item.Index);
			}
		};
		if (IsUnlock(_curSelectItemIndex))
		{
			_lockTips.SetActive(value: false);
			_gotoTeamSubView.gameObject.SetActive(value: true);
		}
		else
		{
			_lockTips.SetActive(value: true);
			_gotoTeamSubView.gameObject.SetActive(value: false);
			AbyssData abyssData2 = GetAbyssData(_curSelectItemIndex - 1);
			_lockTipsDescription.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, abyssData2.abyssNameLocal);
		}
		foreach (KeyValuePair<int, JumpAbyss> item2 in RuntimeConfigs.data.jumpAbysss)
		{
			_ = item2.Value.nextJumpFloor;
		}
		_completeTips.SetActive(GetIsDisplayQuickCompleteTips(Model<AbyssModel>.Interface.CurAbyssData));
		_first.SetActive(value: true);
		_firstDescription.text = GetBuffDesc(abyssData.subabyss[0]);
		_second.SetActive(abyssData.subabyss.Length >= 2);
		if (abyssData.subabyss.Length >= 2)
		{
			_secondDescription.text = GetBuffDesc(abyssData.subabyss[1]);
		}
	}

	private bool GetIsDisplayQuickCompleteTips(Abyss abyss)
	{
		if (_currentAbyssType != AbyssType.Cycle)
		{
			return false;
		}
		if (abyss.JumpStartFloor < _curSelectItemIndex + 1)
		{
			return false;
		}
		return true;
	}

	private string GetBuffDesc(int subAbyssId)
	{
		if (!RuntimeConfigs.data.subabyssDatas.TryGetValue(subAbyssId, out var value))
		{
			return string.Empty;
		}
		int skillGroupLevelId = TableRule.GetSkillGroupLevelId(value.buffId, 1);
		if (RuntimeConfigs.data.skillGroupLevelDatas.TryGetValue(skillGroupLevelId, out var value2))
		{
			return CustomTagParser.ReplaceSkillMessageText(value2.skillDes[0], "longcommon", isBrief: false);
		}
		return string.Empty;
	}

	private void RefreshCoutDown()
	{
		if (RuntimeConfigs.data.abyssGroupDatas.TryGetValue(_groupID, out var value))
		{
			long num = value.abyssGroupEndTs / 1000 - TimeManager.ServerTime.NowTimestampSecond;
			TimeSpan timeSpan = TimeSpan.FromSeconds(num);
			if ((double)num >= TimeSpan.FromDays(1.0).TotalSeconds)
			{
				IList<object> list = new List<object>();
				list.Add(timeSpan.TotalDays);
				list.Add(timeSpan.Hours);
				_nextRefreshTime.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1647, list);
				return;
			}
			IList<object> list2 = new List<object>();
			list2.Add(timeSpan.Hours);
			string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 586, list2);
			IList<object> list3 = new List<object>();
			list3.Add(timeSpan.Minutes);
			string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 587, list3);
			IList<object> list4 = new List<object>();
			list4.Add(timeSpan.Seconds);
			string localizeString3 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 597, list4);
			_nextRefreshTime.text = localizeString + localizeString2 + localizeString3;
		}
	}

	private void OnScrollItemShow(ILoopScrollDataSource loopScrollDataSource)
	{
		CommonSubWorldEntranceItem item = loopScrollDataSource as CommonSubWorldEntranceItem;
		if ((object)item == null)
		{
			return;
		}
		AbyssData abyssData = GetAbyssData(item.index);
		AbyssStage abyssStage = Model<AbyssModel>.Interface.AbyssStages.FirstOrDefault((AbyssStage x) => x.Index == item.index);
		if (abyssData != null)
		{
			List<int> list = new List<int>();
			for (int num = 0; num < abyssData.abyssReward.Count; num++)
			{
				list.Add(abyssData.abyssReward[num].id);
			}
			item.RefreshUI(item.index, abyssData.abyssNameLocal, list, abyssStage?.Target, IsUnlock(item.index), (int index) =>
			{
				OnItemClick(item);
			});
			if (_curSelectItemIndex >= 0)
			{
				item.SetSelect(_curSelectItemIndex == item.index);
			}
		}
	}

	public void OnItemClick(CommonSubWorldEntranceItem raidItem)
	{
		if (raidItem == null)
		{
			return;
		}
		if (_lastSelectItemIndex >= 0)
		{
			CommonSubWorldEntranceItem commonSubWorldEntranceItem = _loopScrollRect.GetItem(_lastSelectItemIndex) as CommonSubWorldEntranceItem;
			if (commonSubWorldEntranceItem != null)
			{
				commonSubWorldEntranceItem.SetSelect(value: false);
			}
		}
		_curSelectItemIndex = raidItem.index;
		_lastSelectItemIndex = raidItem.index;
		raidItem.SetSelect(value: true);
		betterAnimation.StopAnimation();
		betterAnimation.GetSequence("RightTabHide").OnComplete((AnimationBuilder _) =>
		{
			RefreshRight(GetAbyssData(raidItem.index));
			betterAnimation.GetSequence("RightTabShow").Play();
		}).Play();
	}

	public AbyssData GetAbyssData(int index)
	{
		if (index >= _abyssDatas.Count)
		{
			return null;
		}
		return _abyssDatas[index];
	}

	public bool IsUnlock(int index)
	{
		if (Model<AbyssModel>.Interface.AbyssStages.Count > index)
		{
			return Model<AbyssModel>.Interface.AbyssStages[index].IsUnlock;
		}
		return false;
	}

	public bool IsComplete(int index)
	{
		if (Model<AbyssModel>.Interface.AbyssStages.Count > index)
		{
			return Model<AbyssModel>.Interface.AbyssStages[index].CompletedNum != 0;
		}
		return false;
	}

	public int GetStarNum(int index)
	{
		return Model<AbyssModel>.Interface.GetStarNumber(index);
	}

	private async void OpenQuickStageRewards(RepeatedField<UniversalItem> universalItems)
	{
		await UniTask.DelayFrame(1);
		PopUpRewardOneRowData uiData = new PopUpRewardOneRowData
		{
			itemSource = universalItems
		};
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSPOPUPREWARDONEROW, uiData);
	}

	public async void OpenAbyssTeamPanel(int index)
	{
		_abyssTeamSubView.gameObject.SetActive(value: true);
		_abyssTeamSubView.Initialize(this, _groupID, index);
		ChangeAbyssListViewControl(AbyssListViewControllerType.AbyssTeamCharacter);
		await UniTask.DelayFrame(1);
		UIRelativeEffect[] array = uiRelativeEffects;
		foreach (UIRelativeEffect uIRelativeEffect in array)
		{
			Singleton<NewUIManager>.instance.PushUIEffectRenderingList(UIController, uIRelativeEffect.uiEffects);
		}
	}

	public void CloseAbyssTeamPanel()
	{
		_abyssTeamSubView.gameObject.SetActive(value: false);
		_abyssTeamSubView.UnInitialize();
		UIRelativeEffect[] array = uiRelativeEffects;
		foreach (UIRelativeEffect uIRelativeEffect in array)
		{
			Singleton<NewUIManager>.instance.PopUIEffectRenderingList(UIController, uIRelativeEffect.uiEffects);
		}
		Singleton<CharacterVoiceManager>.instance.StopCharacterVoice();
	}

	public AbyssTeamSubView GetAbyssTeamSubView()
	{
		return _abyssTeamSubView;
	}

	protected override void OnInputDeviceChange(DeviceInputMode inputMode)
	{
		GamepadTipsRoot.gameObject.SetActive(inputMode == DeviceInputMode.Gamepad);
		LB.SetActive(inputMode == DeviceInputMode.Gamepad);
		RB.SetActive(inputMode == DeviceInputMode.Gamepad);
		if (inputMode != DeviceInputMode.Gamepad)
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
				if ((bool)component)
				{
					component.SetIsOn(val: false);
				}
			}
		}
		else
		{
			ChangeAbyssListViewControl(GetControlType(), isRefocus: true);
		}
	}

	public AbyssListViewControllerType GetControlType()
	{
		if (_abyssTeamSubView.gameObject.activeSelf)
		{
			if (_abyssTeamSubView.CurTeamInfoTab == AbyssTeamSubView.TeamInfoTab.Character)
			{
				return AbyssListViewControllerType.AbyssTeamCharacter;
			}
			return AbyssListViewControllerType.AbyssTeamPreset;
		}
		if (ControlType == AbyssListViewControllerType.Main || ControlType == AbyssListViewControllerType.MainReward)
		{
			return ControlType;
		}
		return AbyssListViewControllerType.Main;
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public async void ChangeAbyssListViewControl(AbyssListViewControllerType abyssListViewControllerType, bool isRefocus = false)
	{
		await UniTask.DelayFrame(2);
		AbyssListViewControllerType controlType = ControlType;
		ControlType = abyssListViewControllerType;
		if (isRefocus)
		{
			ControlLayerDic[abyssListViewControllerType].ReFocus();
		}
		else
		{
			ControlLayerDic[abyssListViewControllerType].UnFocus();
			ControlLayerDic[abyssListViewControllerType].Focus();
		}
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[abyssListViewControllerType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType].Count; j++)
		{
			ControlPromts[controlType][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[abyssListViewControllerType].Count; k++)
		{
			ControlPromts[abyssListViewControllerType][k].SetActive(value: true);
		}
		if (abyssListViewControllerType == AbyssListViewControllerType.AbyssTeamCharacter && EventSystemHelper.CurrentSelected != null)
		{
			AbyssBagCharacterItemUIComponent component = EventSystemHelper.CurrentSelected.GetComponent<AbyssBagCharacterItemUIComponent>();
			component.SetIsOn(val: true);
			SelectPromptLabel.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, (component.TeamIndex == 0) ? 906 : 14);
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		}
		if (ControlType == AbyssListViewControllerType.Main && EventSystemHelper.CurrentSelected != null)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
		if (ControlType == AbyssListViewControllerType.AbyssTeamCharacter)
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				AbyssBagCharacterItemUIComponent component = EventSystemHelper.CurrentSelected.GetComponent<AbyssBagCharacterItemUIComponent>();
				component.SetIsOn(val: true);
				SelectPromptLabel.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, (component.TeamIndex == 0) ? 906 : 14);
			}
		}
		else
		{
			SelectPromptLabel.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 774);
		}
	}

	public void HandleConfirm()
	{
		if (EventSystemHelper.CurrentSelected == null)
		{
			return;
		}
		if (ControlType == AbyssListViewControllerType.Main)
		{
			_gotoTeamSubView.OnSubmit(null);
			return;
		}
		ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler.OnSubmit(data);
		});
	}

	public void ChangeMainTab(AbyssType abyssType)
	{
		if (abyssType == _currentAbyssType)
		{
			return;
		}
		if (abyssType == AbyssType.Cycle)
		{
			if (Model<AbyssModel>.Interface.GetCycleAbyssIsUnLock())
			{
				cycleAbyssTab.OnSubmit(null);
				ChangeAbyssListViewControl(AbyssListViewControllerType.Main);
			}
			else
			{
				lockCycleAbyssTab.OnSubmit(null);
			}
		}
		else
		{
			fixedAbyssTab.OnSubmit(null);
			ChangeAbyssListViewControl(AbyssListViewControllerType.Main);
		}
	}
}
