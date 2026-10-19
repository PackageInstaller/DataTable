using System;
using ACT.Core;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class LotusTouchUIMaskEnergy : TouchUIMaskBase
{
	public TouchUIMaskEnergyComponent item;

	public float reduceDamp;

	private static readonly int IsZero = Animator.StringToHash("isZero");

	private static readonly int Filled = Animator.StringToHash("filled");

	private static readonly int Consume = Animator.StringToHash("consume");

	private bool m_Consume;

	public void Init(DynamicValue dynamic)
	{
		value = dynamic.value / dynamic.max;
		dynamic.onValueChange += new Action<float, DynamicValue>(RefreshBattleCharge);
	}

	public override void SetValue()
	{
		if (!item.root.gameObject.activeSelf)
		{
			item.root.gameObject.SetActive(value: true);
		}
		bool flag = Mathf.Approximately(value, 0f);
		bool flag2 = Mathf.Approximately(value, 1f);
		if (item.animator != null && item.animator.gameObject.activeInHierarchy)
		{
			item.animator.SetBool(IsZero, flag);
			item.animator.SetBool(Filled, flag2);
			item.animator.SetBool(Consume, m_Consume);
		}
		if (item.sliderUI != null)
		{
			item.sliderUI.value = value;
		}
		if (item.imageUI != null)
		{
			item.imageUI.fillAmount = value;
		}
	}

	private void RefreshBattleCharge(float last, DynamicValue dynamic)
	{
		targetValue = dynamic.value / dynamic.max;
		m_Consume = targetValue <= value;
	}

	protected override float CalValue(float interpolationTime)
	{
		return InterpolationUtility.ExponentialInterpolation(value, targetValue, (targetValue < value) ? reduceDamp : damp, interpolationTime);
	}
}
