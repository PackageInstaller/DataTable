using System;
using System.Collections.Generic;
using ACT.Core;
using UnityEngine;

namespace ACT.UI;

public class TouchUIMaskEnergy : TouchUIMaskBase
{
	public List<TouchUIMaskEnergyComponent> itemList = new List<TouchUIMaskEnergyComponent>();

	public GameObject cdComplete;

	public float perValue;

	public int currCount;

	public virtual void Init(DynamicValue dynamic)
	{
		if (perValue < 0f)
		{
			currCount = 1;
		}
		else
		{
			currCount = Mathf.CeilToInt(dynamic.max / perValue);
		}
		value = dynamic.value / dynamic.max;
		dynamic.onValueChange += new Action<float, DynamicValue>(RefreshBattleCharge);
	}

	public override void SetValue()
	{
		for (int i = 0; i < itemList.Count; i++)
		{
			TouchUIMaskEnergyComponent touchUIMaskEnergyComponent = itemList[i];
			if (i > currCount - 1)
			{
				if (touchUIMaskEnergyComponent.root.gameObject.activeSelf)
				{
					touchUIMaskEnergyComponent.root.gameObject.SetActive(value: false);
				}
				continue;
			}
			if (!touchUIMaskEnergyComponent.root.gameObject.activeSelf)
			{
				touchUIMaskEnergyComponent.root.gameObject.SetActive(value: true);
			}
			float num = 1f / (float)currCount * (float)(i + 1);
			float num2 = 1f / (float)currCount * (float)i;
			if (value > num2 || Mathf.Approximately(value, num))
			{
				bool flag = num < value || Mathf.Approximately(value, num);
				float fillAmount = ((num > value) ? ((value - num2) / (num - num2)) : 1f);
				if (touchUIMaskEnergyComponent.sliderUI != null)
				{
					touchUIMaskEnergyComponent.sliderUI.value = fillAmount;
				}
				if (touchUIMaskEnergyComponent.imageUI != null)
				{
					touchUIMaskEnergyComponent.imageUI.fillAmount = fillAmount;
				}
				if (touchUIMaskEnergyComponent.animator == null && touchUIMaskEnergyComponent.imageFill != null && !touchUIMaskEnergyComponent.imageFill.activeSelf)
				{
					touchUIMaskEnergyComponent.imageFill.SetActive(value: true);
				}
				if (touchUIMaskEnergyComponent.animator == null && touchUIMaskEnergyComponent.imageFillComplete != null && touchUIMaskEnergyComponent.imageFillComplete.activeSelf != flag)
				{
					touchUIMaskEnergyComponent.imageFillComplete.SetActive(flag);
				}
				if (touchUIMaskEnergyComponent.animator != null && touchUIMaskEnergyComponent.animator.gameObject.activeInHierarchy)
				{
					touchUIMaskEnergyComponent.animator.SetBool("filled", flag);
				}
				if (!touchUIMaskEnergyComponent.filled & flag)
				{
					touchUIMaskEnergyComponent.SetFill(isFill: true);
				}
			}
			else
			{
				if (touchUIMaskEnergyComponent.sliderUI != null)
				{
					touchUIMaskEnergyComponent.sliderUI.value = 0f;
				}
				if (touchUIMaskEnergyComponent.imageUI != null)
				{
					touchUIMaskEnergyComponent.imageUI.fillAmount = 0f;
				}
				if (touchUIMaskEnergyComponent.animator != null && touchUIMaskEnergyComponent.animator.gameObject.activeInHierarchy)
				{
					touchUIMaskEnergyComponent.animator.SetBool("filled", value: false);
				}
				if (touchUIMaskEnergyComponent.filled)
				{
					touchUIMaskEnergyComponent.SetFill(isFill: false);
				}
				else
				{
					if (touchUIMaskEnergyComponent.animator == null && touchUIMaskEnergyComponent.imageFill != null)
					{
						touchUIMaskEnergyComponent.imageFill.SetActive(value: false);
					}
					if (touchUIMaskEnergyComponent.animator == null && touchUIMaskEnergyComponent.imageFillComplete != null && touchUIMaskEnergyComponent.imageFillComplete.activeSelf)
					{
						touchUIMaskEnergyComponent.imageFillComplete.SetActive(value: false);
					}
				}
			}
			if (cdComplete != null)
			{
				cdComplete.SetActive(value == 0f);
			}
		}
	}

	private void RefreshBattleCharge(float last, DynamicValue dynamic)
	{
		targetValue = dynamic.value / dynamic.max;
	}
}
