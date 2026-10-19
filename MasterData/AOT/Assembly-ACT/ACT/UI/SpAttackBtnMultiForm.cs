using ACT.Event;
using Bamboo.ECS;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class SpAttackBtnMultiForm : SpAttackBtn
{
	private OperateBtnFormDataManager _formDataManager;

	private bool incd;

	public override void Init(OperateBtnData operateBtnData, CustomUITransform transform, ImageAssetStation imageStation)
	{
		base.Init(operateBtnData, transform, imageStation);
		SpAttackBtnMultiFormData spAttackBtnMultiFormData = operateBtnData as SpAttackBtnMultiFormData;
		_formDataManager = spAttackBtnMultiFormData.formDataManager;
		SubscribeManagerEvents();
		Refresh(_formDataManager.CurDisplayData);
	}

	public override void UnInit()
	{
		UnsubscribeManagerEvents();
	}

	protected override void SubscribeManagerEvents()
	{
		_formDataManager.OnCdDataChanged += UpdateCd;
		_formDataManager.OnCountDataChanged += UpdateSkillUseCountDisplay;
		_formDataManager.OnDurationDataChanged += OnAbilityDurationChange;
		_formDataManager.OnDurationAdd += OnAbilityAdd;
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
			_formDataManager.OnDurationDataChanged -= OnAbilityDurationChange;
			_formDataManager.OnDurationAdd -= OnAbilityAdd;
			_formDataManager.OnDurationRemoved -= OnAbilityRemove;
			_formDataManager.OnEnergyChanged -= OnEnergyValChange;
			_formDataManager.OnUltraEnergyChanged -= OnUltraEnergyChange;
			_formDataManager.OnBtnRebindSkill -= OnRebindSkill;
		}
	}

	protected override void Refresh(OperateBtnDisplayData displayData)
	{
		OperateBtnBindSkillInfo bindSkillInfo = displayData.BindSkillInfo;
		UpdateCd(displayData);
		InitSkillUseCount(displayData.ShowCount, bindSkillInfo);
		if (!displayData.ShowDuration)
		{
			progressRoot.gameObject.SetActive(value: false);
		}
	}

	protected override void UpdateCd(OperateBtnDisplayData displayData)
	{
		base.UpdateCd(displayData);
		if (!isInCD)
		{
			SetInteractive(displayData);
		}
	}

	public override void OnEnergyValChange(OperateBtnDisplayData displayData)
	{
		SetInteractive(displayData);
	}

	protected override void SetInteractive(OperateBtnDisplayData displayData)
	{
		if (displayData.ShowCd)
		{
			bool flag = displayData.ShowCount && displayData.BindSkillInfo.CurSkillCount != displayData.BindSkillInfo.MaxCount && displayData.BindSkillInfo.CurSkillCount != 0;
			if (isInCD && !flag)
			{
				return;
			}
		}
		if (displayData.CurNormalEnergy < displayData.InteractiveEnergyThreshold)
		{
			SetDisableState(isDisable: true);
			SetInteractable(interactableState: false);
		}
		else
		{
			SetDisableState(isDisable: false);
			SetInteractable(interactableState: true);
		}
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

	public override void RefreshDisplay(Entity eb)
	{
		OnRebindSkill(_formDataManager.CurDisplayData);
	}
}
