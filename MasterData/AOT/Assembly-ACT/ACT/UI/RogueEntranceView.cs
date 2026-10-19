using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Runtime.Model;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class RogueEntranceView : BaseUIView<RogueEntranceViewInputController>
{
	private const int DescriptionScrollPromptLocalizeId = 2165;

	private const float DescriptionScrollSpeed = 500f;

	private RogueEntranceViewData m_data;

	public ActButton BtnClose;

	public ActButton BtnRogueShop;

	public ActButton BtnSkillTree;

	public LocalizeStringEvent TextName;

	public CommonSubWorldEntranceDescription CommonSubWorldEntranceDescription;

	public TextMeshProUGUI TextLevel;

	public TextMeshProUGUI TextTime;

	public Transform TfRogueEntranceItem;

	public GameObject RogueEntranceItemPrefab;

	public TextMeshProUGUI TextCurrentNum;

	public CommonSubWorldEntranceTargetItem CommonSubWorldEntranceTargetItem;

	public CommonSubWorldEntranceRewards CommonSubWorldEntranceRewards;

	public Button BtnExplain;

	public CommonCoinGroup CoinGroup;

	public ActButton BtnStart;

	public ActButton BtnContinue;

	public ActButton BtnOver;

	public GamePadTipsComp gamePadTipsComp;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	[Header("OutCoin")]
	public TextMeshProUGUI MaxOutCoinNum;

	public TextMeshProUGUI CurrentOutCoinNum;

	public Color MaxColor;

	public Color NormalColor;

	[Header("timer")]
	public CommonTimerComponent Timer;

	public OperateBtnPrompt _descriptionScrollOperateBtnPrompt;

	private Dictionary<int, RogueMode> RogueModeDic = new Dictionary<int, RogueMode>();

	private int SelectedModeId;

	private RogueEntranceItem lastSelectedItem;

	private List<ItemUnifierProxy> rewardItems = new List<ItemUnifierProxy>();

	private ScrollRect _descriptionScrollRect;

	private TextMeshProUGUI _descriptionText;

	private bool _canDescriptionScroll;

	private bool _descriptionScrollSuspended;

	private List<int> _unLocklist = new List<int>();

	private bool isContinue;

	public bool IsContinue => isContinue;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		SelectedModeId = 0;
		BtnClose.SetBtnClick(Close);
		BtnStart.SetBtnClick(OnGoNext);
		BtnContinue.SetBtnClick(OnContinue);
		BtnSkillTree.SetBtnClick(OnOpenSkillTree);
		BtnRogueShop.SetBtnClick(OnOpenRogueShop);
		BtnOver.SetBtnClick(OnOver);
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		RefreshPanel();
	}

	private void OnOver()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				Model<RogueNewModel>.Interface.SendRogueFinishGame(RogueFinishType.Quit, (RogueFinishGameAck ack) =>
				{
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueOpenSettlement, null);
				});
			},
			commonId = 2789
		});
	}

	public void OnOpenRogueShop()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SHOP, new ShopViewData
		{
			FirstTabID = 6,
			SecondTabID = 701
		});
	}

	protected override void Init()
	{
		base.Init();
		lastSelectedItem = null;
		isContinue = Model<RogueNewModel>.Interface.Info.GameState == StageStateEnum.StageStateTmpLeave;
		BtnStart.Interactable(SelectedModeId != 0);
		BtnStart.gameObject.SetActive(value: false);
		BtnContinue.gameObject.SetActive(value: false);
		BtnOver.gameObject.SetActive(value: false);
		InitUnLockList();
		InitRewardItems();
		InitDescriptionScroll();
		InitPanel();
	}

	private void Refresh()
	{
		SelectedModeId = 0;
		Init();
	}

	private void RefreshPanel()
	{
		Refresh();
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		_descriptionScrollSuspended = false;
		ScrollDescription(Vector2.zero);
		ItemUnifierProxy.ItemUnifierPool.Release(rewardItems);
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void InitUnLockList()
	{
		RogueModeDic = Model<RogueNewModel>.Interface.ListRogueMode;
		_unLocklist.Clear();
		foreach (RogueMode value2 in RogueModeDic.Values)
		{
			G.detailUserInfo.Attributes.TryGetValue(90, out var value);
			if (value2.unlockRequiredRogueModeId == 0)
			{
				if (value >= value2.unlockRequiredPlayerLevel)
				{
					_unLocklist.Add(value2.id);
				}
			}
			else if (Model<RogueNewModel>.Interface.Info.ClearedMode.Contains(value2.unlockRequiredRogueModeId) && value >= value2.unlockRequiredPlayerLevel)
			{
				_unLocklist.Add(value2.id);
			}
		}
	}

	private void InitPanel()
	{
		if (TfRogueEntranceItem.childCount > 0)
		{
			TfRogueEntranceItem.DestroyChildren();
		}
		int num = (isContinue ? Model<RogueNewModel>.Interface.Info.GameInfo.ModeId : ((_unLocklist.Count > 0) ? _unLocklist[_unLocklist.Count - 1] : 0));
		RogueEntranceItem rogueEntranceItem = null;
		foreach (RogueMode mode in RogueModeDic.Values)
		{
			RogueEntranceItem item = UIUtility.AddWidget<RogueEntranceItem>(TfRogueEntranceItem, RogueEntranceItemPrefab);
			item.Init(mode);
			item.BtnClick.SetBtnClick(() =>
			{
				if (!isContinue)
				{
					SelectEntranceItem(item, mode.id);
				}
			});
			if (num != 0 && mode.id == num)
			{
				rogueEntranceItem = item;
			}
		}
		viewControlLayer.SetDefaultSelect(null);
		if (rogueEntranceItem != null)
		{
			SelectEntranceItem(rogueEntranceItem, num);
			viewControlLayer.SetDefaultSelect(rogueEntranceItem.GetComponent<ACT.ViewControl.SelectableEx>());
		}
		else if (isContinue)
		{
			SelectedModeId = num;
			ItemClick();
		}
		Season data = CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.SeasonId, RuntimeConfigs.data.seasons);
		TextName.StringReference.TableEntryReference = data.name;
		SetSeasonRemainTime();
		SetOutCoin();
		viewControlLayer.Focus();
	}

	private void SelectEntranceItem(RogueEntranceItem item, int modeId)
	{
		if (!(item == null))
		{
			lastSelectedItem?.SetSelect(isSelect: false, needAni: true);
			item.SetSelect(isSelect: true, needAni: true);
			SelectedModeId = modeId;
			ItemClick();
			lastSelectedItem = item;
		}
	}

	private void ItemClick()
	{
		if (RogueModeDic.TryGetValue(SelectedModeId, out var value))
		{
			RefreshPanel(value);
		}
	}

	private void RefreshPanel(RogueMode mode)
	{
		BtnStart.Interactable(SelectedModeId != 0);
		BtnStart.gameObject.SetActive(!isContinue);
		BtnContinue.gameObject.SetActive(isContinue);
		BtnOver.gameObject.SetActive(isContinue);
		TextCurrentNum.SetText("{0:0}", mode.id);
		TextLevel.SetText("{0:0}", mode.rogueRecommendedLevel);
		CommonSubWorldEntranceDescription.RefreshUI(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, mode.description));
		RefreshDescriptionScrollState();
		CommonSubWorldEntranceTargetItem.RefreshState(Model<RogueNewModel>.Interface.Info.ClearedMode.Contains(mode.id));
		CommonSubWorldEntranceRewards.RefreshUI(rewardItems, Station, ItemUIComponentBase.ItemCountShowType.Hide);
	}

	private void InitRewardItems()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(rewardItems);
		rewardItems.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(87, 0L));
		rewardItems.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(89, 0L));
	}

	private void InitDescriptionScroll()
	{
		if (!(CommonSubWorldEntranceDescription == null))
		{
			if ((object)_descriptionScrollRect == null)
			{
				_descriptionScrollRect = CommonSubWorldEntranceDescription.GetComponentInChildren<ScrollRect>(includeInactive: true);
			}
			if ((object)_descriptionText == null)
			{
				_descriptionText = CommonSubWorldEntranceDescription.GetComponentInChildren<TextMeshProUGUI>(includeInactive: true);
			}
			if (!(_descriptionScrollRect == null) && _descriptionScrollOperateBtnPrompt != null)
			{
				_descriptionScrollOperateBtnPrompt.SetBindingAction("UI/ScrollViewRightStickControl");
				_descriptionScrollOperateBtnPrompt.SetLocalizeString(2165);
			}
		}
	}

	private void RefreshDescriptionScrollState()
	{
		InitDescriptionScroll();
		if (!(_descriptionScrollRect == null))
		{
			_descriptionText?.ForceMeshUpdate();
			Canvas.ForceUpdateCanvases();
			if (_descriptionScrollRect.content != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(_descriptionScrollRect.content);
			}
			Canvas.ForceUpdateCanvases();
			bool flag = _descriptionScrollRect.content != null && _descriptionScrollRect.viewport != null && _descriptionScrollRect.content.rect.height > _descriptionScrollRect.viewport.rect.height + 0.01f;
			_descriptionScrollRect.verticalNormalizedPosition = 1f;
			if (_descriptionScrollRect.verticalScrollbar != null)
			{
				_descriptionScrollRect.verticalScrollbar.gameObject.SetActive(flag);
			}
			_canDescriptionScroll = flag;
			_descriptionScrollOperateBtnPrompt?.SetVisible(flag && !_descriptionScrollSuspended);
			if (!flag)
			{
				ScrollDescription(Vector2.zero);
			}
		}
	}

	public void ScrollDescription(Vector2 value)
	{
		if (!(_descriptionScrollRect == null))
		{
			if (_descriptionScrollSuspended || !_canDescriptionScroll)
			{
				_descriptionScrollRect.velocity = Vector2.zero;
			}
			else
			{
				_descriptionScrollRect.velocity = new Vector2(0f, (0f - value.y) * 500f);
			}
		}
	}

	public void SetDescriptionScrollSuspended(bool suspended)
	{
		_descriptionScrollSuspended = suspended;
		if (suspended)
		{
			ScrollDescription(Vector2.zero);
		}
		_descriptionScrollOperateBtnPrompt?.SetVisible(!suspended && _canDescriptionScroll);
	}

	private void SetSeasonRemainTime()
	{
		if (!(Timer == null) && Model<RogueNewModel>.HasInstance() && Model<RogueNewModel>.Interface.Info != null)
		{
			CommonTimerComponent timer = Timer;
			System.DateTime minValue = System.DateTime.MinValue;
			timer.Time = minValue.AddMilliseconds(Model<RogueNewModel>.Interface.RemainRefreshTimeStamp);
			Timer.IsCountDown = true;
		}
	}

	private void SetOutCoin()
	{
		if (!Model<RogueNewModel>.HasInstance() || Model<RogueNewModel>.Interface.Info == null)
		{
			return;
		}
		RogueInfo info = Model<RogueNewModel>.Interface.Info;
		Season data = CoreUtils.GetData(info.SeasonId, RuntimeConfigs.data.seasons);
		if (data != null)
		{
			int weeklyCoinGain = info.WeeklyCoinGain;
			int cycleMax = data.cycleMax;
			CurrentOutCoinNum?.SetText("{0:0}", weeklyCoinGain);
			MaxOutCoinNum?.SetText("{0:0}", cycleMax);
			if (CurrentOutCoinNum != null)
			{
				CurrentOutCoinNum.color = ((weeklyCoinGain >= cycleMax) ? MaxColor : NormalColor);
			}
		}
	}

	public void OnGoNext()
	{
		Model<RogueNewModel>.Interface.RogueChallengeInfo.modeId = SelectedModeId;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUETEAM, new RogueTeamViewData
		{
			ModeId = SelectedModeId
		});
	}

	public void OnContinue()
	{
		Model<RogueNewModel>.Interface.SendRogueContinueGame();
	}

	public void OnOpenSkillTree()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUETALENTTREE);
	}
}
