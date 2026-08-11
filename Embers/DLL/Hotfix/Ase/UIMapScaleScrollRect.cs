using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class UIMapScaleScrollRect : ScrollRect
{
	[SerializeField]
	private RectTransform scaleRoot;

	[SerializeField]
	private RectTransform mapRoot;

	private float contentZoomRate = 1f;

	[SerializeField]
	private float scaleMin;

	[SerializeField]
	private float scaleMax;

	[SerializeField]
	private float scaleFactor;

	[SerializeField]
	private float sliderValOri;

	[SerializeField]
	private Slider scaleSlider;

	private Action<float> scaleAction;

	private float _curScale = 1f;

	private float lastDis;

	private Action<PointerEventData> onBeginDragAction;

	private Action<PointerEventData> onDragAction;

	private Action<PointerEventData> onEndDragAction;

	public Action<PointerEventData> OnBeginDragAction
	{
		get
		{
			return onBeginDragAction;
		}
		set
		{
			onBeginDragAction = value;
		}
	}

	public Action<PointerEventData> OnDragAction
	{
		get
		{
			return onDragAction;
		}
		set
		{
			onDragAction = value;
		}
	}

	public Action<PointerEventData> OnEndDragAction
	{
		get
		{
			return onEndDragAction;
		}
		set
		{
			onEndDragAction = value;
		}
	}

	public Action<float> ScaleAction
	{
		get
		{
			return scaleAction;
		}
		set
		{
			scaleAction = value;
		}
	}

	public float CurScale => _curScale;

	public Slider ScaleSlider
	{
		get
		{
			return scaleSlider;
		}
		set
		{
			scaleSlider = value;
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		scaleSlider.onValueChanged.AddListener(OnSliderValueChanged);
	}

	protected override void Start()
	{
		scaleSlider.value = 0f;
		scaleSlider.value = sliderValOri;
	}

	private void Update()
	{
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		if (Input.GetKey(KeyCode.LeftArrow) || Input.GetKey(KeyCode.RightArrow))
		{
			float num = 0f;
			if (Input.GetKey(KeyCode.RightArrow))
			{
				num = 1f;
			}
			if (Input.GetKey(KeyCode.LeftArrow))
			{
				num = -1f;
			}
			scaleSlider.value = Mathf.Clamp(scaleSlider.value + 50f * num * scaleFactor, 0f, 1f);
		}
		if (Input.touchCount <= 1)
		{
			EnableDrag();
			return;
		}
		DisableDrag();
		Touch touch = Input.GetTouch(0);
		Vector2 position = ((Touch)(ref touch)).position;
		touch = Input.GetTouch(1);
		Vector2 position2 = ((Touch)(ref touch)).position;
		float num2 = Vector2.Distance(position, position2);
		touch = Input.GetTouch(0);
		if ((int)((Touch)(ref touch)).phase != 0)
		{
			touch = Input.GetTouch(1);
			if ((int)((Touch)(ref touch)).phase != 0)
			{
				float num3 = num2 - lastDis;
				scaleSlider.value = Mathf.Clamp(scaleSlider.value + num3 * scaleFactor, 0f, 1f);
				return;
			}
		}
		lastDis = num2;
	}

	private void OnSliderValueChanged(float value)
	{
		_curScale = Mathf.Clamp(scaleMin + value * (scaleMax - scaleMin), scaleMin, scaleMax);
		scaleRoot.localScale = Vector2.one * _curScale;
		OnMapSizeUpdate();
		scaleAction?.Invoke(_curScale);
	}

	private void OnMapSizeUpdate()
	{
		base.content.sizeDelta = scaleRoot.localScale * mapRoot.sizeDelta * contentZoomRate;
	}

	public void SetMapSize(Vector2 mapSize, float contentScale)
	{
		contentZoomRate = contentScale;
		mapRoot.sizeDelta = mapSize;
		OnMapSizeUpdate();
	}

	public void ResetScaleLimit(float min, float max, float raw, bool reset)
	{
		if (min >= max)
		{
			scaleMin = max;
			scaleMax = max;
			sliderValOri = 1f;
		}
		else
		{
			scaleMin = min;
			scaleMax = max;
			sliderValOri = (raw - min) / (max - min);
		}
		if (reset)
		{
			scaleSlider.value = 0f;
			scaleSlider.value = sliderValOri;
		}
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		base.OnBeginDrag(eventData);
		onBeginDragAction?.Invoke(eventData);
	}

	public override void OnDrag(PointerEventData eventData)
	{
		base.OnDrag(eventData);
		onDragAction?.Invoke(eventData);
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		base.OnEndDrag(eventData);
		onEndDragAction?.Invoke(eventData);
	}

	private void EnableDrag()
	{
		base.horizontal = true;
		base.vertical = true;
	}

	private void DisableDrag()
	{
		base.horizontal = false;
		base.vertical = false;
	}
}
