using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupEliteBreakView : BaseUIView<PopupEliteBreakViewInputController>
{
	private const float LeftStickDeadZone = 0.2f;

	private PopupEliteBreakViewData m_data;

	public TextMeshProUGUI stageName;

	public BImage stageIcon;

	public TextMeshProUGUI stageName2;

	public BImage stageIcon2;

	public LocalizeStringEvent skillIdName;

	public GameObject newPointRoot;

	public GameObject emptyRoot;

	[Header("手柄提示(分散显示)")]
	[SerializeField]
	private OperateBtnPrompt promptA_Select;

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
		m_data = uiViewData as PopupEliteBreakViewData;
	}

	protected override void Init()
	{
		base.Init();
		Refresh();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		OnInputModeChanged(MonoECS.instance.InputMode);
	}

	private void Refresh()
	{
		if (RuntimeConfigs.data.eliteTrainingStages.TryGetValue(m_data.stageId - 1, out var value))
		{
			stageName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.name);
			Station.LoadImage(151, value.icon, stageIcon);
		}
		if (RuntimeConfigs.data.eliteTrainingStages.TryGetValue(m_data.stageId, out var value2))
		{
			stageName2.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value2.name);
			Station.LoadImage(151, value2.icon, stageIcon2);
		}
		int[] skillMessageId = CoreUtils.GetSkillMessageId(Model<EliteModel>.Interface.GetCharacterSkillId(m_data.character.Id, m_data.stageId - 1));
		if (skillMessageId != null && skillMessageId.Length != 0)
		{
			SkillDetailMessageData data = CoreUtils.GetData(skillMessageId[0], RuntimeConfigs.data.skillDetailMessageDatas);
			skillIdName.SetReference(LocalizeTable.ShortCommon, data.nameLocal);
		}
		newPointRoot.SetActive(m_data.stageId < 4);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		RefreshOperatePrompts(gamepadActive: false);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.Play();
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
		emptyRoot.SetActive(mode != DeviceInputMode.Gamepad);
		if (mode != DeviceInputMode.Gamepad)
		{
			RefreshOperatePrompts(gamepadActive: false);
			return;
		}
		SetupOperatePromptContent();
		RefreshOperatePrompts(gamepadActive: true);
	}

	public void HandleGamepadLeftStickHorizontal(float value)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			Mathf.Abs(value);
			_ = 0.2f;
		}
	}

	public void HandleGamepadSubmit()
	{
		Close();
	}

	public void HandleGamepadCancel()
	{
		Close();
	}

	private void RefreshOperatePrompts(bool gamepadActive)
	{
		promptA_Select?.SetVisible(gamepadActive);
	}

	private void SetupOperatePromptContent()
	{
		ConfigurePrompt(promptA_Select, "LargeMapView/Select", 774);
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetLocalizeString(localizeKey);
			prompt.RefreshIcon();
		}
	}
}
