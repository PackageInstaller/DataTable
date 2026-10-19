using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopUpWorldLevelUpgradeView : BaseUIView<PopUpWorldLevelUpgradeViewInputController>
{
	private const int ConfirmLocalizeId = 774;

	private PopUpWorldLevelUpgradeViewData m_data;

	[SerializeField]
	private TextMeshProUGUI currWorldLevel01;

	[SerializeField]
	private TextMeshProUGUI currWorldLevel02;

	[SerializeField]
	private TextMeshProUGUI nextWorldLevel01;

	[SerializeField]
	private TextMeshProUGUI nextWorldLevel02;

	[SerializeField]
	private TextMeshProUGUI _title;

	[SerializeField]
	private TextMeshProUGUI _breakthroughDesc;

	[SerializeField]
	private TextMeshProUGUI _currMaxLevel;

	[SerializeField]
	private TextMeshProUGUI _nextMaxLevel;

	[SerializeField]
	private LocalizeStringEvent breakthroughEffectDesc;

	[SerializeField]
	private RectTransform emptyTipsRoot;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptA;

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
		Refresh();
		RefreshMiddleLevelGroup();
		SetupOperatePrompt();
		DeviceInputMode currentInputMode = GetCurrentInputMode();
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		}
		RefreshBottomTips(currentInputMode);
	}

	private void Refresh()
	{
		_title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2190);
		_breakthroughDesc.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 346);
		int curWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
		_currMaxLevel.SetText("{0:0}", Model<WorldLevelModel>.Interface.GetMaximumPlayerLevel(curWorldLevel - 1));
		_nextMaxLevel.SetText("{0:0}", Model<WorldLevelModel>.Interface.GetMaximumPlayerLevel(curWorldLevel));
		int description = RuntimeConfigs.data.playerWorldLevelDataNews[curWorldLevel].description;
		breakthroughEffectDesc.StringReference.TableEntryReference = description;
	}

	private void RefreshMiddleLevelGroup()
	{
		int num = Model<WorldLevelModel>.Interface.GetCurWorldLevel() - 1;
		int value = num / 10;
		int value2 = num % 10;
		SetTextIfPresent(currWorldLevel01, value);
		SetTextIfPresent(currWorldLevel02, value2);
		int curWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
		int value3 = curWorldLevel / 10;
		int value4 = curWorldLevel % 10;
		SetTextIfPresent(nextWorldLevel01, value3);
		SetTextIfPresent(nextWorldLevel02, value4);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("LevelUp").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		RefreshBottomTips(GetCurrentInputMode());
	}

	protected override void UnInit()
	{
		if (MonoECS.instance != null)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		}
		RefreshOperatePrompt(visible: false);
		base.UnInit();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshBottomTips(type);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").Play().OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		});
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_WorldLevelUpGradeClose, null);
	}

	public void ConfirmByGamePad()
	{
		Close();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		RefreshBottomTips(mode);
	}

	private void RefreshBottomTips(DeviceInputMode mode)
	{
		ApplyBottomTipsVisibility(mode == DeviceInputMode.Gamepad);
	}

	private DeviceInputMode GetCurrentInputMode()
	{
		if (!(MonoECS.instance != null))
		{
			return DeviceInputMode.KeyboardAndMouse;
		}
		return MonoECS.instance.InputMode;
	}

	private static void SetTextIfPresent(TextMeshProUGUI target, int value)
	{
		if (!(target == null))
		{
			target.SetText("{0:0}", value);
		}
	}

	private void SetupOperatePrompt()
	{
		if (!(operateBtnPromptA == null))
		{
			operateBtnPromptA.SetBindingAction("UI/Confirm");
			operateBtnPromptA.SetLocalizeString(774);
			operateBtnPromptA.SetVisible(vis: false);
			operateBtnPromptA.RefreshIcon();
			operateBtnPromptA.gameObject.SetActive(value: false);
		}
	}

	private void ApplyBottomTipsVisibility(bool isGamepad)
	{
		if (emptyTipsRoot != null)
		{
			emptyTipsRoot.gameObject.SetActive(!isGamepad);
		}
		RefreshOperatePrompt(isGamepad);
	}

	private void RefreshOperatePrompt(bool visible)
	{
		if (operateBtnPromptA == null)
		{
			return;
		}
		if (visible)
		{
			if (!operateBtnPromptA.gameObject.activeSelf)
			{
				operateBtnPromptA.gameObject.SetActive(value: true);
			}
			operateBtnPromptA.SetVisible(vis: true);
			operateBtnPromptA.RefreshIcon();
		}
		else
		{
			operateBtnPromptA.SetVisible(visible);
			if (operateBtnPromptA.gameObject.activeSelf)
			{
				operateBtnPromptA.gameObject.SetActive(value: false);
			}
		}
	}
}
