using Coffee.UIExtensions;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TweenBossTenacity : TweenBase
{
	public RectTransform fillTrans;

	public Image tweenFill;

	private Slider slider;

	[SerializeField]
	private Image downStateFill;

	[SerializeField]
	private RectTransform downStateEff;

	public RectTransform Handle;

	private float HandleWidth;

	private bool inDownState;

	[SerializeField]
	private UIParticle effLow;

	[SerializeField]
	private UIParticle effMid;

	[SerializeField]
	private UIParticle effHigh;

	public float SliderValue
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
				SetLight(value, HandleWidth, Handle);
				if (inDownState)
				{
					downStateFill.fillAmount = value;
					SetLight(value, HandleWidth, downStateEff);
				}
			}
		}
	}

	protected override void SetRelateValue()
	{
		if (destValue == 0)
		{
			KillTween();
			tweenValue = 0f;
			SetTweenValueOnView();
		}
	}

	public override void InitBar(string logInfo = "")
	{
		HandleWidth = fillTrans.rect.width;
		slider = GetComponent<Slider>();
		slider.value = 1f;
		base.DestValue = base.MaxValue;
		base.CurrentValue = base.MaxValue;
		base.InitBar(logInfo);
	}

	protected override void SetFillValueOnView()
	{
		SliderValue = fillValue;
	}

	protected override void SetTweenValueOnView()
	{
		if (!inDownState)
		{
			tweenFill.fillAmount = tweenValue;
		}
	}

	protected override void OnEnable()
	{
		isStartDelay = false;
		isStartTween = false;
		inDownState = false;
	}

	protected override void RealPlayShakeEffect(int level)
	{
		switch (level)
		{
		case 0:
		{
			UIParticle obj2 = effLow;
			if (obj2 != null)
			{
				obj2.Play();
			}
			break;
		}
		case 1:
		{
			UIParticle obj3 = effMid;
			if (obj3 != null)
			{
				obj3.Play();
			}
			break;
		}
		case 2:
		{
			UIParticle obj = effHigh;
			if (obj != null)
			{
				obj.Play();
			}
			break;
		}
		}
	}

	private void SetLight(float curVal, float width, RectTransform light)
	{
		if ((bool)light)
		{
			float x = curVal * width;
			light.anchoredPosition = new Vector2(x, light.anchoredPosition.y);
		}
	}

	public void SetDownState(bool enterDown)
	{
		if (enterDown)
		{
			tweenFill.fillAmount = 0f;
		}
		inDownState = enterDown;
		fillTrans.GetComponent<Image>().enabled = !enterDown;
		downStateFill.fillAmount = 0f;
		downStateFill.gameObject.SetActive(enterDown);
		downStateEff.gameObject.SetActive(enterDown);
	}
}
