using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.UI.Interface;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Spine;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class WorldLevelPage : BaseTabContent
{
	private const string RoleIdleAnimationName = "idle_normal";

	private const string RoleBreakAnimationName = "idle_openeyes";

	private static readonly int DeSaturateProperty = Shader.PropertyToID("_DeSaturate");

	private static readonly int ParticleMinAlphaProperty = Shader.PropertyToID("_minAlpha");

	[SerializeField]
	private RectTransform _roleImage;

	[SerializeField]
	private RectTransform _roleImage2;

	[SerializeField]
	private ActButton _btnLeftWorldLevel;

	[SerializeField]
	private ActButton _btnRightWorldLevel;

	[SerializeField]
	private GameObject _leftWorldLevelGamepadPrompt;

	[SerializeField]
	private GameObject _rightWorldLevelGamepadPrompt;

	[SerializeField]
	private Image _topRewardImage;

	[SerializeField]
	private TextMeshProUGUI _topRewardLevel;

	[SerializeField]
	private PlayerLevelGroup _playerLevelGroup;

	[SerializeField]
	private RectTransform _systemUnLockGroupRT;

	[SerializeField]
	private RectTransform _systemUnLockItemParent;

	[SerializeField]
	private SystemUnlockItem _systemUnLockItemTemplate;

	[SerializeField]
	private RectTransform _systemUnLockTitleRT;

	[SerializeField]
	private RectTransform _worldLevelGroupRT;

	[SerializeField]
	private TextMeshProUGUI _currWorldLevel;

	[SerializeField]
	private Image arrow;

	[SerializeField]
	private TextMeshProUGUI _nextWorldLevel;

	[SerializeField]
	public ActButton _btn_WorldLevelTips;

	[SerializeField]
	private RectTransform _worldLevelTaskGroupRT;

	[SerializeField]
	private WorldLevelBreakthroughMissionItem _worldLevelTaskItemTemplate;

	[SerializeField]
	private CommonScrollBagComponent _rewardScrollBag;

	[SerializeField]
	private RectTransform _rewardScrollBagRT;

	[SerializeField]
	private RectTransform _template;

	[SerializeField]
	private RectTransform _content;

	[SerializeField]
	public ActButton _btn_reward;

	[SerializeField]
	private GameObject _breakWorldLevelGamepadPrompt;

	[SerializeField]
	private TextMeshProUGUI _rewardText;

	[SerializeField]
	private TextMeshProUGUI _DifferentStateDesc;

	[SerializeField]
	private TextMeshProUGUI worldLevelImage01;

	[SerializeField]
	private TextMeshProUGUI worldLevelImage02;

	[SerializeField]
	public Button _btn_tips;

	[SerializeField]
	private RedDotItem redDotItem;

	[SerializeField]
	private RectTransform _UIParticle_Loop;

	private int _selectedWorldLevel;

	private List<int> missionGroup;

	private List<int> systemIdGroup;

	private List<Item> m_repeatRewardItems = new List<Item>();

	private List<ItemUnifierProxy> _rewards;

	private Collection reward;

	private Collection _pendingWorldLevelBreakReward;

	private IList<UniversalItem> _pendingWorldLevelBreakGotItems;

	private List<ItemKv> certainRewards;

	private float maxWidth;

	private float _lastPopRewardTime = -1f;

	private MonoJourneyTracesView _journeyTracesView;

	private int _lastSelectedWorldLevelTaskIndex;

	private int _activeWorldLevelTaskItemCount;

	private bool _eventListenerAdded;

	private Material _topRewardOriginalMaterial;

	private Material _topRewardMaterialInstance;

	private SkeletonGraphic _roleImageSpine;

	private SkeletonGraphic _roleImage2Spine;

	private readonly List<WorldLevelBreakthroughMissionItem> _worldLevelTaskItems = new List<WorldLevelBreakthroughMissionItem>();

	private readonly List<SystemUnlockItem> _systemUnlockItems = new List<SystemUnlockItem>();

	protected new virtual void OnTabActive(ITabItem tabItem)
	{
		gameObject.SetActive(value: true);
	}

	protected new virtual void OnTabDeActive(ITabItem tabItem)
	{
		gameObject.SetActive(value: false);
	}

	public void Refresh(MonoJourneyTracesView journeyTracesView)
	{
		_journeyTracesView = journeyTracesView;
		ApplyParticleMinAlpha();
		maxWidth = _rewardScrollBagRT.sizeDelta.x;
		if (_rewards == null)
		{
			_rewards = ListPool<ItemUnifierProxy>.Get();
		}
		RefreshRoleImage();
		SelectWorldLevel(Model<WorldLevelModel>.Interface.GetDefaultBreakTargetWorldLevel());
		if (_btnLeftWorldLevel != null)
		{
			_btnLeftWorldLevel.SetBtnClick(OnClickLeftWorldLevel);
		}
		if (_btnRightWorldLevel != null)
		{
			_btnRightWorldLevel.SetBtnClick(OnClickRightWorldLevel);
		}
		if (_btn_WorldLevelTips != null)
		{
			_btn_WorldLevelTips.SetBtnClick(OnClickWorldLevelTipsBtn);
		}
		_btn_reward.SetBtnClick(OnClickRewardBtn);
		_btn_tips.SetBtnClick(ShowSystemExplanation);
		AddEventListener();
	}

	private void ApplyParticleMinAlpha()
	{
		ApplyParticleMinAlpha(_UIParticle_Loop);
	}

	private static void ApplyParticleMinAlpha(Transform particleRoot)
	{
		if (particleRoot == null)
		{
			return;
		}
		ParticleSystemRenderer[] componentsInChildren = particleRoot.GetComponentsInChildren<ParticleSystemRenderer>(includeInactive: true);
		foreach (ParticleSystemRenderer particleSystemRenderer in componentsInChildren)
		{
			if (!(particleSystemRenderer == null))
			{
				Material material = particleSystemRenderer.material;
				if (material != null && material.HasProperty(ParticleMinAlphaProperty))
				{
					material.SetFloat(ParticleMinAlphaProperty, 1f);
				}
			}
		}
	}

	public void RefreshJumpSelection(MonoJourneyTracesView journeyTracesView)
	{
		_journeyTracesView = journeyTracesView;
		SelectWorldLevel(Model<WorldLevelModel>.Interface.GetDefaultBreakTargetWorldLevel());
	}

	private void RefreshRoleImage()
	{
		CacheRoleSpineComponents();
		bool flag = G.detailUserInfo.Brief.Gender == 2;
		_roleImage.gameObject.SetActive(flag);
		_roleImage2.gameObject.SetActive(!flag);
		PlayCurrentRoleIdleAnimation();
	}

	private void CacheRoleSpineComponents()
	{
		if ((object)_roleImageSpine == null)
		{
			_roleImageSpine = ((_roleImage != null) ? _roleImage.GetComponent<SkeletonGraphic>() : null);
		}
		if ((object)_roleImage2Spine == null)
		{
			_roleImage2Spine = ((_roleImage2 != null) ? _roleImage2.GetComponent<SkeletonGraphic>() : null);
		}
	}

	private SkeletonGraphic GetCurrentRoleSpine()
	{
		CacheRoleSpineComponents();
		if (_roleImage != null && _roleImage.gameObject.activeInHierarchy)
		{
			return _roleImageSpine;
		}
		if (_roleImage2 != null && _roleImage2.gameObject.activeInHierarchy)
		{
			return _roleImage2Spine;
		}
		if (G.detailUserInfo.Brief.Gender != 2)
		{
			return _roleImage2Spine;
		}
		return _roleImageSpine;
	}

	private void PlayCurrentRoleIdleAnimation()
	{
		PlayRoleAnimation("idle_normal", loop: true);
	}

	private void PlayCurrentRoleBreakAnimation()
	{
		SkeletonGraphic currentRoleSpine = GetCurrentRoleSpine();
		if (TryPrepareRoleAnimation(currentRoleSpine, "idle_openeyes"))
		{
			Spine.AnimationState animationState = currentRoleSpine.AnimationState;
			animationState.ClearTrack(0);
			animationState.SetAnimation(0, "idle_openeyes", loop: false);
			if (animationState.Data?.SkeletonData?.FindAnimation("idle_normal") != null)
			{
				animationState.AddAnimation(0, "idle_normal", loop: true, 0f);
			}
		}
	}

	private void PlayRoleAnimation(string animationName, bool loop)
	{
		SkeletonGraphic currentRoleSpine = GetCurrentRoleSpine();
		if (TryPrepareRoleAnimation(currentRoleSpine, animationName))
		{
			Spine.AnimationState animationState = currentRoleSpine.AnimationState;
			animationState.ClearTrack(0);
			animationState.SetAnimation(0, animationName, loop);
		}
	}

	private bool TryPrepareRoleAnimation(SkeletonGraphic roleSpine, string animationName)
	{
		if (roleSpine == null || string.IsNullOrEmpty(animationName))
		{
			return false;
		}
		if (roleSpine.AnimationState == null || roleSpine.Skeleton == null)
		{
			roleSpine.Initialize(overwrite: true);
		}
		Spine.AnimationState animationState = roleSpine.AnimationState;
		if (animationState == null)
		{
			return false;
		}
		if (animationState.Data?.SkeletonData?.FindAnimation(animationName) == null)
		{
			Debug.LogWarning("Role spine animation not found: " + animationName, roleSpine);
			return false;
		}
		return true;
	}

	private void OnClickWorldLevelTipsBtn()
	{
		if (_selectedWorldLevel >= 2)
		{
			int description = RuntimeConfigs.data.playerWorldLevelDataNews[_selectedWorldLevel].description;
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPWORLDLEVELINTRODUCTION, new PopUpWorldLevelIntroductionViewData
			{
				title = 2211,
				description = description
			});
		}
	}

	private void RefreshLeftBottomLevel()
	{
		int curWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
		int num = curWorldLevel / 10;
		int num2 = curWorldLevel % 10;
		if (worldLevelImage01 != null)
		{
			worldLevelImage01.SetText("{0:0}", num);
		}
		if (worldLevelImage02 != null)
		{
			worldLevelImage02.SetText("{0:0}", num2);
		}
	}

	protected override void OnRelease()
	{
		base.OnRelease();
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		ListPool<ItemUnifierProxy>.Release(_rewards);
		RemoveEventListener();
		ReleaseTopRewardMaterial();
	}

	protected override void OnUnityDestroy()
	{
		RemoveEventListener();
		base.OnUnityDestroy();
	}

	private void AddEventListener()
	{
		if (!_eventListenerAdded)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_WorldLevelPageRefresh, Refresh);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_WorldLevelUpGradeClose, OpenPopupAward);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_WorldLevelUpGradeClose, OpenPopupAward);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PopRewardOpened, PopRewardOpened);
			if (Singleton<PreconditionInfoManager>.HasInstance())
			{
				Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskProgressChange;
			}
			_eventListenerAdded = true;
		}
	}

	private void RemoveEventListener()
	{
		if (_eventListenerAdded)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_WorldLevelPageRefresh, Refresh);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_WorldLevelUpGradeClose, OpenPopupAward);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PopRewardOpened, PopRewardOpened);
			if (Singleton<PreconditionInfoManager>.HasInstance())
			{
				Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskProgressChange;
			}
			_eventListenerAdded = false;
		}
	}

	private void Refresh(BaseEventContent baseEventContent)
	{
		if (IsAlive())
		{
			SelectWorldLevel(_selectedWorldLevel);
		}
	}

	private void RefreshSelectedWorldLevel()
	{
		SetActiveIfAlive(_worldLevelGroupRT, active: true);
		RefreshTopRewardPreview();
		RefreshWorldLevelStep();
		RefreshWordLevelTaskGroup();
		RefreshSystemUnLockGroup();
		RefreshRewardBtn();
		RefreshRewardListInfos();
	}

	private void OnClickLeftWorldLevel()
	{
		TrySelectPreviousWorldLevel();
	}

	private void OnClickRightWorldLevel()
	{
		TrySelectNextWorldLevel();
	}

	public bool TrySelectPreviousWorldLevel()
	{
		if (!CanSelectPreviousWorldLevel())
		{
			return false;
		}
		SelectWorldLevel(_selectedWorldLevel - 1);
		return true;
	}

	public bool TrySelectNextWorldLevel()
	{
		if (!CanSelectNextWorldLevel())
		{
			return false;
		}
		SelectWorldLevel(_selectedWorldLevel + 1);
		return true;
	}

	public void SelectWorldLevel(int targetWorldLevel)
	{
		if (IsAlive())
		{
			_selectedWorldLevel = Mathf.Clamp(targetWorldLevel, 2, Model<WorldLevelModel>.Interface.MaxWorldLevel);
			RefreshSelectedWorldLevel();
			RefreshPlayerLevelGroup();
			RefreshLeftBottomLevel();
			RefreshWorldLevelArrowState();
		}
	}

	private void RefreshPlayerLevelGroup()
	{
		if (_playerLevelGroup != null)
		{
			_playerLevelGroup.Refresh();
		}
	}

	private void SetActiveIfAlive(RectTransform rectTransform, bool active)
	{
		if (!(rectTransform == null))
		{
			rectTransform.gameObject.SetActive(active);
		}
	}

	private bool IsAlive()
	{
		if (this != null)
		{
			return gameObject != null;
		}
		return false;
	}

	private void RefreshWorldLevelStep()
	{
		if (_currWorldLevel != null)
		{
			_currWorldLevel.SetText("{0:0}", _selectedWorldLevel - 1);
		}
		if (arrow != null)
		{
			arrow.gameObject.SetActive(value: true);
		}
		if (_nextWorldLevel != null)
		{
			_nextWorldLevel.gameObject.SetActive(value: true);
			_nextWorldLevel.SetText("{0:0}", _selectedWorldLevel);
		}
	}

	private void RefreshWorldLevelArrowState()
	{
		bool active = CanSelectPreviousWorldLevel();
		bool active2 = CanSelectNextWorldLevel();
		if (_btnLeftWorldLevel != null)
		{
			_btnLeftWorldLevel.gameObject.SetActive(value: true);
			_btnLeftWorldLevel.Interactable(active);
		}
		if (_btnRightWorldLevel != null)
		{
			_btnRightWorldLevel.gameObject.SetActive(value: true);
			_btnRightWorldLevel.Interactable(active2);
		}
		RefreshWorldLevelGamepadPromptState(_journeyTracesView == null || _journeyTracesView.GetCurSubControllerType() == JourneyTraceSubController.main || _journeyTracesView.GetCurSubControllerType() == JourneyTraceSubController.SelectWorldLevelTaskGroup);
	}

	public void RefreshWorldLevelGamepadPromptState(bool active)
	{
		if (_leftWorldLevelGamepadPrompt != null)
		{
			_leftWorldLevelGamepadPrompt.SetActive(active && CanSelectPreviousWorldLevel());
		}
		if (_rightWorldLevelGamepadPrompt != null)
		{
			_rightWorldLevelGamepadPrompt.SetActive(active && CanSelectNextWorldLevel());
		}
	}

	private bool CanSelectPreviousWorldLevel()
	{
		return _selectedWorldLevel > 2;
	}

	private bool CanSelectNextWorldLevel()
	{
		return _selectedWorldLevel < Model<WorldLevelModel>.Interface.MaxWorldLevel;
	}

	private void RefreshTopRewardPreview()
	{
		bool flag = _selectedWorldLevel > Model<WorldLevelModel>.Interface.GetCurWorldLevel();
		if (TryGetTopRewardMaterial(out var material))
		{
			material.SetFloat(DeSaturateProperty, flag ? 1f : 0f);
		}
		if (_topRewardLevel != null)
		{
			_topRewardLevel.SetText("{0:00}", _selectedWorldLevel);
		}
	}

	private bool TryGetTopRewardMaterial(out Material material)
	{
		material = null;
		if (_topRewardImage == null)
		{
			return false;
		}
		if (_topRewardMaterialInstance == null)
		{
			_topRewardOriginalMaterial = _topRewardImage.material;
			if (_topRewardOriginalMaterial == null || !_topRewardOriginalMaterial.HasProperty(DeSaturateProperty))
			{
				return false;
			}
			_topRewardMaterialInstance = new Material(_topRewardOriginalMaterial);
			_topRewardImage.material = _topRewardMaterialInstance;
		}
		material = _topRewardMaterialInstance;
		return true;
	}

	private void ReleaseTopRewardMaterial()
	{
		if (!(_topRewardMaterialInstance == null))
		{
			if (_topRewardImage != null && _topRewardImage.material == _topRewardMaterialInstance)
			{
				_topRewardImage.material = _topRewardOriginalMaterial;
			}
			Object.Destroy(_topRewardMaterialInstance);
			_topRewardMaterialInstance = null;
			_topRewardOriginalMaterial = null;
		}
	}

	private void RefreshWordLevelTaskGroup()
	{
		if (!(_worldLevelTaskGroupRT == null) && !(_worldLevelTaskItemTemplate == null))
		{
			missionGroup = Model<WorldLevelModel>.Interface.GetWorldLevelBreakTaskGroup(_selectedWorldLevel);
			Model<WorldLevelModel>.Interface.CurrentSelectWorldLevel = _selectedWorldLevel;
			int worldLevelTaskItemsActive = (_activeWorldLevelTaskItemCount = missionGroup?.Count ?? 0);
			RefreshWorldLevelTaskItems();
			SetWorldLevelTaskItemsActive(worldLevelTaskItemsActive);
			_lastSelectedWorldLevelTaskIndex = 0;
			RebuildWorldLevelTaskLayout();
			RefreshWorldLevelTaskGamepadStates();
			if (!TryApplyGuideWorldLevelTaskGroupSelection() && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && _journeyTracesView != null && _journeyTracesView.GetCurSubControllerType() == JourneyTraceSubController.SelectWorldLevelTaskGroup)
			{
				TryEnterWorldLevelTaskGroupSelection();
			}
		}
	}

	private void OnTaskProgressChange(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		if (IsAlive() && !(_worldLevelTaskGroupRT == null) && !(_worldLevelTaskItemTemplate == null) && missionGroup != null && missionGroup.Contains(taskId))
		{
			RefreshWorldLevelTaskItems();
			RebuildWorldLevelTaskLayout();
			RefreshWorldLevelTaskGamepadStates();
			RefreshRewardBtn();
		}
	}

	private void RefreshWorldLevelTaskItems()
	{
		int num = missionGroup?.Count ?? 0;
		for (int i = 0; i < num; i++)
		{
			WorldLevelBreakthroughMissionItem orCreateWorldLevelTaskItem = GetOrCreateWorldLevelTaskItem(i);
			if (!(orCreateWorldLevelTaskItem == null))
			{
				orCreateWorldLevelTaskItem.gameObject.SetActive(value: true);
				orCreateWorldLevelTaskItem.ScrollCellIndex(i);
				continue;
			}
			break;
		}
	}

	private WorldLevelBreakthroughMissionItem GetOrCreateWorldLevelTaskItem(int index)
	{
		if (index < _worldLevelTaskItems.Count)
		{
			return _worldLevelTaskItems[index];
		}
		WorldLevelBreakthroughMissionItem worldLevelBreakthroughMissionItem = Object.Instantiate(_worldLevelTaskItemTemplate, _worldLevelTaskGroupRT);
		worldLevelBreakthroughMissionItem.gameObject.SetActive(value: false);
		_worldLevelTaskItems.Add(worldLevelBreakthroughMissionItem);
		return worldLevelBreakthroughMissionItem;
	}

	private void SetWorldLevelTaskItemsActive(int activeCount)
	{
		for (int i = activeCount; i < _worldLevelTaskItems.Count; i++)
		{
			_worldLevelTaskItems[i].gameObject.SetActive(value: false);
		}
	}

	private void RebuildWorldLevelTaskLayout()
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(_worldLevelTaskGroupRT);
		if (_worldLevelTaskGroupRT.parent is RectTransform layoutRoot)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot);
		}
		if (!(_worldLevelGroupRT == null))
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(_worldLevelGroupRT);
			if (_worldLevelGroupRT.parent is RectTransform layoutRoot2)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot2);
			}
		}
	}

	private void RefreshSystemUnLockGroup()
	{
		if (_systemUnLockItemParent == null || _systemUnLockItemTemplate == null)
		{
			return;
		}
		systemIdGroup = Model<WorldLevelModel>.Interface.GetWorldLevelOpenSystemIdList(_selectedWorldLevel);
		List<int> list = systemIdGroup;
		bool active = list != null && list.Count > 0;
		SetActiveIfAlive(_systemUnLockGroupRT, active);
		SetActiveIfAlive(_systemUnLockTitleRT, active);
		int num = systemIdGroup?.Count ?? 0;
		for (int i = 0; i < num; i++)
		{
			SystemUnlockItem orCreateSystemUnlockItem = GetOrCreateSystemUnlockItem(i);
			if (orCreateSystemUnlockItem == null)
			{
				break;
			}
			orCreateSystemUnlockItem.gameObject.SetActive(value: true);
			orCreateSystemUnlockItem.ScrollCellIndex(i);
		}
		for (int j = num; j < _systemUnlockItems.Count; j++)
		{
			_systemUnlockItems[j].gameObject.SetActive(value: false);
		}
		RebuildSystemUnlockLayout();
	}

	private SystemUnlockItem GetOrCreateSystemUnlockItem(int index)
	{
		if (index < _systemUnlockItems.Count)
		{
			return _systemUnlockItems[index];
		}
		SystemUnlockItem systemUnlockItem = Object.Instantiate(_systemUnLockItemTemplate, _systemUnLockItemParent);
		systemUnlockItem.gameObject.SetActive(value: false);
		_systemUnlockItems.Add(systemUnlockItem);
		return systemUnlockItem;
	}

	private void RebuildSystemUnlockLayout()
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(_systemUnLockItemParent);
		if (_systemUnLockItemParent.parent is RectTransform layoutRoot)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot);
		}
		if (!(_systemUnLockGroupRT == null))
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(_systemUnLockGroupRT);
			if (_systemUnLockGroupRT.parent is RectTransform layoutRoot2)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot2);
			}
		}
	}

	private void RefreshRewardListInfos()
	{
		m_repeatRewardItems.Clear();
		if (_selectedWorldLevel <= 1)
		{
			return;
		}
		_rewardScrollBagRT.gameObject.SetActive(value: true);
		reward = GetWorldLevelBreakReward(_selectedWorldLevel);
		if (reward == null)
		{
			_rewardScrollBagRT.gameObject.SetActive(value: false);
			return;
		}
		certainRewards = reward.certain;
		bool flag = Model<WorldLevelModel>.Interface.IsWorldLevelBreakCompleted(_selectedWorldLevel);
		bool flag2 = CanRefreshRewardCellsInPlace();
		if (flag2)
		{
			for (int i = 0; i < _rewards.Count; i++)
			{
				if (_rewards[i].Id != certainRewards[i].id)
				{
					_rewardScrollBag.GetItem(i)?.UnLoadMainIcon();
				}
			}
		}
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		foreach (ItemKv certainReward in certainRewards)
		{
			_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(certainReward.id, certainReward.count));
		}
		_rewardScrollBag.ItemShowType = (flag ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem);
		_rewardScrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		if (!flag2 || !_rewardScrollBag.TryRefreshVisibleCellsInPlace())
		{
			_rewardScrollBag.ItemSource = _rewards;
		}
		Resize();
	}

	private bool CanRefreshRewardCellsInPlace()
	{
		if (_rewardScrollBag.ItemSource != _rewards || _rewards.Count == 0 || _rewards.Count != certainRewards.Count)
		{
			return false;
		}
		for (int i = 0; i < _rewards.Count; i++)
		{
			if (_rewardScrollBag.GetItem(i) == null)
			{
				return false;
			}
		}
		return true;
	}

	private Collection GetWorldLevelBreakReward(int targetWorldLevel)
	{
		int rewardId = RuntimeConfigs.data.playerWorldLevelDataNews[targetWorldLevel - 1].rewardId;
		return RuntimeConfigs.data.collections[rewardId];
	}

	private void Resize()
	{
		float num = _template.rect.width;
		LayoutElement component = _template.GetComponent<LayoutElement>();
		if (component != null)
		{
			num = component.preferredWidth;
		}
		int num2 = _rewardScrollBag.ItemSource.Count();
		GridLayoutGroup component2 = _content.GetComponent<GridLayoutGroup>();
		float a = (float)num2 * num + (float)(num2 - 1) * component2.spacing.x;
		_rewardScrollBagRT.sizeDelta = new Vector2(Mathf.Min(a, maxWidth), _rewardScrollBagRT.sizeDelta.y);
	}

	private void RefreshRewardBtn()
	{
		bool flag = Model<WorldLevelModel>.Interface.IsWorldLevelBreakCompleted(_selectedWorldLevel);
		bool flag2 = Model<WorldLevelModel>.Interface.CanBreakWorldLevel(_selectedWorldLevel);
		if (redDotItem != null)
		{
			redDotItem.gameObject.SetActive(flag2);
		}
		if (_btn_reward != null)
		{
			_btn_reward.gameObject.SetActive(!flag);
			_btn_reward.Interactable(flag2);
		}
		if (_breakWorldLevelGamepadPrompt != null)
		{
			_breakWorldLevelGamepadPrompt.SetActive(flag2);
		}
		if (_DifferentStateDesc != null)
		{
			_DifferentStateDesc.gameObject.SetActive(flag);
			if (flag)
			{
				RefreshDifferentStateDesc();
			}
		}
		if (_rewardText != null)
		{
			_rewardText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, flag2 ? 2209 : 2210);
		}
	}

	private void ShowSystemExplanation()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPPLAYERLVANDWORLDLVVIEW, new PopUpPlayerLvAndWorldLvViewData
		{
			showBtnList = false
		});
	}

	private void OnClickRewardBtn()
	{
		if (!Model<WorldLevelModel>.Interface.CanBreakWorldLevel(_selectedWorldLevel))
		{
			return;
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.WorldLevelBreakClick);
		if (MonoECS.instance.playState == PlayState.Battle || Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CanNotBreakWorldLevel);
			return;
		}
		Model<WorldLevelModel>.Interface.BeforeBreakWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
		_pendingWorldLevelBreakReward = GetWorldLevelBreakReward(_selectedWorldLevel);
		_pendingWorldLevelBreakGotItems = null;
		PlayCurrentRoleBreakAnimation();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ClickWorldLevelBreakBtn, null);
		G.service.SendWorldLevelBreakReq((bool r, IList<UniversalItem> gotItems) =>
		{
			if (r && gotItems != null && gotItems.Count > 0)
			{
				_pendingWorldLevelBreakGotItems = gotItems;
			}
			SetBtnState(isActive: false);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/WorldLevel_Upgrade");
			GameUtility.OpenAdventureTip();
		});
	}

	public void TryBreakWorldLevelByGamepad()
	{
		if (!(_btn_reward == null) && _btn_reward.gameObject.activeInHierarchy && Model<WorldLevelModel>.Interface.CanBreakWorldLevel(_selectedWorldLevel))
		{
			_btn_reward.OnClick?.Invoke();
		}
	}

	public bool TryEnterWorldLevelTaskGroupSelection()
	{
		return TryEnterWorldLevelTaskGroupSelection(0);
	}

	public bool TryEnterWorldLevelTaskGroupSelection(int index)
	{
		if (_worldLevelGroupRT == null || !_worldLevelGroupRT.gameObject.activeInHierarchy)
		{
			return false;
		}
		if (_activeWorldLevelTaskItemCount <= 0)
		{
			return false;
		}
		SelectWorldLevelTaskAtIndex(index);
		return true;
	}

	public bool TryApplyGuideWorldLevelTaskGroupSelection()
	{
		if (!TryGetGuideWorldLevelTaskGroupIndex(out var index))
		{
			return false;
		}
		if (_journeyTracesView == null)
		{
			return false;
		}
		if (_worldLevelGroupRT == null || !_worldLevelGroupRT.gameObject.activeInHierarchy)
		{
			return false;
		}
		if (_activeWorldLevelTaskItemCount <= 0)
		{
			return false;
		}
		_journeyTracesView.ChangeToGamePadInputState(JourneyTraceSubController.SelectWorldLevelTaskGroup);
		return TryEnterWorldLevelTaskGroupSelection(index);
	}

	public bool MoveWorldLevelTaskSelection(MoveDirection direction)
	{
		if (direction != MoveDirection.Up && direction != MoveDirection.Down)
		{
			return false;
		}
		if (_activeWorldLevelTaskItemCount <= 0)
		{
			return false;
		}
		int value = GetSelectedWorldLevelTaskItem()?.index ?? _lastSelectedWorldLevelTaskIndex;
		value = Mathf.Clamp(value, 0, _activeWorldLevelTaskItemCount - 1);
		int index = ((direction == MoveDirection.Up) ? Mathf.Max(0, value - 1) : Mathf.Min(_activeWorldLevelTaskItemCount - 1, value + 1));
		SelectWorldLevelTaskAtIndex(index);
		return true;
	}

	public bool TryClickSelectedWorldLevelTaskGoto()
	{
		if (TryGetGuideWorldLevelTaskGroupIndex(out var index))
		{
			SelectWorldLevelTaskAtIndex(index);
			return _worldLevelTaskItems[index]?.TryClickGoto() ?? false;
		}
		return GetSelectedWorldLevelTaskItem()?.TryClickGoto() ?? false;
	}

	public void RefreshWorldLevelTaskGamepadStates()
	{
		for (int i = 0; i < _activeWorldLevelTaskItemCount; i++)
		{
			WorldLevelBreakthroughMissionItem worldLevelBreakthroughMissionItem = _worldLevelTaskItems[i];
			if (worldLevelBreakthroughMissionItem != null && worldLevelBreakthroughMissionItem.gameObject.activeInHierarchy)
			{
				worldLevelBreakthroughMissionItem.RefreshGamepadInputState(_journeyTracesView);
			}
		}
	}

	private WorldLevelBreakthroughMissionItem GetSelectedWorldLevelTaskItem()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected != null))
		{
			return null;
		}
		return currentSelected.GetComponentInParent<WorldLevelBreakthroughMissionItem>(includeInactive: true);
	}

	private bool TryGetGuideWorldLevelTaskGroupIndex(out int index)
	{
		index = Model<WorldLevelModel>.Interface.GuideWorldLevelTaskGroupIndex;
		if (Model<WorldLevelModel>.Interface.HasGuideWorldLevelTaskGroupIndex && Singleton<GameState>.instance != null && Singleton<GameState>.instance.InGuiding && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && index >= 0)
		{
			return index < _activeWorldLevelTaskItemCount;
		}
		return false;
	}

	private void SelectWorldLevelTaskAtIndex(int index)
	{
		if (index < 0 || index >= _activeWorldLevelTaskItemCount)
		{
			return;
		}
		_lastSelectedWorldLevelTaskIndex = index;
		ACT.ViewControl.SelectableEx worldLevelTaskSelectable = GetWorldLevelTaskSelectable(index);
		if (!(worldLevelTaskSelectable == null))
		{
			EventSystemHelper.SetSelectedGameObject(worldLevelTaskSelectable.gameObject);
			if (_journeyTracesView != null && _journeyTracesView.ViewControlLayers.TryGetValue(JourneyTraceSubController.SelectWorldLevelTaskGroup, out var value) && value != null)
			{
				value.DefaultSelect = worldLevelTaskSelectable;
			}
			RefreshWorldLevelTaskGamepadStates();
		}
	}

	private ACT.ViewControl.SelectableEx GetWorldLevelTaskSelectable(int index)
	{
		if (index < 0 || index >= _activeWorldLevelTaskItemCount)
		{
			return null;
		}
		return _worldLevelTaskItems[index].GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	public void SetBtnState(bool isActive)
	{
		if (IsAlive() && !(_btn_reward == null))
		{
			_btn_reward.Interactable(isActive);
		}
	}

	private void OpenPopupAward(BaseEventContent baseEventContent)
	{
		IList<UniversalItem> pendingWorldLevelBreakGotItems = _pendingWorldLevelBreakGotItems;
		Collection collection = _pendingWorldLevelBreakReward ?? reward;
		_pendingWorldLevelBreakGotItems = null;
		_pendingWorldLevelBreakReward = null;
		if (pendingWorldLevelBreakGotItems != null && pendingWorldLevelBreakGotItems.Count > 0)
		{
			TryShowPopReward(pendingWorldLevelBreakGotItems);
		}
		else if (collection != null)
		{
			TryShowPopReward(collection);
		}
	}

	public void TryShowPopReward(Collection collection)
	{
		float time = Time.time;
		if (time - _lastPopRewardTime >= 1f)
		{
			_lastPopRewardTime = time;
			Debug.LogWarning("打开领奖界面==");
			ShowPopReward(collection);
		}
	}

	private void TryShowPopReward(IList<UniversalItem> rewardItems)
	{
		if (rewardItems != null && rewardItems.Count > 0)
		{
			float time = Time.time;
			if (time - _lastPopRewardTime >= 1f)
			{
				_lastPopRewardTime = time;
				Debug.LogWarning("打开领奖界面==");
				ShowPopReward(rewardItems);
			}
		}
	}

	private void ShowPopReward(IList<UniversalItem> rewardItems)
	{
		if (rewardItems == null || rewardItems.Count <= 0)
		{
			return;
		}
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPREWARDONE);
		if (firstUIState != UIState.Opening && firstUIState != UIState.Opened)
		{
			GameUtility.OpenPopReward(rewardItems, notSort: false, () =>
			{
				SetBtnState(isActive: true);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PopRewardClose, null);
			});
		}
	}

	private void ShowPopReward(Collection collection)
	{
		List<Item> items = ListPool<Item>.Get();
		foreach (ItemKv item2 in collection.certain)
		{
			Item item = new Item
			{
				Id = item2.id,
				Count = item2.count
			};
			items.Add(item);
		}
		if (items.Count > 0)
		{
			UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPREWARDONE);
			if (firstUIState == UIState.Opening || firstUIState == UIState.Opened)
			{
				items.Clear();
				ListPool<Item>.Release(items);
				return;
			}
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items), notSort: false, () =>
			{
				SetBtnState(isActive: true);
				items.Clear();
				ListPool<Item>.Release(items);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PopRewardClose, null);
			});
		}
		else
		{
			ListPool<Item>.Release(items);
		}
	}

	private void PopRewardOpened(BaseEventContent obj)
	{
		if (IsAlive() && Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_MONOJOURNEYTRACESVIEW) != null)
		{
			Model<PlayerModel>.Interface.RefreshWorldLevelTabRedDot();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_JourneyTracesTabRefresh, null);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_WorldLevelPageRefresh, null);
		}
	}

	private void RefreshDifferentStateDesc()
	{
		_DifferentStateDesc.gameObject.SetActive(value: true);
		_DifferentStateDesc.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2206);
	}
}
