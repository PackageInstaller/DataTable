using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class LargeMapScaleSlider : Slider, IBeginDragHandler, IEventSystemHandler, IEndDragHandler
{
	[OdinSerialize]
	public LargeMapView view;

	[OdinSerialize]
	public AreaMapScrollRect areaMapScrollRect;

	private float sliderBtnScaleDelta;

	public void Init(float minValue, float maxValue, float curValue, float sliderBtnScaleDelta)
	{
		base.minValue = minValue;
		base.maxValue = maxValue;
		value = curValue;
		this.sliderBtnScaleDelta = sliderBtnScaleDelta;
		gameObject.SetActive(value: true);
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		areaMapScrollRect.SetIsSlide(val: true);
	}

	public override void OnDrag(PointerEventData eventData)
	{
		areaMapScrollRect.UpdatePreSlideScale(value);
		base.OnDrag(eventData);
		areaMapScrollRect.OnSlide(value);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		areaMapScrollRect.SetIsSlide(val: false);
	}

	public void DoScaleDelta(bool isAdd)
	{
		if ((!isAdd || !(value >= maxValue)) && (isAdd || !(value <= minValue)))
		{
			areaMapScrollRect.UpdatePreSlideScale(value);
			value = Mathf.Clamp(value + (float)(isAdd ? 1 : (-1)) * sliderBtnScaleDelta, minValue, maxValue);
			areaMapScrollRect.OnSlideBtn(value);
		}
	}
}
