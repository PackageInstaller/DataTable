using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchUIMaskWithOne : TouchUIMaskBase
{
	[Serializable]
	public struct TouchUIMaskSetting<T>
	{
		public bool oneMinus;

		public T ui;

		public float value;

		public GameObject imageFill;

		public GameObject imageNoFill;
	}

	public GameObject cdComplete;

	public List<TouchUIMaskSetting<Slider>> sliderList = new List<TouchUIMaskSetting<Slider>>();

	public List<TouchUIMaskSetting<Image>> imageList = new List<TouchUIMaskSetting<Image>>();

	public override void SetValue()
	{
		int count = sliderList.Count;
		for (int i = 0; i < sliderList.Count; i++)
		{
			TouchUIMaskSetting<Slider> touchUIMaskSetting = sliderList[i];
			touchUIMaskSetting.value = 1f / (float)count * (float)(i + 1);
			sliderList[i] = touchUIMaskSetting;
			float num = ((i - 1 >= 0) ? sliderList[i - 1].value : 0f);
			if (!sliderList[i].oneMinus)
			{
				if (value > num)
				{
					bool flag = sliderList[i].value - value > 0.01f;
					sliderList[i].ui.value = (flag ? ((value - num) / (sliderList[i].value - num)) : 1f);
					sliderList[i].imageFill.SetActive(!flag);
				}
				else
				{
					sliderList[i].ui.value = 0f;
					sliderList[i].imageNoFill.SetActive(value: true);
					sliderList[i].imageFill.SetActive(value: false);
				}
			}
		}
		int count2 = imageList.Count;
		for (int j = 0; j < imageList.Count; j++)
		{
			TouchUIMaskSetting<Image> touchUIMaskSetting2 = imageList[j];
			touchUIMaskSetting2.value = 1f / (float)count2 * (float)(j + 1);
			imageList[j] = touchUIMaskSetting2;
			float num2 = ((j - 1 >= 0) ? imageList[j - 1].value : 0f);
			if (!imageList[j].oneMinus)
			{
				if (value > num2)
				{
					bool flag2 = sliderList[j].value > value;
					imageList[j].ui.fillAmount = ((imageList[j].value > value) ? ((value - num2) / (imageList[j].value - num2)) : 1f);
					sliderList[j].imageNoFill.SetActive(flag2);
					sliderList[j].imageFill.SetActive(!flag2);
				}
				else
				{
					imageList[j].ui.fillAmount = 0f;
					sliderList[j].imageNoFill.SetActive(value: true);
					sliderList[j].imageFill.SetActive(value: false);
				}
				cdComplete.SetActive(value == 0f);
			}
		}
	}
}
