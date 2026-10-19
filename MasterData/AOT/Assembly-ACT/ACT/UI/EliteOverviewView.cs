using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.EventTrack;
using ACT.UI.InputController.EliteOverview;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EliteOverviewView : BaseUIView<EliteOverviewViewInputController>
{
	private EliteOverviewViewData m_data;

	[SerializeField]
	private EliteOverview _overview;

	[SerializeField]
	private ActButton closeBtn;

	[SerializeField]
	private GamePadTipsComp gamePadTipsComp;

	[SerializeField]
	private ViewControlRoot viewControlRoot;

	[SerializeField]
	private ViewControlLayer viewControlLayer;

	[SerializeField]
	private RightStickScrollSupport leftScrollSupport;

	[SerializeField]
	private RightStickScrollSupport rightScrollSupport;

	public GameObject leftHighLightRoot;

	private const float LeftStickDeadZone = 0.2f;

	private bool _isLeftPanelSelected;

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
		closeBtn.OnClick.AddListener(CloseBtn_OnClick);
	}

	protected override void Init()
	{
		base.Init();
		m_data = (EliteOverviewViewData)uiViewData;
		_overview.Init(m_data._character, Station);
		EnsureScrollSupportsCached();
		_isLeftPanelSelected = false;
		SetLeftPanelSelected(_isLeftPanelSelected);
		OnControllerStatusChange(MonoECS.instance.InputMode);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
		CharacterEliteStageClick evt = EventTrackSolver.Instance.GetEvt<CharacterEliteStageClick>();
		evt.characterId = m_data._character.Id;
		evt.characterLevel = m_data._character.Level;
		evt.eliteLevel = m_data._character.EliteInfo.Levels.Sum((KeyValuePair<int, int> kvp) => kvp.Value);
		evt.eliteStage = m_data._character.GetEliteActiveNum();
		evt.eliteStageId = m_data._eliteId;
		evt.status = 1;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectCallback();
			}).Play();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		closeBtn.OnClick.RemoveAllListeners();
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
		gamePadTipsComp?.ClearAllPrompts();
		SetLeftHighLightActive(active: false);
		leftScrollSupport?.SetForbidScroll(isForbid: false);
		rightScrollSupport?.SetForbidScroll(isForbid: false);
		CharacterEliteStageClick evt = EventTrackSolver.Instance.GetEvt<CharacterEliteStageClick>();
		evt.characterId = m_data._character.Id;
		evt.characterLevel = m_data._character.Level;
		evt.eliteLevel = m_data._character.EliteInfo.Levels.Sum((KeyValuePair<int, int> kvp) => kvp.Value);
		evt.eliteStage = m_data._character.GetEliteActiveNum();
		evt.eliteStageId = m_data._eliteId;
		evt.status = 2;
		EventTrackSolver.Instance.Dispatch(evt);
		RefreshLevelUpNewPromptIfNeeded();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectCallback();
			}).Play();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void CloseBtn_OnClick()
	{
		_overview.UnInit();
		Close();
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		if (!(gamePadTipsComp == null))
		{
			gamePadTipsComp.ClearAllPrompts();
			if (deviceInputMode != DeviceInputMode.Gamepad)
			{
				UnFocus();
				SetLeftHighLightActive(active: false);
				return;
			}
			Focus();
			List<GamePadTipsAction> inputActions = new List<GamePadTipsAction>
			{
				new GamePadTipsAction
				{
					inputAction = "LargeMapView/Return",
					localizeKey = 606,
					localizeTable = "Common"
				},
				new GamePadTipsAction
				{
					inputAction = "UI/SwitchInteractGamePadY",
					localizeKey = 2165,
					localizeTable = "Common"
				}
			};
			gamePadTipsComp.RegisterInputActions(inputActions);
		}
	}

	public void HandleLeftStickHorizontalInput(float value)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			if (value <= -0.2f)
			{
				SetLeftPanelSelected(selected: true);
			}
			else if (value >= 0.2f)
			{
				SetLeftPanelSelected(selected: false);
			}
		}
	}

	private void Focus()
	{
		if (!(viewControlLayer == null))
		{
			if (viewControlLayer.Root?.CurrentFocusLayer != null)
			{
				viewControlLayer.ReFocus();
			}
			else
			{
				viewControlLayer.Focus();
			}
			viewControlRoot?.SelectDefault();
		}
	}

	private void UnFocus()
	{
		viewControlLayer?.UnFocus();
	}

	private void SetLeftHighLightActive(bool active)
	{
		if (leftHighLightRoot != null)
		{
			leftHighLightRoot.SetActive(active);
		}
	}

	private void SetLeftPanelSelected(bool selected)
	{
		_isLeftPanelSelected = selected;
		SetLeftHighLightActive(selected);
		ApplyRightStickScrollTarget();
	}

	private void ApplyRightStickScrollTarget()
	{
		if (leftScrollSupport != null)
		{
			leftScrollSupport.SetForbidScroll(!_isLeftPanelSelected);
		}
		if (rightScrollSupport != null)
		{
			rightScrollSupport.SetForbidScroll(_isLeftPanelSelected);
		}
	}

	private void EnsureScrollSupportsCached()
	{
		if (leftScrollSupport != null && rightScrollSupport != null)
		{
			return;
		}
		RightStickScrollSupport[] componentsInChildren = GetComponentsInChildren<RightStickScrollSupport>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return;
		}
		if (componentsInChildren.Length == 1)
		{
			if ((object)rightScrollSupport == null)
			{
				rightScrollSupport = componentsInChildren[0];
			}
			return;
		}
		Array.Sort(componentsInChildren, (RightStickScrollSupport a, RightStickScrollSupport b) => a.transform.position.x.CompareTo(b.transform.position.x));
		if ((object)leftScrollSupport == null)
		{
			leftScrollSupport = componentsInChildren[0];
		}
		if ((object)rightScrollSupport == null)
		{
			rightScrollSupport = componentsInChildren[componentsInChildren.Length - 1];
		}
	}

	private static void RefreshLevelUpNewPromptIfNeeded()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW) == UIState.Opened && Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_POPUPELITELEVELUPNEW, out var ui) && ui.GetUIView() is PopupEliteLevelUpNewView popupEliteLevelUpNewView)
		{
			popupEliteLevelUpNewView.ForceRefreshGamepadPromptsAfterChildPopupClose();
		}
	}
}
