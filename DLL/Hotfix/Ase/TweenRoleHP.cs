using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TweenRoleHP : TweenBase
{
	public float offset;

	public float ratio;

	public Image fillTransImage;

	public Image tweenTransImage;

	public Image shieldTransImage;

	public GameObject HPWarming;

	public float WarningThreshold = 0.15f;

	public bool ValueCurrentSizeChange;

	public int ValueCurrentSize;

	public TextMeshProUGUI ValueText;

	public TextMeshProUGUI ValueTextShodow;

	private int virtualValue;

	private float virtualValueTemp;

	public int VirtualValue
	{
		get
		{
			return virtualValue;
		}
		set
		{
			virtualValue = value;
		}
	}

	public float VirtualValueTemp
	{
		get
		{
			return virtualValueTemp;
		}
		set
		{
			VirtualValue = Mathf.CeilToInt(value);
		}
	}

	public override void InitBar(string logInfo = "")
	{
		base.DestValue = base.MaxValue;
		base.CurrentValue = base.MaxValue;
		base.InitBar(logInfo);
	}

	public void ChangeEntity(string logInf, int cur, int max, int shield, int vir)
	{
		logInfoTest = logInf;
		base.ChangeEntity(cur, max, shield, max);
		SetShieldFillValue();
		SetFillValue();
		tweenValue = fillValue;
		SetShieldFillValueOnView();
		SetFillValueOnView();
		SetTweenValueOnView();
		SetDestValueText();
		VirtualValue = vir;
	}

	protected override void SetFillValueOnView()
	{
		fillTransImage.fillAmount = fillValue / ratio + offset;
		if (HPWarming != null)
		{
			if (fillValue <= WarningThreshold && (float)base.DestValue * 1f / (float)base.MaxValue <= WarningThreshold)
			{
				HPWarming.SetActive(value: true);
			}
			else
			{
				HPWarming.SetActive(value: false);
			}
		}
	}

	protected override void SetTweenValueOnView()
	{
		tweenTransImage.fillAmount = tweenValue / ratio + offset;
	}

	protected override void SetShieldFillValueOnView()
	{
		if (ratio + offset == 0f)
		{
			shieldTransImage.fillAmount = 0f;
		}
		else
		{
			shieldTransImage.fillAmount = shieldFillValue / ratio + offset;
		}
	}

	protected override void SetDestValueText()
	{
		if (ValueCurrentSizeChange)
		{
			((TMP_Text)ValueText).text = $"<size={ValueCurrentSize}>{base.DestValue}</size>/{base.MaxValue}";
			if ((bool)(Object)(object)ValueTextShodow)
			{
				((TMP_Text)ValueTextShodow).text = $"<size={ValueCurrentSize}>{base.DestValue}</size>/{base.MaxValue}";
			}
		}
		else
		{
			((TMP_Text)ValueText).text = $"{base.DestValue}/{base.MaxValue}";
			if ((bool)(Object)(object)ValueTextShodow)
			{
				((TMP_Text)ValueTextShodow).text = $"{base.DestValue}/{base.MaxValue}";
			}
		}
	}

	protected override void RealPlayShakeEffect(int level)
	{
	}

	public float GetFillVal()
	{
		return fillValue / ratio + offset;
	}

	public float GetHpBarWidth()
	{
		return fillTransImage.rectTransform.sizeDelta.x;
	}
}
