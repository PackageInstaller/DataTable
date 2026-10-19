using ACT.Event;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class DodgeBtnMultiForm : DodgeBtn
{
	[SerializeField]
	public GameObject go_WitchNormal;

	[SerializeField]
	public GameObject go_WitchActive;

	[SerializeField]
	public GameObject go_WitchCD;

	public Image img_WitchCdFillAmount;

	private OperateBtnFormDataManager _formDataManager;

	public const string WitchTimeActive = "WitchTimeActive";

	public const string WitchTimeDisable = "WitchTimeDisable";

	public const string WitchTimeNormal = "WitchTimeNormal";

	public const string WITCHEFFECT = "witch_time_cant_be_attacked";

	public const string WITCHCD = "witch_time_cooldown";

	public override void Init(OperateBtnData operateBtnData, CustomUITransform transform, ImageAssetStation imageStation)
	{
		base.Init(operateBtnData, transform, imageStation);
		DodgeBtnMultiFormData dodgeBtnMultiFormData = operateBtnData as DodgeBtnMultiFormData;
		_formDataManager = dodgeBtnMultiFormData.formDataManager;
		SubscribeManagerEvents();
		Refresh(_formDataManager.CurDisplayData);
		animator.Play("WitchTimeNormal", -1, 0f);
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
		if (abilityAddEvt.abilityName == "witch_time_cant_be_attacked")
		{
			animator.Play("WitchTimeActive", -1, 0f);
			GameObject gameObject = go_WitchActive;
			if ((object)gameObject != null)
			{
				gameObject.SafeSetActive(active: true);
			}
		}
		else if (abilityAddEvt.abilityName == "witch_time_cooldown")
		{
			GameObject gameObject2 = go_WitchCD;
			if ((object)gameObject2 != null)
			{
				gameObject2.SafeSetActive(active: true);
			}
			GameObject gameObject3 = go_WitchNormal;
			if ((object)gameObject3 != null)
			{
				gameObject3.SafeSetActive(active: false);
			}
		}
	}

	public override void OnAbilityDurationChange(OperateBtnDisplayData displayData, AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (abilityDurationChangeEvt.abilityName == "witch_time_cooldown")
		{
			if (img_WitchCdFillAmount != null)
			{
				img_WitchCdFillAmount.fillAmount = abilityDurationChangeEvt.DurationPercent;
			}
			if (abilityDurationChangeEvt.DurationPercent > 0.75f && abilityDurationChangeEvt.DurationPercent <= 0.8f)
			{
				animator.Play("WitchTimeDisable", -1, 0f);
			}
		}
	}

	public override void OnAbilityRemove(OperateBtnDisplayData displayData, AbilityRemoveEvt abilityRemoveEvt)
	{
		if (OperateBtnUtility.HasDurationAbility(_formDataManager.allDisplayDatas, abilityRemoveEvt.abilityName))
		{
			progressRoot.gameObject.SetActive(value: false);
		}
		if (abilityRemoveEvt.abilityName == "witch_time_cant_be_attacked")
		{
			GameObject gameObject = go_WitchActive;
			if ((object)gameObject != null)
			{
				gameObject.SafeSetActive(active: false);
			}
		}
		else if (abilityRemoveEvt.abilityName == "witch_time_cooldown")
		{
			if (img_WitchCdFillAmount != null)
			{
				img_WitchCdFillAmount.fillAmount = 0f;
			}
			GameObject gameObject2 = go_WitchCD;
			if ((object)gameObject2 != null)
			{
				gameObject2.SafeSetActive(active: false);
			}
			GameObject gameObject3 = go_WitchNormal;
			if ((object)gameObject3 != null)
			{
				gameObject3.SafeSetActive(active: true);
			}
			animator.Play("WitchTimeNormal", -1, 0f);
		}
	}

	public override void RefreshDisplay(Entity eb)
	{
		Refresh(_formDataManager.CurDisplayData);
	}
}
