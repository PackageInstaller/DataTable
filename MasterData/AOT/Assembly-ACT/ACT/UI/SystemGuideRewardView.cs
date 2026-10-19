using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SystemGuideRewardView : BaseUIView<SystemGuideRewardViewInputController>
{
	private SystemGuideRewardViewData m_data;

	[SerializeField]
	public BookLevelOSA bookLevelOSA;

	[OdinSerialize]
	public Dictionary<JourneyTraceSubController, ViewControlLayer> ViewControlLayers;

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
	}

	protected override void Init()
	{
		base.Init();
		int vhIndex = bookLevelOSA.Reload(this);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		bookLevelOSA.OnSelectIndex(bookLevelOSA.GetItemViewsHolder(vhIndex));
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show").Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadTipsActive(bool active)
	{
		SystemGuideRewardViewInputController controller = GetController();
		if (controller == null || !active || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return;
		}
		if (ViewControlLayers.TryGetValue(controller.ControllerType, out var value))
		{
			value.Focus();
		}
		if (EventSystemHelper.CurrentSelected != null)
		{
			BookLevelRewardItem component = EventSystemHelper.CurrentSelected.GetComponent<BookLevelRewardItem>();
			if (component != null)
			{
				component.btnPrompt_confirm.SetActive(controller.ControllerType == JourneyTraceSubController.main && component.unLockRoot.activeSelf);
				component.btnPrompt_item.SetActive(controller.ControllerType == JourneyTraceSubController.main);
			}
		}
	}

	public JourneyTraceSubController GetCurSubControllerType()
	{
		return GetController()?.ControllerType ?? JourneyTraceSubController.main;
	}

	public void ChangeToGamePadInputState(JourneyTraceSubController type, bool needReFocusLayer = false)
	{
		SystemGuideRewardViewInputController controller = GetController();
		if (controller == null)
		{
			return;
		}
		controller.ControllerType = type;
		if (!ViewControlLayers.TryGetValue(type, out var value))
		{
			return;
		}
		if (needReFocusLayer)
		{
			value.ReFocus();
			if (EventSystemHelper.CurrentSelected != null)
			{
				BookLevelRewardItem component = EventSystemHelper.CurrentSelected.GetComponent<BookLevelRewardItem>();
				if (component != null)
				{
					component.btnPrompt_confirm.SetActive(type == JourneyTraceSubController.main && component.unLockRoot.activeSelf);
					component.btnPrompt_item.SetActive(type == JourneyTraceSubController.main);
				}
			}
			return;
		}
		if (EventSystemHelper.CurrentSelected != null)
		{
			BookLevelRewardItem component2 = EventSystemHelper.CurrentSelected.GetComponent<BookLevelRewardItem>();
			if (component2 != null)
			{
				component2.btnPrompt_confirm.SetActive(type == JourneyTraceSubController.main && component2.unLockRoot.activeSelf);
				component2.btnPrompt_item.SetActive(type == JourneyTraceSubController.main);
			}
		}
		value.Focus();
	}

	public void HandleGamePadSelectButtonInput(JourneyTraceSubController type)
	{
		switch (type)
		{
		case JourneyTraceSubController.main:
		{
			SystemGuideRewardViewInputController controller = GetController();
			if (controller != null && controller.CurSelectItem != null)
			{
				BookLevelRewardItem component = controller.CurSelectItem.GetComponent<BookLevelRewardItem>();
				if (component != null && component.btn.interactable)
				{
					component.btn.OnClick?.Invoke();
				}
			}
			break;
		}
		case JourneyTraceSubController.SelectItem:
			if ((bool)EventSystemHelper.CurrentSelected)
			{
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
				{
					handler.OnSubmit(data);
				});
			}
			break;
		}
	}
}
