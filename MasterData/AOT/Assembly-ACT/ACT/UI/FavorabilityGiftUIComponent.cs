using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Lumin.LoungeSystem.UI;
using UnityEngine;

namespace ACT.UI;

public class FavorabilityGiftUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private BImage m_GiftPreferenceDegreeIcon;

	private int favorabilityGiftIndex;

	private int characterId;

	[SerializeField]
	private ActButton m_ReduceBtn;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptRT;

	private bool _gamepadPromptInited;

	protected override void OnGameObjectAwake()
	{
		base.OnGameObjectAwake();
		if ((bool)m_ReduceBtn)
		{
			m_ReduceBtn.OnClick.AddListener(OnInvertClick);
		}
		InitGamePadPromptBindings();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void OnGameObjectDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		base.OnGameObjectDestroy();
		if ((bool)m_ReduceBtn)
		{
			m_ReduceBtn.OnClick.RemoveListener(OnInvertClick);
		}
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		characterId = LoungeUIScene.instance.PendingClickCharacterId;
		favorabilityGiftIndex = (int)Model<FavorabilityModel>.Interface.GetGiftPreference(ItemUnifier.Id, characterId);
		Station.LoadImageAsync(177, favorabilityGiftIndex, m_GiftPreferenceDegreeIcon).Forget();
		if (m_ItemUnifier?.Source == null)
		{
			m_ItemCountRoot.gameObject.SetActive(value: false);
			IsChosen = false;
			SetSelect();
		}
		else
		{
			SetSelect();
			m_ItemCountRoot.gameObject.SetActive(value: true);
		}
	}

	protected override void SetSelect()
	{
		base.SetSelect();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Common_Button_Click");
		RequestGiveGiftViewRefreshRtPrompts();
	}

	protected override void OnHighLight()
	{
		base.OnHighLight();
		RequestGiveGiftViewRefreshRtPrompts();
	}

	protected override void OnNormal()
	{
		base.OnNormal();
		RequestGiveGiftViewRefreshRtPrompts();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		RequestGiveGiftViewRefreshRtPrompts();
	}

	private void RequestGiveGiftViewRefreshRtPrompts()
	{
		if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_GiveGiftView) is UI_GiveGiftView uI_GiveGiftView)
		{
			uI_GiveGiftView.RefreshVisibleGiftGamepadRtPrompts();
		}
		else
		{
			ApplyGamepadReducePrompt(null);
		}
	}

	private void InitGamePadPromptBindings()
	{
		if (!(operateBtnPromptRT == null) && !_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			operateBtnPromptRT.SetBindingAction("UI/RightTrigger");
			operateBtnPromptRT.SetLocalizeString(0);
		}
	}

	public void ApplyGamepadReducePrompt(ItemUIComponentBase focusedGiftCell)
	{
		if (!(operateBtnPromptRT == null))
		{
			InitGamePadPromptBindings();
			bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad && IsChosen && focusedGiftCell == this;
			operateBtnPromptRT.gameObject.SetActive(flag);
			if (!flag)
			{
				operateBtnPromptRT.SetVisible(vis: false);
				return;
			}
			operateBtnPromptRT.SetVisible(vis: true);
			operateBtnPromptRT.RefreshIcon();
			DelayRefreshGamepadReducePrompt(focusedGiftCell).Forget();
		}
	}

	public void RefreshGamepadReducePrompt()
	{
		RequestGiveGiftViewRefreshRtPrompts();
	}

	public bool TrySubmitReduceButton()
	{
		if (m_ReduceBtn == null || !m_ReduceBtn.gameObject.activeInHierarchy || !m_ReduceBtn.IsInteractable())
		{
			return false;
		}
		EventSystemHelper.Click(m_ReduceBtn.gameObject);
		return true;
	}

	private async UniTaskVoid DelayRefreshGamepadReducePrompt(ItemUIComponentBase focusedGiftCell)
	{
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		if (!(this == null))
		{
			if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_GiveGiftView) is UI_GiveGiftView uI_GiveGiftView)
			{
				uI_GiveGiftView.RefreshVisibleGiftGamepadRtPrompts();
			}
			else if (operateBtnPromptRT != null && operateBtnPromptRT.gameObject.activeInHierarchy && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && IsChosen && focusedGiftCell == this)
			{
				operateBtnPromptRT.SetVisible(vis: true);
				operateBtnPromptRT.RefreshIcon();
			}
		}
	}

	public override void PlayCustomAnimation(float delaySecond)
	{
		gameObject.SetActive(value: true);
		base.PlayCustomAnimation(delaySecond);
	}
}
