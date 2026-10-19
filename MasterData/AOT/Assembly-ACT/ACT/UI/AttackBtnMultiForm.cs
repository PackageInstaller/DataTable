using ACT.Event;
using Bamboo.ECS;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class AttackBtnMultiForm : AttackBtn
{
	private OperateBtnFormDataManager _formDataManager;

	public override void Init(OperateBtnData operateBtnData, CustomUITransform transform, ImageAssetStation imageStation)
	{
		base.Init(operateBtnData, transform, imageStation);
		if (operateBtnData is AttackBtnMultiFormData attackBtnMultiFormData)
		{
			_formDataManager = attackBtnMultiFormData.formDataManager;
		}
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
		Refresh(_formDataManager.CurDisplayData);
	}
}
