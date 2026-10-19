using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SpecialEnergyBar10201 : SpecialEnergyBar
{
	[SerializeField]
	private Image _center;

	[SerializeField]
	private Image _left;

	[SerializeField]
	private Image _right;

	[SerializeField]
	private TextMeshProUGUI _valueText;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string stage1 = "Stage_1";

	private const string stage2 = "Stage_2";

	private const string stage3 = "Stage_3";

	private float _valuePercent;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		Image center = _center;
		Image left = _left;
		float num = (_right.fillAmount = 0f);
		float fillAmount = (left.fillAmount = num);
		center.fillAmount = fillAmount;
		_betterAnimation.GetSequence("Stage_1").Play();
		CompAbility compAbility = entity.GetCompAbility();
		UpdateEnergy(compAbility.CurSpecialEnergyPercent, compAbility.SpecialEnergyValue);
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		UpdateEnergy(evt.percent, evt.value);
	}

	private void UpdateEnergy(float percent, float value)
	{
		float num = Mathf.Clamp01(percent);
		if (!Mathf.Approximately(_valuePercent, num))
		{
			if (_valueText != null)
			{
				_valueText.SetText("{0:0}", value);
			}
			if (_valuePercent >= 0.5f && num < 0.5f)
			{
				_betterAnimation.GetSequence("Stage_1").Play();
			}
			if (Mathf.Approximately(1f, _valuePercent) && num < 1f && num >= 0.5f)
			{
				_betterAnimation.GetSequence("Stage_2").Play();
			}
			if (_valuePercent < 0.5f && num >= 0.5f && num < 1f)
			{
				_betterAnimation.GetSequence("Stage_2").Play();
			}
			if (_valuePercent < 1f && Mathf.Approximately(1f, num))
			{
				_betterAnimation.GetSequence("Stage_3").Play();
			}
			if (percent <= 0.5f)
			{
				_center.fillAmount = percent * 2f;
				_left.fillAmount = 0f;
				_right.fillAmount = 0f;
			}
			else
			{
				_center.fillAmount = 1f;
				float fillAmount = (percent - 0.5f) * 2f;
				_left.fillAmount = fillAmount;
				_right.fillAmount = fillAmount;
			}
			_valuePercent = num;
		}
	}
}
