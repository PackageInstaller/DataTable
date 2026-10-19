using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SpecialEnergyBar10501 : SpecialEnergyBar
{
	private const string AbilityChargeName = "Role_05_01_ChargeBuff";

	private const string AbilityExBuffName = "Role_05_01_EXBuff";

	[SerializeField]
	private TextMeshProUGUI _resonanceEnergyText;

	[SerializeField]
	private GameObject _resonanceEnergyBg;

	[SerializeField]
	private GameObject[] _rightChargeIcons;

	[SerializeField]
	private Image[] _rightReduceFillAmounts;

	[SerializeField]
	private Image[] _ReduceFillBgs;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string ResonanceNormal = "ResonanceNormal";

	private const string ResonanceMax = "ResonanceMax";

	private const string FillNormal = "FillNormal";

	private const string FillMax = "FillMax";

	private const int ResonanceMaxValue = 60;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_resonanceEnergyText.SetText("{0:0}", 0f);
		Image[] rightReduceFillAmounts = _rightReduceFillAmounts;
		for (int i = 0; i < rightReduceFillAmounts.Length; i++)
		{
			rightReduceFillAmounts[i].fillAmount = 0f;
		}
		GameObject[] rightChargeIcons = _rightChargeIcons;
		for (int i = 0; i < rightChargeIcons.Length; i++)
		{
			rightChargeIcons[i].SetActive(value: false);
		}
		_resonanceEnergyBg.SafeSetActive(active: false);
		_betterAnimation.GetSequence("FillNormal").Play();
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		_resonanceEnergyText.SetText("{0:0}", evt.value);
		if (evt.value >= 60f)
		{
			_betterAnimation.GetSequence("ResonanceMax").Play();
		}
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_05_01_ChargeBuff")
		{
			_rightChargeIcons[0].SetActive(value: true);
		}
		if (abilityAddEvt.abilityName == "Role_05_01_EXBuff")
		{
			Image[] rightReduceFillAmounts = _rightReduceFillAmounts;
			foreach (Image obj in rightReduceFillAmounts)
			{
				obj.gameObject.SafeSetActive(active: true);
				obj.fillAmount = 1f;
			}
			rightReduceFillAmounts = _ReduceFillBgs;
			for (int i = 0; i < rightReduceFillAmounts.Length; i++)
			{
				rightReduceFillAmounts[i].gameObject.SafeSetActive(active: true);
			}
			_betterAnimation.GetSequence("FillMax").Play();
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_05_01_ChargeBuff")
		{
			GameObject[] rightChargeIcons = _rightChargeIcons;
			for (int i = 0; i < rightChargeIcons.Length; i++)
			{
				rightChargeIcons[i].SetActive(value: false);
			}
		}
		if (abilityRemoveEvt.abilityName == "Role_05_01_EXBuff")
		{
			Image[] reduceFillBgs = _ReduceFillBgs;
			for (int i = 0; i < reduceFillBgs.Length; i++)
			{
				reduceFillBgs[i].gameObject.SafeSetActive(active: false);
			}
			_betterAnimation.GetSequence("FillNormal").Play();
		}
	}

	public override void OnAbilityStackChange(AbilityStackChangeEvt abilityStackChangeEvt)
	{
		if (abilityStackChangeEvt.abilityName == "Role_05_01_ChargeBuff")
		{
			for (int i = 0; i < abilityStackChangeEvt.curStack; i++)
			{
				_rightChargeIcons[i].SetActive(i < abilityStackChangeEvt.curStack);
			}
		}
	}

	public override void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (!(abilityDurationChangeEvt.abilityName == "Role_05_01_EXBuff"))
		{
			return;
		}
		float num = abilityDurationChangeEvt.maxDuration / (float)_rightReduceFillAmounts.Length;
		float num2 = abilityDurationChangeEvt.curDuration / num;
		int num3 = Mathf.FloorToInt(num2);
		for (int i = 0; i < _rightReduceFillAmounts.Length; i++)
		{
			if (i < num3)
			{
				_rightReduceFillAmounts[i].fillAmount = 1f;
			}
			else if (i == num3)
			{
				_rightReduceFillAmounts[i].fillAmount = num2 % 1f;
			}
			else if (i > num3)
			{
				_rightReduceFillAmounts[i].fillAmount = 0f;
			}
		}
	}

	private bool TryPlayAnimation(string animationName)
	{
		_betterAnimation.GetSequence(animationName)?.Play();
		return true;
	}
}
