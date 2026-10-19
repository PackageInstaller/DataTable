using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.ItemDetail;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.UI;

public class MonoPopUpItemDetailPanel : BaseUIView<PopUpItemDetailInputViewInputController>
{
	[FormerlySerializedAs("_commonItemDetail")]
	[SerializeField]
	public CommonItemDetail commonItemDetail;

	public GamePadTipsComp gamePadTipsComp;

	[NonSerialized]
	public Dictionary<string, GamePadTipsAction> GamePadTipsActionDic = new Dictionary<string, GamePadTipsAction>
	{
		{
			"UI/Confirm",
			new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		},
		{
			"UI/Back",
			new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			}
		},
		{
			"UI/RSUpDownSelect",
			new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			}
		}
	};

	[NonSerialized]
	public List<GamePadTipsAction> GamePadTipsActions = new List<GamePadTipsAction>();

	protected override void Init()
	{
		base.Init();
		CommonItemDetail commonItemDetail = this.commonItemDetail;
		commonItemDetail.OnContentChanged = (Action)Delegate.Combine(commonItemDetail.OnContentChanged, new Action(UpdateGamePadTips));
		CommonItemDetail commonItemDetail2 = this.commonItemDetail;
		commonItemDetail2.OnInputStateChanged = (Action)Delegate.Combine(commonItemDetail2.OnInputStateChanged, new Action(UpdateGamePadTips));
		CommonItemDetail commonItemDetail3 = this.commonItemDetail;
		commonItemDetail3.OnJumpSuccess = (Action)Delegate.Combine(commonItemDetail3.OnJumpSuccess, new Action(OnItemDetailJumpSuccess));
		this.commonItemDetail.Station = Station;
		this.commonItemDetail.Context = uiViewData;
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Item_Window_Open");
	}

	protected override void UnInit()
	{
		base.UnInit();
		CommonItemDetail commonItemDetail = this.commonItemDetail;
		commonItemDetail.OnContentChanged = (Action)Delegate.Remove(commonItemDetail.OnContentChanged, new Action(UpdateGamePadTips));
		CommonItemDetail commonItemDetail2 = this.commonItemDetail;
		commonItemDetail2.OnInputStateChanged = (Action)Delegate.Remove(commonItemDetail2.OnInputStateChanged, new Action(UpdateGamePadTips));
		CommonItemDetail commonItemDetail3 = this.commonItemDetail;
		commonItemDetail3.OnJumpSuccess = (Action)Delegate.Remove(commonItemDetail3.OnJumpSuccess, new Action(OnItemDetailJumpSuccess));
		this.commonItemDetail.FocusOut();
		uiViewData = null;
	}

	private void OnItemDetailJumpSuccess()
	{
		Close();
	}

	protected override void OnMoveToShow()
	{
		base.OnMoveToShow();
		commonItemDetail.UpdateGamepadStyle();
	}

	public void OnClickItemUIComponent(GameObject target)
	{
		if (!target.GetComponent<ItemUIComponentBase>())
		{
			Close();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		commonItemDetail.FocusIn();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		try
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder x) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			OpenEffectFinishNew();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		try
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder x) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			CloseEffectFinishNew();
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		UpdateGamePadTips();
	}

	private void UpdateGamePadTips()
	{
		if (!(gamePadTipsComp == null))
		{
			gamePadTipsComp.gameObject.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
			ItemDetailViewGamePadTipsType itemDetailViewGamePadTipsType = ItemDetailViewGamePadTipsType.BackAndScroll;
			switch (commonItemDetail.InputState)
			{
			case ItemDetailGamePadInputState.Item_NoFocus:
				itemDetailViewGamePadTipsType = ItemDetailViewGamePadTipsType.BackAndScroll;
				break;
			case ItemDetailGamePadInputState.Item_FocusJumpPart:
				itemDetailViewGamePadTipsType = ItemDetailViewGamePadTipsType.ConfirmAndBack;
				break;
			}
			switch (itemDetailViewGamePadTipsType)
			{
			case ItemDetailViewGamePadTipsType.BackAndScroll:
				gamePadTipsComp.ClearAllPrompts();
				GamePadTipsActions.Clear();
				GamePadTipsActions.Add(GamePadTipsActionDic["UI/Back"]);
				GamePadTipsActions.Add(GamePadTipsActionDic["UI/RSUpDownSelect"]);
				gamePadTipsComp.RegisterInputActions(GamePadTipsActions);
				gamePadTipsComp.RefreshAllPrompts();
				gamePadTipsComp.SetAllPromptsVisible(visible: true);
				break;
			case ItemDetailViewGamePadTipsType.ConfirmAndBack:
				gamePadTipsComp.ClearAllPrompts();
				GamePadTipsActions.Clear();
				GamePadTipsActions.Add(GamePadTipsActionDic["UI/Confirm"]);
				GamePadTipsActions.Add(GamePadTipsActionDic["UI/Back"]);
				gamePadTipsComp.RegisterInputActions(GamePadTipsActions);
				gamePadTipsComp.RefreshAllPrompts();
				gamePadTipsComp.SetAllPromptsVisible(visible: true);
				break;
			}
		}
	}
}
