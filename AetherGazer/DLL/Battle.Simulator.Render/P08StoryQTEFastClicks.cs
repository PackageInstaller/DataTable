using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class P08StoryQTEFastClicks : P08StoryQTEUI, IPointerUpHandler, IEventSystemHandler, IPointerDownHandler
{
	private Slider _slider;

	private RectTransform _fillRectTrans;

	private RectTransform _handleRectTrans;

	private RectTransform _glow;

	private RectTransform _glow_kuang;

	private RectTransform _glow_full;

	private GameObject _anxia_go;

	private GameObject _daiji_go;

	private GameObject _text_go;

	private Animation _close_anim;

	private Renderer _guangban_ps;

	private Renderer _lizi1_ps;

	private Renderer _lizi2_ps;

	private Image _slider_fill_img;

	private float _timeLimit;

	private int _clickInterval;

	private int _falloutInterval;

	private AnimationCurve _growCurve;

	private AnimationCurve _falloutCurve;

	private bool _inited;

	private bool _finished;

	private float _currentTime;

	private int _currentFrame;

	private int _previousClickFrame;

	private int _previousFalloutFrame;

	private int _currentCount;

	private Action _successAction;

	private Action _failedAction;

	private Action<int> _onClickAction;

	private Action<float> _onProgressUpdateAction;

	public Gradient guangbanGrad;

	public Gradient liziGrad;

	public Gradient sliderGrad;

	public void Init(float timeLimit, int clickInterval, int falloutInterval, AnimationCurve growCurve, AnimationCurve falloutCurve, Action successAction, Action failedAction, Action<int> onClickAction)
	{
		_timeLimit = timeLimit;
		_clickInterval = clickInterval;
		_falloutInterval = falloutInterval;
		_growCurve = growCurve;
		_falloutCurve = falloutCurve;
		_currentTime = 0f;
		_currentCount = 0;
		_currentFrame = 0;
		_previousClickFrame = 0;
		_previousFalloutFrame = 0;
		_successAction = successAction;
		_failedAction = failedAction;
		_onClickAction = onClickAction;
		_inited = true;
		_finished = false;
		_slider = GetGoFromCfg("_slider").GetComponent<Slider>();
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
		_close_anim = base.gameObject.GetComponent<Animation>();
	}

	public void RegistProgreeUpdateEvent(Action<float> action)
	{
		_onProgressUpdateAction = action;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (_inited && !_finished)
		{
			_anxia_go.SetActive(value: false);
			_daiji_go.SetActive(value: true);
			_text_go.SetActive(value: false);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (!_inited || _finished)
		{
			return;
		}
		_anxia_go.SetActive(value: true);
		_daiji_go.SetActive(value: false);
		_glow.gameObject.SetActive(value: true);
		if (_currentFrame - _previousClickFrame >= _clickInterval)
		{
			_currentCount++;
			_slider.value = Mathf.Min(_slider.value + _growCurve.Evaluate(_currentCount), 1f);
			_previousClickFrame = _currentFrame;
			_glow.position = _handleRectTrans.position;
			_onClickAction?.Invoke(_currentCount);
			_onProgressUpdateAction?.Invoke(_slider.value);
			if (_slider.value >= 1f)
			{
				SuccessCall();
			}
		}
	}

	private void Update()
	{
		if (_inited && !_finished)
		{
			_currentTime += Time.deltaTime;
			_currentFrame++;
			if (_currentFrame - _previousFalloutFrame >= _falloutInterval)
			{
				_slider.value = Mathf.Max(_slider.value - _falloutCurve.Evaluate(_slider.value), 0f);
				_previousFalloutFrame = _currentFrame;
				_glow.gameObject.SetActive(value: true);
				_glow.position = _handleRectTrans.position;
				_onProgressUpdateAction?.Invoke(_slider.value);
			}
			Color value = guangbanGrad.Evaluate(_slider.value);
			Color value2 = liziGrad.Evaluate(_slider.value);
			Color color = sliderGrad.Evaluate(_slider.value);
			_guangban_ps.material.SetColor("_Color", value);
			_lizi1_ps.material.SetColor("_Color", value2);
			_lizi2_ps.material.SetColor("_Color", value2);
			_slider_fill_img.color = color;
			if (_currentTime > _timeLimit)
			{
				FailedCall();
			}
		}
	}

	public void SuccessCall()
	{
		if (_successAction != null)
		{
			_successAction();
		}
		_successAction = null;
		_failedAction = null;
		_onClickAction = null;
		_inited = false;
		_finished = true;
		_glow_kuang.gameObject.SetActive(value: true);
		_glow_full.gameObject.SetActive(value: true);
	}

	public void FailedCall()
	{
		_currentTime = 0f;
		_currentCount = 0;
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

	public override void Dispose(float delay)
	{
		base.Dispose(delay);
		_successAction = null;
		_failedAction = null;
		_onClickAction = null;
		_onProgressUpdateAction = null;
		_close_anim?.Play();
	}
}
