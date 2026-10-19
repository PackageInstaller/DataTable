using System;
using System.Collections.Generic;
using UnityEngine.UI;

namespace ACT.UI;

public class TouchUIMask : TouchUIMaskBase
{
	[Serializable]
	public struct TouchUIMaskSetting<T>
	{
		public bool oneMinus;

		public T ui;
	}

	public List<TouchUIMaskSetting<Slider>> sliderList = new List<TouchUIMaskSetting<Slider>>();

	public List<TouchUIMaskSetting<Image>> imageList = new List<TouchUIMaskSetting<Image>>();

	public override void SetValue()
	{
		foreach (TouchUIMaskSetting<Slider> slider in sliderList)
		{
			slider.ui.value = (slider.oneMinus ? (1f - value) : value);
		}
		foreach (TouchUIMaskSetting<Image> image in imageList)
		{
			image.ui.fillAmount = (image.oneMinus ? (1f - value) : value);
		}
	}
}
