using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TweenBase : MonoBehaviour
{
	protected string logInfoTest = "";

	public static List<int> tweenIdList = new List<int>();

	[SerializeField]
	private float tweenStartDelayTime = 0.5f;

	[SerializeField]
	private float tweenDuration = 1f;

	[SerializeField]
	[Range(0f, 1f)]
	private float shakeLow = 0.05f;

	[SerializeField]
	[Range(0f, 1f)]
	private float shakeHigh = 0.1f;

	protected float fillValue;

	protected float tweenValue;

	protected float shieldFillValue;

	private int currentValue;

	protected int destValue;

	private int perMaxValue = 1;

	private int maxValue;

	private int shieldValue;

	protected int destBarCountShow;

	protected bool isRecover;

	protected bool isTweenTop;

	protected bool isStartTween;

	protected bool isStartDelay;

	private Tween tween;

	private int tweenId;

	private float hpMaxValue;

	private float hpCurValue;

	public int DestValue
	{
		get
		{
			return destValue;
		}
		set
		{
			if (destValue != value)
			{
				TryPlayAni(value);
				destValue = value;
				SetRelateValue();
				if (base.gameObject.activeSelf)
				{
					StartTween();
				}
				else
				{
					CurrentValue = destValue;
				}
			}
		}
	}

	public int CurrentValue
	{
		get
		{
			return currentValue;
		}
		set
		{
			currentValue = value;
		}
	}

	public int PerMaxValue
	{
		get
		{
			return perMaxValue;
		}
		set
		{
			perMaxValue = value;
		}
	}

	public int MaxValue
	{
		get
		{
			return maxValue;
		}
		set
		{
			if (value == 0)
			{
				return;
			}
			if (maxValue != value)
			{
				SetRelateValue();
				if (base.gameObject.activeSelf)
				{
					StartTween();
				}
			}
			maxValue = value;
			PerMaxValue = value;
		}
	}

	public float HpMaxValue
	{
		get
		{
			return hpMaxValue;
		}
		set
		{
			hpMaxValue = value;
			MaxValue = Mathf.CeilToInt(value);
			if (base.gameObject.activeSelf)
			{
				StartTween();
			}
		}
	}

	public float HpCurValue
	{
		get
		{
			return hpCurValue;
		}
		set
		{
			hpCurValue = value;
			DestValue = Mathf.CeilToInt(value);
		}
	}

	public int ShieldValue
	{
		get
		{
			return shieldValue;
		}
		set
		{
			shieldValue = value;
			UpdateBloodBarShield();
		}
	}

	public float TweenDuration
	{
		get
		{
			return tweenDuration;
		}
		set
		{
			tweenDuration = value;
		}
	}

	public float TweenStartDelayTime
	{
		get
		{
			return tweenStartDelayTime;
		}
		set
		{
			tweenStartDelayTime = value;
		}
	}

	public virtual void ChangeEntity(int cur, int max, int shield, int per)
	{
		destValue = cur;
		currentValue = cur;
		maxValue = max;
		perMaxValue = per;
		shieldValue = shield;
	}

	protected virtual void SetRelateValue()
	{
	}

	private void Awake()
	{
		if (tweenIdList.Count == 0)
		{
			tweenId = 0;
		}
		else
		{
			tweenId = tweenIdList[tweenIdList.Count - 1] + 1;
		}
		tweenIdList.Add(tweenId);
	}

	public virtual void InitBar(string logInfo = "")
	{
		logInfoTest = logInfo;
		isRecover = false;
		isStartDelay = false;
		isStartTween = false;
		isTweenTop = false;
		fillValue = 1f;
		tweenValue = 1f;
		destBarCountShow = ((PerMaxValue != 0) ? (DestValue / PerMaxValue) : 0);
		SetDestBarCount();
		SetBarColor(DestValue);
		SetDestValueText();
	}

	private void Update()
	{
		if (base.gameObject.activeSelf)
		{
			isRecover = destValue > currentValue;
			if (!isRecover && !isStartDelay && !isStartTween && (tweenValue > fillValue || currentValue > destValue))
			{
				StartTween();
			}
		}
	}

	protected void StartTween()
	{
		if (!base.gameObject.activeSelf)
		{
			return;
		}
		KillTween();
		SetDOTweenParam();
		if (!isRecover && !isStartDelay)
		{
			isStartDelay = true;
			if (base.gameObject.activeSelf)
			{
				Executors.RunOnCoroutine(DelayDoTween());
			}
			else
			{
				DoTween(GetBarCountByValue(DestValue));
			}
		}
		else if (isRecover)
		{
			DoTween(GetBarCountByValue(DestValue));
		}
	}

	private IEnumerator DelayDoTween()
	{
		yield return new WaitForSeconds(tweenStartDelayTime);
		isStartTween = true;
		isStartDelay = false;
		DoTween(GetBarCountByValue(DestValue));
	}

	protected void DoTween(int endCount)
	{
		tween = DOTween.To(() => CurrentValue, delegate(int v)
		{
			CurrentValue = v;
		}, DestValue, tweenDuration).OnComplete(delegate
		{
			OnTweenCompleted();
		}).OnUpdate(delegate
		{
			if (!isRecover && isTweenTop && GetBarCountByValue(CurrentValue) == endCount)
			{
				ChangeTweenLayer();
			}
			UpdateBloodBar();
		})
			.SetEase(Ease.OutSine)
			.SetId(tweenId);
	}

	protected void KillTween()
	{
		if (tween != null)
		{
			isStartTween = false;
			DOTween.Kill(tweenId);
		}
	}

	private void UpdateBloodBarShield()
	{
		SetShieldFillValue();
		SetFillValue();
		tweenValue = fillValue;
		SetBarColor(CurrentValue);
		SetShieldFillValueOnView();
		SetFillValueOnView();
		SetTweenValueOnView();
	}

	private void UpdateBloodBar()
	{
		if (!isRecover)
		{
			SetTweenFillValue(isRecover);
			SetTweenValueOnView();
			return;
		}
		SetShieldFillValue();
		SetFillValue();
		tweenValue = fillValue;
		SetBarColor(CurrentValue);
		SetFillValueOnView();
		SetTweenValueOnView();
		SetShieldFillValueOnView();
	}

	private void SetDOTweenParam()
	{
		destBarCountShow = ((PerMaxValue != 0) ? (DestValue / PerMaxValue) : 0);
		SetDestBarCount();
		SetDestValueText();
		fillValue = Mathf.Clamp(1f * (float)AdjustValueShow(DestValue) / (float)PerMaxValue, 0f, 1f);
		SetFillValueOnView();
		int barCountByValue = GetBarCountByValue(CurrentValue);
		int barCountByValue2 = GetBarCountByValue(DestValue);
		if (CurrentValue < DestValue)
		{
			isRecover = true;
			ChangeTweenLayer();
			return;
		}
		isRecover = false;
		if (barCountByValue != barCountByValue2)
		{
			if (barCountByValue > barCountByValue2 + 1)
			{
				CurrentValue = (barCountByValue2 + 1) * PerMaxValue;
				tweenValue = 1f * (float)AdjustValueShow(CurrentValue) / (float)PerMaxValue;
				SetTweenValueOnView();
				ChangeTweenLayer(isNormal: false);
			}
			else if (barCountByValue > barCountByValue2)
			{
				ChangeTweenLayer(isNormal: false);
			}
			SetBarColor(DestValue);
		}
	}

	private void TryPlayAni(int value)
	{
		if (destValue <= value)
		{
			return;
		}
		float num = 1f * (float)AdjustValueShow(destValue) / (float)PerMaxValue;
		float num2 = 1f * (float)AdjustValueShow(value) / (float)PerMaxValue;
		float num3 = num - num2;
		if (!(num3 <= 0f))
		{
			if (num3 > shakeHigh)
			{
				RealPlayShakeEffect(2);
			}
			else if (num3 < shakeHigh && num3 >= shakeLow)
			{
				RealPlayShakeEffect(1);
			}
			else
			{
				RealPlayShakeEffect(0);
			}
		}
	}

	protected virtual void RealPlayShakeEffect(int level)
	{
	}

	protected virtual void SetDestValueText()
	{
	}

	protected int GetBarCountByValue(int ValueValue)
	{
		if (PerMaxValue == 0)
		{
			PerMaxValue = ((ValueValue == 0) ? 1 : ValueValue);
		}
		if (ValueValue % PerMaxValue == 0)
		{
			return ValueValue / PerMaxValue;
		}
		return ValueValue / PerMaxValue + 1;
	}

	protected int AdjustValueShow(int val)
	{
		if (val > 0)
		{
			if (val % PerMaxValue != 0)
			{
				return val % PerMaxValue;
			}
			return PerMaxValue;
		}
		return 0;
	}

	protected virtual void SetShieldFillValue()
	{
		if (ShieldValue <= 0 || PerMaxValue == 0)
		{
			shieldFillValue = 0f;
		}
		else if (ShieldValue + DestValue > PerMaxValue)
		{
			shieldFillValue = 1f;
		}
		else
		{
			shieldFillValue = (1f * (float)AdjustValueShow(DestValue) + (float)ShieldValue) / (float)PerMaxValue;
		}
	}

	protected virtual void SetTweenFillValue(bool isRecover)
	{
		if (!isRecover)
		{
			if (ShieldValue + DestValue > PerMaxValue)
			{
				tweenValue = 1f * (float)AdjustValueShow(CurrentValue) / (float)(DestValue + ShieldValue);
			}
			else
			{
				tweenValue = 1f * (float)AdjustValueShow(CurrentValue) / (float)PerMaxValue;
			}
		}
	}

	protected virtual void SetFillValue()
	{
		if (ShieldValue + DestValue > PerMaxValue)
		{
			fillValue = Mathf.Clamp(1f * (float)AdjustValueShow(DestValue) / (float)(DestValue + ShieldValue), 0f, 1f);
		}
		else
		{
			fillValue = Mathf.Clamp(1f * (float)AdjustValueShow(DestValue) / (float)PerMaxValue, 0f, 1f);
		}
	}

	protected virtual void SetShieldFillValueOnView()
	{
	}

	protected virtual void SetFillValueOnView()
	{
	}

	protected virtual void SetTweenValueOnView()
	{
	}

	protected virtual void SetBarColor(int val)
	{
	}

	protected virtual void ChangeTweenLayer(bool isNormal = true)
	{
	}

	protected virtual void SetDestBarCount()
	{
	}

	protected virtual void OnEnable()
	{
		isStartDelay = false;
	}

	private void OnDisable()
	{
		StopAllCoroutines();
	}

	private void OnDestroy()
	{
		DOTween.Kill(tweenId);
		int num = tweenIdList.LastIndexOf(tweenId);
		if (num != -1)
		{
			tweenIdList.RemoveAt(num);
		}
	}

	protected virtual void OnTweenCompleted()
	{
		isStartTween = false;
		ChangeTweenLayer();
	}

	public void StopCoroutinesAhead()
	{
		StopAllCoroutines();
	}
}
