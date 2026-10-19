using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TargetValueMaskBar : TargetValueMaskedBarBase
{
	public TouchUIMask.TouchUIMaskSetting<Image>[] images;

	public TouchUIMask.TouchUIMaskSetting<Image>[] imagesBacks;

	public TouchUIMask.TouchUIMaskSetting<Slider>[] sliders;

	public TouchUIMask.TouchUIMaskSetting<Slider>[] sliderBacks;

	[SerializeField]
	private RectTransform minus;

	protected override void SetValue()
	{
		TouchUIMask.TouchUIMaskSetting<Image>[] array = imagesBacks;
		for (int i = 0; i < array.Length; i++)
		{
			TouchUIMask.TouchUIMaskSetting<Image> touchUIMaskSetting = array[i];
			touchUIMaskSetting.ui.fillAmount = (touchUIMaskSetting.oneMinus ? (1f - Value) : Value);
		}
		TouchUIMask.TouchUIMaskSetting<Slider>[] array2 = sliderBacks;
		for (int i = 0; i < array2.Length; i++)
		{
			TouchUIMask.TouchUIMaskSetting<Slider> touchUIMaskSetting2 = array2[i];
			touchUIMaskSetting2.ui.value = (touchUIMaskSetting2.oneMinus ? (1f - Value) : Value);
		}
		if (minus != null)
		{
			minus.anchorMax = new Vector2(Value, minus.anchorMax.y);
			if (Value == TargetValue)
			{
				minus.gameObject.SetActive(value: false);
			}
		}
	}

	protected override void SetTargetValue()
	{
		TouchUIMask.TouchUIMaskSetting<Image>[] array = images;
		for (int i = 0; i < array.Length; i++)
		{
			TouchUIMask.TouchUIMaskSetting<Image> touchUIMaskSetting = array[i];
			touchUIMaskSetting.ui.fillAmount = (touchUIMaskSetting.oneMinus ? (1f - TargetValue) : TargetValue);
		}
		TouchUIMask.TouchUIMaskSetting<Slider>[] array2 = sliders;
		for (int i = 0; i < array2.Length; i++)
		{
			TouchUIMask.TouchUIMaskSetting<Slider> touchUIMaskSetting2 = array2[i];
			touchUIMaskSetting2.ui.value = (touchUIMaskSetting2.oneMinus ? (1f - TargetValue) : TargetValue);
		}
		if (minus != null)
		{
			minus.anchorMin = new Vector2(TargetValue, minus.anchorMin.y);
			if (Value != TargetValue)
			{
				minus.gameObject.SetActive(value: true);
			}
		}
	}
}
