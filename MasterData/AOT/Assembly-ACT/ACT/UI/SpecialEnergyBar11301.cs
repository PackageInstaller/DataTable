using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SpecialEnergyBar11301 : SpecialEnergyBar
{
	private const string AbilityOverHeatName = "Role_13_01_Overheat";

	private const string HeatI = "HeatI";

	private const string HeatII = "HeatII";

	[SerializeField]
	private Image _stage1FillLeft;

	[SerializeField]
	private Image _stage1FillRight;

	[SerializeField]
	private Image _stage2FillLeft;

	[SerializeField]
	private Image _stage2FillRight;

	[SerializeField]
	private Image _stage3Left;

	[SerializeField]
	private Image _stage3Right;

	[SerializeField]
	private TextMeshProUGUI _specialEnergyText;

	[SerializeField]
	private Image _buffFillAmount;

	[SerializeField]
	private Image _buffBG;

	[SerializeField]
	private TextMeshProUGUI _buffText;

	[SerializeField]
	private GameObject _timeOutEffect;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string Stage_1 = "Stage_1";

	private const string Stage_2 = "Stage_2";

	private const string Stage_3 = "Stage_3";

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		CompMotion? compMotion = entity.GetCompMotion();
		if (compMotion.parameters.TryGetValue("HeatI", out var value))
		{
			UpdateHeatI(value.defaultInt);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
		if (compMotion.parameters.TryGetValue("HeatII", out var value2))
		{
			UpdateHeatII(value2.defaultInt);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
		CompAbility compAbility = entity.GetCompAbility();
		UpdateSpecialEnergy(compAbility.SpecialEnergyValue, compAbility.CurSpecialEnergyPercent);
		UpdateAbilityDuration(entity);
		_betterAnimation.GetSequence("Stage_1").Play();
		if (compAbility.GetAbilityByName("Role_13_01_Overheat") != null)
		{
			_betterAnimation.GetSequence("Stage_2").Play();
		}
	}

	private void UpdateSpecialEnergy(float value, float percent)
	{
		_specialEnergyText.SetText("{0:0}", (int)value);
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		_specialEnergyText.SetText("{0:0}", (int)evt.value);
	}

	public override void OnIntParamChange(MotionIntParamChangeEvt evt)
	{
		string text = evt.name;
		if (!(text == "HeatI"))
		{
			if (text == "HeatII")
			{
				UpdateHeatII(evt.value);
			}
		}
		else
		{
			UpdateHeatI(evt.value);
		}
	}

	private void UpdateHeatI(int value)
	{
		Image stage1FillLeft = _stage1FillLeft;
		float fillAmount = (_stage1FillRight.fillAmount = (float)value / 100f);
		stage1FillLeft.fillAmount = fillAmount;
		if (value <= 0)
		{
			_betterAnimation.GetSequence("Stage_1").Play();
		}
	}

	private void UpdateHeatII(int value)
	{
		Image stage2FillLeft = _stage2FillLeft;
		float fillAmount = (_stage2FillRight.fillAmount = (float)value / 100f);
		stage2FillLeft.fillAmount = fillAmount;
		_stage3Left.gameObject.SafeSetActive(value >= 100);
		_stage3Right.gameObject.SafeSetActive(value >= 100);
		if (value >= 100)
		{
			_betterAnimation.GetSequence("Stage_3").Play();
			Color color = _buffText.color;
			_buffText.color = new Color(color.r, color.g, color.b, 1f);
		}
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_13_01_Overheat")
		{
			_buffFillAmount.fillAmount = 0f;
			_buffText.gameObject.SafeSetActive(active: true);
			_buffBG.gameObject.SafeSetActive(active: false);
			_betterAnimation.GetSequence("Stage_2").Play();
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_13_01_Overheat")
		{
			_buffFillAmount.fillAmount = 0f;
			_buffText.gameObject.SafeSetActive(active: false);
			_buffBG.gameObject.SafeSetActive(active: true);
			_betterAnimation.GetSequence("Stage_1").Play();
			_timeOutEffect.SafeSetActive(active: false);
		}
	}

	public override void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (abilityDurationChangeEvt.abilityName == "Role_13_01_Overheat")
		{
			_buffFillAmount.fillAmount = CalBuffFillAmount(abilityDurationChangeEvt.DurationPercent);
			_buffText.SetText("{0:0}", Mathf.CeilToInt(abilityDurationChangeEvt.curDuration));
			_buffText.gameObject.SafeSetActive(abilityDurationChangeEvt.DurationPercent > 0f);
			_buffBG.gameObject.SafeSetActive(abilityDurationChangeEvt.DurationPercent <= 0f);
			_timeOutEffect.SafeSetActive(abilityDurationChangeEvt.curDuration <= 3f);
		}
	}

	private void UpdateAbilityDuration(Entity entity)
	{
		Ability abilityByName = entity.GetCompAbility().GetAbilityByName("Role_13_01_Overheat");
		if (abilityByName != null)
		{
			float val = abilityByName.Duration.GetVal(0);
			float maxVal = abilityByName.Duration.GetMaxVal(0);
			float num = val / maxVal;
			_buffFillAmount.fillAmount = CalBuffFillAmount(num);
			_buffText.SetText("{0:0}", Mathf.CeilToInt(val));
			_buffText.gameObject.SafeSetActive(num > 0f);
			_buffBG.gameObject.SafeSetActive(num <= 0f);
			_timeOutEffect.SafeSetActive(val <= 3f);
		}
		else
		{
			_buffFillAmount.fillAmount = 0f;
			_buffText.gameObject.SafeSetActive(active: false);
			_buffBG.gameObject.SafeSetActive(active: true);
			_timeOutEffect.SafeSetActive(active: false);
		}
	}

	private float CalBuffFillAmount(float percent)
	{
		float num = 0.153f;
		float num2 = 1f - num * 2f;
		return num + num2 * percent;
	}

	public override void OnAbilityStackChange(AbilityStackChangeEvt abilityStackChangeEvt)
	{
	}
}
