using ACT.Event;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.UI;

public class BaseTip : MonoBehaviour
{
	[FormerlySerializedAs("uiType")]
	[HideInInspector]
	public TIP_TYPE tipType;

	public TipState state;

	public Canvas contentCanvas;

	public Animator tipAnimator;

	public BetterAnimation betterAnimation;

	public float remainTime;

	private float autoHideTimer;

	private float timeOnGet;

	protected BaseTipData m_Data;

	public float TimeAfterGet => Time.time - timeOnGet;

	public virtual async void OnGet()
	{
		if (tipAnimator != null)
		{
			tipAnimator.Rebind();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Tip_EarlyClose, EarlyClose);
		if (Singleton<TipManager>.instance.safeTime > 0f)
		{
			await UniTask.WaitUntil(() => TimeAfterGet >= Singleton<TipManager>.instance.safeTime);
			if (Singleton<TipManager>.instance.WaitOpenTipQueueDic[tipType].Count > 0)
			{
				Singleton<TipManager>.instance.GetTipFromQueue(tipType);
			}
		}
	}

	public virtual void OnShow()
	{
		state = TipState.Opening;
		autoHideTimer = 0f;
	}

	public virtual void OnHide()
	{
		state = TipState.Closing;
	}

	public void OnRelease()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Tip_EarlyClose, EarlyClose);
	}

	public void HideSelf()
	{
		OnHide();
	}

	public void OpenAnimationFinish()
	{
		if (state == TipState.Opening)
		{
			state = TipState.Normal;
		}
	}

	public void CloseAnimationFinish()
	{
		if (state == TipState.Closing)
		{
			state = TipState.Hidden;
			ReleaseSelf();
		}
	}

	public void EarlyClose(BaseEventContent baseEvent)
	{
		if (tipType != TIP_TYPE.TIP_GUIDEPROMPT && state < TipState.Closing)
		{
			HideSelf();
		}
	}

	protected virtual void Update()
	{
		if (state == TipState.Normal)
		{
			if (autoHideTimer < remainTime)
			{
				autoHideTimer += Time.deltaTime;
			}
			else
			{
				HideSelf();
			}
		}
	}

	public void SetTipData(BaseTipData data)
	{
		m_Data = data;
	}

	public BaseTipData GetTipData()
	{
		return m_Data;
	}

	public void SetGetTime(float timeOnGet)
	{
		this.timeOnGet = timeOnGet;
	}

	public void ReleaseSelf()
	{
		Singleton<TipManager>.instance.ReleaseTip(this);
	}

	public void CloseTip()
	{
		HideSelf();
	}
}
