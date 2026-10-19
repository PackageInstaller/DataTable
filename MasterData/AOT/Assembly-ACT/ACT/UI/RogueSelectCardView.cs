using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Runtime.Model;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class RogueSelectCardView : BaseUIView<RogueSelectCardViewInputController>
{
	private RogueSelectCardViewData m_data;

	public GameObject RogueCardSelectItemPrefab;

	public Transform TfCard;

	public ActButton BtnConfirm;

	public ActButton BtnRule;

	private int SelectedBdCoreId;

	private RogueCardSelectItem _lastSelectedItem;

	private RogueCardSelectItem _CurrentSelectedItem;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	private Dictionary<int, BdCore> UnLockbdCores = new Dictionary<int, BdCore>();

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

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
		BtnConfirm.SetBtnClick(SelectCard);
		SelectedBdCoreId = 0;
	}

	protected override void Init()
	{
		base.Init();
		_lastSelectedItem = null;
		SetRogueCard();
		RefreshPanel();
		viewControlLayer?.Focus();
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public void SetRogueCard()
	{
		Dictionary<int, BdCore> bdCores = RuntimeConfigs.data.bdCores;
		if (TfCard.childCount > 0)
		{
			TfCard.DestroyChildren();
		}
		UnLockbdCores.Clear();
		foreach (KeyValuePair<int, BdCore> item2 in bdCores)
		{
			if (item2.Value.bdUnlockConditionId == 0)
			{
				UnLockbdCores.Add(item2.Key, item2.Value);
				continue;
			}
			BdUnlockCondition data = CoreUtils.GetData(item2.Value.bdUnlockConditionId, RuntimeConfigs.data.bdUnlockConditions);
			if (Model<RogueNewModel>.Interface.GetAllTalentNodeCost() >= data.number)
			{
				UnLockbdCores.Add(item2.Key, item2.Value);
			}
		}
		RogueCardSelectItem rogueCardSelectItem = null;
		foreach (KeyValuePair<int, BdCore> bdCore in UnLockbdCores)
		{
			RogueCardSelectItem item = UIUtility.AddWidget<RogueCardSelectItem>(TfCard, RogueCardSelectItemPrefab);
			item.Init(bdCore.Value, Station);
			item.BtnClick.SetBtnClick(() =>
			{
				_CurrentSelectedItem = item;
				SelectedBdCoreId = bdCore.Value.id;
				_lastSelectedItem?.RefreshSelect(IsSelect: false);
				item.RefreshSelect(IsSelect: true);
				RefreshPanel();
				_lastSelectedItem = _CurrentSelectedItem;
			});
			if (rogueCardSelectItem == null)
			{
				rogueCardSelectItem = item;
			}
		}
		EventSystemHelper.SetSelectedGameObject(rogueCardSelectItem?.gameObject);
		ExecuteEvents.Execute(rogueCardSelectItem?.gameObject, new PointerEventData(EventSystemHelper.Shared), ExecuteEvents.submitHandler);
	}

	private void RefreshPanel()
	{
		BtnConfirm.Interactable(SelectedBdCoreId != 0);
	}

	public void SelectCard()
	{
		Model<RogueNewModel>.Interface.RogueChallengeInfo.coreId = SelectedBdCoreId;
		Model<RogueNewModel>.Interface.SendRogueChallenge(0L);
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
