using ACT.Event;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class UltraBtnMultiForm : UltraBtn
{
	private OperateBtnFormDataManager _formDataManager;

	public override void Init(OperateBtnData operateBtnData, CustomUITransform transform, ImageAssetStation imageStation)
	{
		base.Init(operateBtnData, transform, imageStation);
		UltraBtnMultiFormData ultraBtnMultiFormData = operateBtnData as UltraBtnMultiFormData;
		_formDataManager = ultraBtnMultiFormData.formDataManager;
		SubscribeManagerEvents();
		Refresh(_formDataManager.CurDisplayData);
	}

	public override void UnInit()
	{
		base.UnInit();
		UnsubscribeManagerEvents();
	}

	protected override void SubscribeManagerEvents()
	{
		_formDataManager.OnCdDataChanged += UpdateCd;
		_formDataManager.OnCountDataChanged += UpdateSkillUseCountDisplay;
		_formDataManager.OnDurationAdd += OnAbilityAdd;
		_formDataManager.OnDurationDataChanged += OnAbilityDurationChange;
		_formDataManager.OnDurationRemoved += OnAbilityRemove;
		_formDataManager.OnEnergyChanged += OnEnergyValChange;
		_formDataManager.OnUltraEnergyChanged += OnUltraEnergyChange;
		_formDataManager.OnBtnRebindSkill += OnRebindSkill;
	}

	protected override void UnsubscribeManagerEvents()
	{
		if (_formDataManager != null)
		{
			_formDataManager.OnCdDataChanged -= UpdateCd;
			_formDataManager.OnCountDataChanged -= UpdateSkillUseCountDisplay;
			_formDataManager.OnDurationAdd -= OnAbilityAdd;
			_formDataManager.OnDurationDataChanged -= OnAbilityDurationChange;
			_formDataManager.OnDurationRemoved -= OnAbilityRemove;
			_formDataManager.OnEnergyChanged -= OnEnergyValChange;
			_formDataManager.OnUltraEnergyChanged -= OnUltraEnergyChange;
			_formDataManager.OnBtnRebindSkill -= OnRebindSkill;
		}
	}

	protected override void Refresh(OperateBtnDisplayData displayData)
	{
		OperateBtnBindSkillInfo bindSkillInfo = displayData.BindSkillInfo;
		if (!displayData.ShowCd)
		{
			SetInteractable(interactableState: true);
			SetDisableState(isDisable: false);
		}
		UpdateCd(displayData);
		InitSkillUseCount(displayData.ShowCount, bindSkillInfo);
		if (!displayData.ShowDuration)
		{
			progressRoot.gameObject.SetActive(value: false);
		}
		SetInteractive(displayData);
	}

	protected override void UpdateCd(OperateBtnDisplayData displayData)
	{
		base.UpdateCd(displayData);
		if (!isInCD)
		{
			SetInteractive(displayData);
		}
	}

	protected override void SetInteractive(OperateBtnDisplayData displayData)
	{
		if (displayData.skillCurType == SpskillType.normal)
		{
			if (!isInCD)
			{
				OnUltraEnergyChange(displayData);
			}
		}
		else
		{
			SetInteractable(interactableState: true);
			SetDisableState(isDisable: false);
		}
	}

	public override void OnUltraEnergyChange(OperateBtnDisplayData displayData)
	{
		if (displayData.skillCurType == SpskillType.normal)
		{
			fillImage.fillAmount = displayData.CurUltraEnergyData.percent;
			if (Mathf.Approximately(displayData.CurUltraEnergyData.percent, 1f))
			{
				PlayMainState("Filled", forceRestart: true);
				SetInteractable(interactableState: true);
				SetDisableState(isDisable: false);
			}
			else
			{
				PlayMainState("Normal", forceRestart: true);
				SetInteractable(interactableState: false);
				SetDisableState(isDisable: true);
			}
		}
	}

	public override void RefreshDisplay(Entity eb)
	{
		Refresh(_formDataManager.CurDisplayData);
	}

	public override void OnAbilityAdd(OperateBtnDisplayData displayData, AbilityAddEvt abilityAddEvt)
	{
	}

	public override void OnAbilityDurationChange(OperateBtnDisplayData displayData, AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (OperateBtnUtility.HasDurationAbility(_formDataManager.allDisplayDatas, abilityDurationChangeEvt.abilityName))
		{
			if (!progressRoot.gameObject.activeInHierarchy)
			{
				progressRoot.gameObject.SetActive(value: true);
			}
			durationImage.fillAmount = abilityDurationChangeEvt.DurationPercent;
		}
	}

	public override void OnAbilityRemove(OperateBtnDisplayData displayData, AbilityRemoveEvt abilityRemoveEvt)
	{
		if (OperateBtnUtility.HasDurationAbility(_formDataManager.allDisplayDatas, abilityRemoveEvt.abilityName))
		{
			progressRoot.gameObject.SetActive(value: false);
		}
	}
}
