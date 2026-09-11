using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class P08StoryQTEPress : P08StoryQTEUI, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	private Slider _slider;

	private Slider _slider_right;

	private RectTransform _fillRectTrans;

	private RectTransform _handleRectTrans;

	private RectTransform _glow;

	private RectTransform _glow_kuang;

	private RectTransform _glow_full;

	private GameObject _text_go;

	private GameObject _anxia_go;

	private GameObject _daiji_go;

	private Animation _close_anim;

	private Renderer _guangban_ps;

	private Renderer _lizi1_ps;

	private Renderer _lizi2_ps;

	private Image _slider_fill_img;

	private Image _slider_right_fill_img;

	private float _timeLimit;

	private int _style;

	private Action _successAction;

	private Action _failedAction;

	private Action<float> _onProgressUpdateAction;

	private bool _inited;

	private float _targetWidth;

	private float _pressTime;

	private float _unpressTime;

	private bool _press;

	private bool _finished;

	private AnimationCurve _growCurve;

	private AnimationCurve _falloffCurve;

	public Gradient guangbanGrad;

	public Gradient liziGrad;

	public Gradient sliderGrad;

	public Gradient sliderRightGrad;

	public void Init(float timeLimit, int style, AnimationCurve growCurve, AnimationCurve falloffCurve, Action successAction, Action failedAction)
	{
		_timeLimit = timeLimit;
		_style = style;
		_growCurve = growCurve;
		_falloffCurve = falloffCurve;
		_pressTime = 0f;
		_press = false;
		_finished = false;
		_successAction = successAction;
		_failedAction = failedAction;
		_inited = true;
		_slider = GetGoFromCfg("_slider").GetComponent<Slider>();
		_slider_right = GetGoFromCfg("_slider_2").GetComponent<Slider>();
		_fillRectTrans = GetGoFromCfg("_fill").transform as RectTransform;
		_handleRectTrans = GetGoFromCfg("_handle").transform as RectTransform;
		_glow = GetGoFromCfg("_guangban").transform as RectTransform;
		_glow_kuang = GetGoFromCfg("_qianjin_glow").transform as RectTransform;
		_glow_full = GetGoFromCfg("_full_glow").transform as RectTransform;
		_anxia_go = GetGoFromCfg("_anxia_glow");
		_daiji_go = GetGoFromCfg("_daiji");
		_text_go = GetGoFromCfg("_text");
		_guangban_ps = GetGoFromCfg("_guangban_ps").GetComponent<Renderer>();
		_lizi1_ps = GetGoFromCfg("_lizi1_ps").GetComponent<Renderer>();
		_lizi2_ps = GetGoFromCfg("_lizi2_ps").GetComponent<Renderer>();
		_slider_fill_img = _fillRectTrans.GetComponent<Image>();
		_slider_right_fill_img = GetGoFromCfg("_fill_2").GetComponent<Image>();
		_close_anim = base.gameObject.GetComponent<Animation>();
		if (_style == 1)
		{
			_slider.enabled = true;
			_fillRectTrans.sizeDelta = new Vector2(0f, 32f);
			_fillRectTrans.pivot = new Vector2(0f, 0.5f);
			_fillRectTrans.anchoredPosition = new Vector2(0f, 0f);
			_slider.value = 0f;
			_slider_right.gameObject.SetActive(value: false);
		}
		else if (_style == 2)
		{
			_slider.enabled = false;
			_targetWidth = (_fillRectTrans.parent as RectTransform).rect.width;
			_fillRectTrans.pivot = new Vector2(0.5f, 0.5f);
			_fillRectTrans.anchorMin = new Vector2(0.5f, 0.5f);
			_fillRectTrans.anchorMax = new Vector2(0.5f, 0.5f);
			_fillRectTrans.sizeDelta = new Vector2(0f, 32f);
			_slider_right.gameObject.SetActive(value: false);
		}
		else if (_style == 3)
		{
			_slider.enabled = false;
			_slider_right.gameObject.SetActive(value: true);
		}
	}

	public void RegistProgreeUpdateEvent(Action<float> action)
	{
		_onProgressUpdateAction = action;
	}

	public void SuccessCall()
	{
		_pressTime = 0f;
		_unpressTime = 0f;
		_press = false;
		if (_successAction != null)
		{
			_successAction();
		}
		_successAction = null;
		_failedAction = null;
		_inited = false;
		_finished = true;
		_glow_kuang.gameObject.SetActive(value: true);
		_glow_full.gameObject.SetActive(value: true);
	}

	public void FailedCall()
	{
		_pressTime = 0f;
		_unpressTime = 0f;
		_press = false;
		_finished = true;
		if (_failedAction != null)
		{
			_failedAction();
		}
		if (_slider != null)
		{
			_slider.value = 0f;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (_inited)
		{
			_pressTime = 0f;
			_unpressTime = 0f;
			_press = true;
			_anxia_go.SetActive(value: true);
			_daiji_go.SetActive(value: false);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (_inited)
		{
			_press = false;
			_unpressTime = 0f;
			_anxia_go.SetActive(value: false);
			_daiji_go.SetActive(value: true);
			_text_go.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (_timeLimit == 0f || _slider == null || _finished)
		{
			return;
		}
		float deltaTime = Time.deltaTime;
		_timeLimit -= deltaTime;
		if (_timeLimit <= 0f)
		{
			FailedCall();
			return;
		}
		float num = 0f;
		if (_style == 1)
		{
			num = _slider.value;
		}
		else if (_style == 2)
		{
			num = _fillRectTrans.sizeDelta.x / _targetWidth;
		}
		else if (_style == 3)
		{
			num = _slider.value * 2f;
		}
		_onProgressUpdateAction?.Invoke(num);
		if (!_press)
		{
			_unpressTime += deltaTime;
			float num2 = _falloffCurve.Evaluate(_unpressTime);
			num = Mathf.Max(num - num2 * deltaTime, 0f);
		}
		else
		{
			_pressTime += deltaTime;
			float num3 = _growCurve.Evaluate(_pressTime);
			num = Mathf.Min(num + num3 * deltaTime, 1f);
		}
		_glow.gameObject.SetActive(value: true);
		Color value = guangbanGrad.Evaluate(num);
		Color value2 = liziGrad.Evaluate(num);
		Color color = sliderGrad.Evaluate(num);
		Color color2 = sliderRightGrad.Evaluate(num);
		_guangban_ps.material.SetColor("_Color", value);
		_lizi1_ps.material.SetColor("_Color", value2);
		_lizi2_ps.material.SetColor("_Color", value2);
		_slider_fill_img.color = color;
		_slider_right_fill_img.color = color2;
		if (_style == 1)
		{
			_slider.value = num;
			_glow.position = _handleRectTrans.position;
		}
		else if (_style == 2)
		{
			_fillRectTrans.sizeDelta = new Vector2(num * _targetWidth, _fillRectTrans.sizeDelta.y);
			_glow.position = _fillRectTrans.position;
		}
		else if (_style == 3)
		{
			_slider.value = num * 0.5f;
			_slider_right.value = num * 0.5f;
		}
		if (num >= 1f)
		{
			SuccessCall();
		}
	}

	public override void Dispose(float delay)
	{
		base.Dispose(delay);
		_close_anim?.Play();
		_successAction = null;
		_failedAction = null;
		_onProgressUpdateAction = null;
	}
}
