using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;

public class DrawController : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	public PlayableDirector timeline;

	private Action callBack;

	private bool isEnd = true;

	public AnimationCurve moveCurve = new AnimationCurve();

	public AnimationCurve fadeCurve = new AnimationCurve();

	private float value;

	private float fade_star_value;

	private float fade_star_timer;

	public float loop_time = 1.916f;

	public float stop_time = 2.875f;

	public float damping_time = 2.75f;

	public string cueSheetName_interaction = "ui_system_search";

	public string cueName_interaction = "search_interactive";

	public string cueSheetName_loop = "ui_system_search";

	public string cueName_loop = "search_environment";

	private Vector2 direct;

	private float distance;

	private bool _pointerFlag;

	public float audioRatio = 12f;

	public void Init(PlayableDirector timeline, Action action)
	{
		this.timeline = timeline;
		callBack = action;
	}

	private void Start()
	{
		value = 0f;
		fade_star_value = 0f;
		fade_star_timer = 0f;
		Vector2 b = new Vector3(Screen.width, Screen.height / 2);
		direct = b.normalized;
		distance = Vector2.Distance(new Vector2(0f, 0f), b);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if ((bool)timeline)
		{
			value = (float)timeline.time;
		}
		else
		{
			value = 0f;
		}
		_pointerFlag = true;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_pointerFlag = false;
	}

	public void OnDrag(PointerEventData eventData)
	{
		Vector2 delta = eventData.delta;
		float num = Vector2.Dot(direct, delta);
		float num2 = value;
		value -= num / distance * moveCurve.Evaluate(value);
		value = Mathf.Max(0f, value);
		if (num2 < loop_time)
		{
			value = Math.Min(value, loop_time);
		}
		else if (num2 < damping_time)
		{
			value = Math.Min(value, damping_time);
		}
		fade_star_value = value;
		fade_star_timer = 0f;
	}

	private void Update()
	{
		if (isEnd)
		{
			return;
		}
		if (value > stop_time)
		{
			SetAnimationProcess(stop_time);
			if ((bool)timeline)
			{
				timeline.Stop();
			}
			callBack?.Invoke();
			AudioManager.Instance.SetAisacControl("effect", "search_interactive", 1f);
			isEnd = true;
		}
		else if (!_pointerFlag)
		{
			if (loop_time < value)
			{
				float time = stop_time - fade_star_value + fade_star_timer;
				float num = fadeCurve.Evaluate(time) * Time.deltaTime;
				value -= num;
				value = Mathf.Max(0f, value);
				SetAnimationProcess(value);
				fade_star_timer += Time.deltaTime;
			}
			else
			{
				AudioManager.Instance.SetAisacControl("effect", "search_interactive", 1f);
			}
		}
		else
		{
			SetAnimationProcess(value);
		}
	}

	public void SetAnimationProcess(float value)
	{
		if ((bool)timeline)
		{
			double num = (double)value - timeline.time;
			float val = (float)Math.Abs(num) * audioRatio;
			float pValue = 1f - Math.Min(val, 1f);
			if (value < loop_time)
			{
				pValue = 1f;
			}
			AudioManager.Instance.SetAisacControl("effect", "search_interactive", pValue);
			AudioManager.Instance.SetAisacControl("effect", "sfx_volume", (!(num > 0.0)) ? 1 : 0);
			timeline.time = value;
		}
	}

	public void Reset()
	{
		isEnd = false;
		value = 0f;
		timeline.time = 0.0;
		timeline.Evaluate();
		timeline.Play();
		_pointerFlag = false;
		AudioManager.Instance.Play("effect", cueSheetName_loop, cueName_loop, useStream: false);
		AudioManager.Instance.Play("effect", cueSheetName_interaction, cueName_interaction, useStream: false);
	}
}
