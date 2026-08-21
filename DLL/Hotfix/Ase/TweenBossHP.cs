#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TweenBossHP : TweenBase
{
	public RectTransform fillTrans;

	public RectTransform tweenTrans;

	public RectTransform shieldTrans;

	public Image fillImage;

	private Slider slider;

	public TextMeshProUGUI BarCountText;

	public RectTransform Handle;

	private float HandleWidth;

	private float HandleHight;

	public AutoDispose HandleEffect;

	private Animator animator;

	[SerializeField]
	private string aniLow;

	[SerializeField]
	private string aniMid;

	[SerializeField]
	private string aniHigh;

	public float SliderValue
	{
		get
		{
			return slider.value;
		}
		set
		{
			if (slider != null && slider.value != value)
			{
				SetImageType(value);
				slider.value = value;
				SetLight(value, HandleWidth, Handle);
			}
		}
	}

	public override void InitBar(string logInfo = "")
	{
		HandleWidth = fillTrans.rect.width;
		HandleHight = fillTrans.rect.height;
		slider = GetComponent<Slider>();
		slider.value = 0f;
		SliderValue = 1f;
		base.CurrentValue = base.MaxValue;
		base.DestValue = base.MaxValue;
		base.InitBar(logInfo);
		animator = GetComponent<Animator>();
	}

	protected override void SetFillValueOnView()
	{
		SliderValue = fillValue;
	}

	protected override void SetTweenValueOnView()
	{
		SetDislocation();
	}

	protected override void SetShieldFillValueOnView()
	{
		shieldTrans.GetComponent<Image>().fillAmount = shieldFillValue;
	}

	protected override void ChangeTweenLayer(bool isNormal = true)
	{
		if (isNormal)
		{
			fillTrans.SetAsLastSibling();
			isTweenTop = false;
		}
		else
		{
			tweenTrans.SetAsLastSibling();
			isTweenTop = true;
		}
	}

	protected override void SetDestBarCount()
	{
		((TMP_Text)BarCountText).text = ((destBarCountShow > 0) ? ("X" + destBarCountShow) : "");
	}

	protected override void RealPlayShakeEffect(int level)
	{
		if ((Object)(object)animator == null)
		{
			Log.Error("血条没有添加Animator，抖动不会播放");
			return;
		}
		switch (level)
		{
		case 0:
			animator.Play(aniLow, -1, 0f);
			break;
		case 1:
			animator.Play(aniMid, -1, 0f);
			break;
		case 2:
			animator.Play(aniHigh, -1, 0f);
			break;
		}
	}

	private void SetLight(float curVal, float width, RectTransform light)
	{
		float x = curVal * width;
		light.anchoredPosition = new Vector2(x, 0f);
		tweenTrans.transform.position = light.transform.position;
		SetDislocation();
	}

	private void SetDislocation()
	{
		tweenTrans.GetComponent<Image>().fillAmount = tweenValue - fillValue;
	}

	private void SetImageType(float curVal)
	{
		if ((double)curVal > 0.25)
		{
			if (slider.fillRect == null)
			{
				slider.fillRect = fillTrans;
			}
			if (fillImage.type == Image.Type.Filled)
			{
				fillTrans.anchoredPosition = Vector2.zero;
				fillTrans.sizeDelta = Vector2.zero;
				fillImage.fillAmount = 1f;
				fillImage.type = Image.Type.Simple;
			}
			return;
		}
		if (slider.fillRect != null)
		{
			slider.fillRect = null;
			fillTrans.anchorMin = Vector2.one * 0.5f;
			fillTrans.anchorMax = Vector2.one * 0.5f;
			fillTrans.pivot = Vector2.up * 0.5f;
		}
		if (fillImage.type == Image.Type.Simple)
		{
			fillImage.type = Image.Type.Filled;
			fillTrans.anchoredPosition = HandleWidth / 2f * Vector2.left;
			Vector2 sizeDelta = fillTrans.sizeDelta;
			sizeDelta.x = HandleWidth * 0.25f;
			sizeDelta.y = HandleHight;
			fillTrans.sizeDelta = sizeDelta;
		}
		fillImage.fillAmount = curVal / 0.25f;
	}
}
