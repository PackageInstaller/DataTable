using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class WorldMapScaleSlider : Slider, IBeginDragHandler, IEventSystemHandler, IEndDragHandler
{
	[Header("关联组件")]
	public WorldMapScrollRect worldMapScrollRect;

	[Header("配置")]
	[Tooltip("点击按钮时的缩放增量")]
	private float _sliderBtnScaleDelta;

	private bool _isInitialized;

	public void Init(float minValue, float maxValue, float curValue, float sliderBtnScaleDelta)
	{
		base.minValue = minValue;
		base.maxValue = maxValue;
		value = curValue;
		_sliderBtnScaleDelta = sliderBtnScaleDelta;
		if (worldMapScrollRect != null)
		{
			worldMapScrollRect.OnScaleChanged += OnScrollRectScaleChanged;
			onValueChanged.AddListener((float value) =>
			{
				if (worldMapScrollRect != null)
				{
					worldMapScrollRect.OnSlide(value);
				}
			});
		}
		_isInitialized = true;
		gameObject.SetActive(value: true);
	}

	public void UnInit()
	{
		if (worldMapScrollRect != null)
		{
			worldMapScrollRect.OnScaleChanged -= OnScrollRectScaleChanged;
			onValueChanged.RemoveAllListeners();
		}
		_isInitialized = false;
		gameObject.SetActive(value: false);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (worldMapScrollRect != null)
		{
			worldMapScrollRect.SetIsSliding(val: true);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (worldMapScrollRect != null)
		{
			worldMapScrollRect.SetIsSliding(val: false);
		}
	}

	public void DoScaleDelta(bool isAdd)
	{
		if ((!isAdd || !(value >= maxValue)) && (isAdd || !(value <= minValue)))
		{
			if (worldMapScrollRect != null)
			{
				worldMapScrollRect.UpdatePreSlideScale(value);
			}
			value = Mathf.Clamp(value + (float)(isAdd ? 1 : (-1)) * _sliderBtnScaleDelta, minValue, maxValue);
			if (worldMapScrollRect != null)
			{
				worldMapScrollRect.OnSlideBtn(value);
			}
		}
	}

	public void OnAddScale()
	{
		DoScaleDelta(isAdd: true);
	}

	public void OnReduceScale()
	{
		DoScaleDelta(isAdd: false);
	}

	private void OnScrollRectScaleChanged(float afterVal)
	{
		if (_isInitialized)
		{
			SetValueWithoutNotify(afterVal);
		}
	}

	public void SetScaleValue(float scale)
	{
		SetValueWithoutNotify(Mathf.Clamp(scale, minValue, maxValue));
	}

	public float GetScaleValue()
	{
		return value;
	}
}
