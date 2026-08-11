using UnityEngine;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(Slider))]
public class SubTweenSlider : MonoBehaviour
{
	public RectTransform fillTrans;

	public RectTransform tweenTrans;

	public float tweenSpeed = 4f;

	private Slider slider;

	private bool tween_flag;

	private float last_max_x;

	private float start_x;

	private float end_x;

	private float now_x;

	private float tm_t;

	public float value
	{
		get
		{
			return slider.value;
		}
		set
		{
			if (slider != null)
			{
				slider.value = value;
				Start_Tween();
			}
		}
	}

	private void Awake()
	{
		slider = GetComponent<Slider>();
		fillTrans.SetAsLastSibling();
		tweenTrans.anchorMax = fillTrans.anchorMax;
		last_max_x = fillTrans.anchorMax.x;
		tween_flag = false;
	}

	private void Update()
	{
		if (tween_flag)
		{
			tm_t += tweenSpeed * Time.deltaTime;
			if (tm_t >= 1f)
			{
				tm_t = 1f;
				tween_flag = false;
				last_max_x = end_x;
			}
			now_x = Mathf.Lerp(start_x, end_x, tm_t);
			tweenTrans.anchorMax = new Vector2(now_x, fillTrans.anchorMax.y);
		}
	}

	private void Start_Tween()
	{
		start_x = last_max_x;
		end_x = fillTrans.anchorMax.x;
		if (start_x < end_x)
		{
			start_x = 1f;
		}
		tween_flag = true;
		tm_t = 0f;
	}
}
