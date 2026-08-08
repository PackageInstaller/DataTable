using System;
using UnityEngine;
using UnityEngine.EventSystems;

[RequireComponent(typeof(CanvasRenderer))]
[RequireComponent(typeof(EventTriggerListener))]
[DisallowMultipleComponent]
public class HoverEffect : MonoBehaviour
{
	private static string HoverAnimState = "hoverAnimState";

	private static string ClickAnimState = "clickAnimState";

	private static string IdleAnimState = "idleAnimState";

	private static string ClickIdleAnimState = "clickIdleAnimState";

	private static int idleStateId = Animator.StringToHash(IdleAnimState);

	private static int hoverStateId = Animator.StringToHash(HoverAnimState);

	private static int clickStateId = Animator.StringToHash(ClickAnimState);

	private static int clickIdleStateId = Animator.StringToHash(ClickIdleAnimState);

	private EventTriggerListener eventTrigger;

	private EventTriggerListenerEX ex;

	[NonSerialized]
	private HoverEffectContext context;

	[SerializeField]
	private HoverEffectConfig config = new HoverEffectConfig
	{
		disableTween = false,
		scaleMultiple = 1.02f,
		enterScaleTime = 0.8f,
		exitScaleTime = 0.2f,
		tweenType = LeanTweenType.easeOutElastic,
		enterClickTweenType = LeanTweenType.linear,
		clickScaleMultiple = 0.95f,
		enterClickScaleTime = 0.1f,
		crossFadeTime = 0.05f
	};

	private void Awake()
	{
		eventTrigger = GetComponent<EventTriggerListener>();
		ex = eventTrigger.GetEventTriggerEX();
		context.isMobile = false;
		AddHoverListener();
		context.originScale = base.transform.localScale.x;
		if (config.animator != null)
		{
			context.animator = config.animator;
		}
		else
		{
			context.animator = GetComponent<Animator>();
		}
		context.firstEnableDirty = true;
		BuildAnimState();
	}

	private void OnEnable()
	{
		RecoverState();
	}

	public void RecoverState()
	{
		if (context.firstEnableDirty)
		{
			context.firstEnableDirty = false;
			return;
		}
		context.pointerState = (HoverPointerState)0;
		if ((context.animState & HoverAnimStateFlag.Idle) > (HoverAnimStateFlag)0)
		{
			context.animator.CrossFade(IdleAnimState, 0f);
		}
		if (!config.disableTween)
		{
			base.transform.localScale = new Vector2(context.originScale, context.originScale);
		}
	}

	private void BuildAnimState()
	{
		HoverAnimStateFlag hoverAnimStateFlag = (HoverAnimStateFlag)0;
		if (context.animator != null)
		{
			if (context.animator.HasState(0, idleStateId))
			{
				hoverAnimStateFlag |= HoverAnimStateFlag.Idle;
			}
			if (context.animator.HasState(0, hoverStateId))
			{
				hoverAnimStateFlag |= HoverAnimStateFlag.Hover;
			}
			if (context.animator.HasState(0, clickStateId))
			{
				hoverAnimStateFlag |= HoverAnimStateFlag.Click;
			}
			if (context.animator.HasState(0, clickIdleStateId))
			{
				hoverAnimStateFlag |= HoverAnimStateFlag.ClickIdle;
			}
		}
		context.animState = hoverAnimStateFlag;
	}

	private void AddHoverListener()
	{
		if (context.isMobile)
		{
			EventTriggerListenerEX eventTriggerListenerEX = ex;
			eventTriggerListenerEX.onPointerDown = (LuaHelper.ETLCallBack1)Delegate.Combine(eventTriggerListenerEX.onPointerDown, new LuaHelper.ETLCallBack1(OnClickStart));
			EventTriggerListenerEX eventTriggerListenerEX2 = ex;
			eventTriggerListenerEX2.onPointerUp = (LuaHelper.ETLCallBack1)Delegate.Combine(eventTriggerListenerEX2.onPointerUp, new LuaHelper.ETLCallBack1(OnClickEnd));
			return;
		}
		EventTriggerListenerEX eventTriggerListenerEX3 = ex;
		eventTriggerListenerEX3.onPointerEnter = (LuaHelper.ETLCallBack1)Delegate.Combine(eventTriggerListenerEX3.onPointerEnter, new LuaHelper.ETLCallBack1(OnStartHover));
		EventTriggerListenerEX eventTriggerListenerEX4 = ex;
		eventTriggerListenerEX4.onPointerExit = (LuaHelper.ETLCallBack1)Delegate.Combine(eventTriggerListenerEX4.onPointerExit, new LuaHelper.ETLCallBack1(OnEndHover));
		EventTriggerListenerEX eventTriggerListenerEX5 = ex;
		eventTriggerListenerEX5.onPointerDown = (LuaHelper.ETLCallBack1)Delegate.Combine(eventTriggerListenerEX5.onPointerDown, new LuaHelper.ETLCallBack1(OnClickStart));
		EventTriggerListenerEX eventTriggerListenerEX6 = ex;
		eventTriggerListenerEX6.onPointerUp = (LuaHelper.ETLCallBack1)Delegate.Combine(eventTriggerListenerEX6.onPointerUp, new LuaHelper.ETLCallBack1(OnClickEnd));
	}

	private void RemoveHoverListener()
	{
		EventTriggerListenerEX eventTriggerListenerEX = ex;
		eventTriggerListenerEX.onPointerEnter = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX.onPointerEnter, new LuaHelper.ETLCallBack1(OnStartHover));
		EventTriggerListenerEX eventTriggerListenerEX2 = ex;
		eventTriggerListenerEX2.onPointerExit = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX2.onPointerExit, new LuaHelper.ETLCallBack1(OnEndHover));
		EventTriggerListenerEX eventTriggerListenerEX3 = ex;
		eventTriggerListenerEX3.onPointerDown = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX3.onPointerDown, new LuaHelper.ETLCallBack1(OnClickStart));
		EventTriggerListenerEX eventTriggerListenerEX4 = ex;
		eventTriggerListenerEX4.onPointerUp = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX4.onPointerUp, new LuaHelper.ETLCallBack1(OnClickEnd));
	}

	private void OnStartHover(GameObject obj, PointerEventData e)
	{
		context.pointerState |= HoverPointerState.POINT_INNER;
		if ((context.pointerState & HoverPointerState.POINT_DOWN) > (HoverPointerState)0)
		{
			return;
		}
		if (!config.disableTween)
		{
			if (context.exitTween != -1)
			{
				LeanTween.cancel(context.exitTween);
				context.exitTween = -1;
			}
			PlayEnterTween(obj);
		}
		if ((context.animState & HoverAnimStateFlag.Hover) > (HoverAnimStateFlag)0)
		{
			context.animator.CrossFade(HoverAnimState, config.crossFadeTime);
		}
	}

	private void OnEndHover(GameObject obj, PointerEventData e)
	{
		context.pointerState &= ~HoverPointerState.POINT_INNER;
		if ((context.pointerState & HoverPointerState.POINT_DOWN) > (HoverPointerState)0)
		{
			return;
		}
		if (!config.disableTween)
		{
			if (context.enterTween != -1)
			{
				LeanTween.cancel(context.enterTween);
				context.enterTween = -1;
			}
			PlayExitTween(obj);
		}
		if ((context.animState & HoverAnimStateFlag.Idle) > (HoverAnimStateFlag)0)
		{
			context.animator.CrossFade(IdleAnimState, config.crossFadeTime);
		}
	}

	private void OnClickStart(GameObject obj, PointerEventData eventData)
	{
		context.pointerState |= HoverPointerState.POINT_DOWN;
		if (!config.disableTween)
		{
			if (context.enterTween != -1)
			{
				LeanTween.cancel(context.enterTween);
				context.enterTween = -1;
			}
			PlayClickTween(obj);
		}
		if ((context.animState & HoverAnimStateFlag.Click) > (HoverAnimStateFlag)0)
		{
			context.animator.CrossFade(ClickAnimState, config.crossFadeTime);
		}
	}

	private void OnClickEnd(GameObject obj, PointerEventData eventData)
	{
		context.pointerState &= ~HoverPointerState.POINT_DOWN;
		if (!config.disableTween)
		{
			if (context.clickTween != -1)
			{
				LeanTween.cancel(context.clickTween);
				context.clickTween = -1;
			}
			if ((context.pointerState & HoverPointerState.POINT_INNER) > (HoverPointerState)0)
			{
				PlayEnterTween(obj);
			}
			else
			{
				PlayExitTween(obj);
			}
		}
		if ((context.pointerState & HoverPointerState.POINT_INNER) > (HoverPointerState)0)
		{
			if ((context.animState & HoverAnimStateFlag.Hover) > (HoverAnimStateFlag)0)
			{
				context.animator.CrossFade(HoverAnimState, config.crossFadeTime);
			}
		}
		else if ((context.animState & HoverAnimStateFlag.ClickIdle) > (HoverAnimStateFlag)0)
		{
			context.animator.CrossFade(ClickIdleAnimState, config.crossFadeTime);
		}
		else if ((context.animState & HoverAnimStateFlag.Idle) > (HoverAnimStateFlag)0)
		{
			context.animator.CrossFade(IdleAnimState, config.crossFadeTime);
		}
	}

	private void PlayEnterTween(GameObject obj)
	{
		context.enterTween = LeanTween.scale(obj, new Vector3(config.scaleMultiple * context.originScale, config.scaleMultiple * context.originScale, config.scaleMultiple * context.originScale), config.enterScaleTime).setEase(config.tweenType).setOnComplete((Action)delegate
		{
			context.enterTween = -1;
		})
			.uniqueId;
	}

	private void PlayExitTween(GameObject obj)
	{
		context.exitTween = LeanTween.scale(obj, new Vector3(context.originScale, context.originScale, config.scaleMultiple * context.originScale), config.exitScaleTime).setOnComplete((Action)delegate
		{
			context.exitTween = -1;
		}).uniqueId;
	}

	private void PlayClickTween(GameObject obj)
	{
		context.clickTween = LeanTween.scale(obj, new Vector3(config.clickScaleMultiple * context.originScale, config.clickScaleMultiple * context.originScale, config.scaleMultiple * context.originScale), config.enterClickScaleTime).setEase(config.enterClickTweenType).setOnComplete((Action)delegate
		{
			context.clickTween = -1;
		})
			.uniqueId;
	}

	public void ActiveTween(bool isActive)
	{
		config.disableTween = isActive;
	}

	private void OnDestroy()
	{
		if (ex != null)
		{
			EventTriggerListenerEX eventTriggerListenerEX = ex;
			eventTriggerListenerEX.onPointerEnter = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX.onPointerEnter, new LuaHelper.ETLCallBack1(OnStartHover));
			EventTriggerListenerEX eventTriggerListenerEX2 = ex;
			eventTriggerListenerEX2.onPointerExit = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX2.onPointerExit, new LuaHelper.ETLCallBack1(OnEndHover));
			EventTriggerListenerEX eventTriggerListenerEX3 = ex;
			eventTriggerListenerEX3.onPointerDown = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX3.onPointerDown, new LuaHelper.ETLCallBack1(OnClickStart));
			EventTriggerListenerEX eventTriggerListenerEX4 = ex;
			eventTriggerListenerEX4.onPointerUp = (LuaHelper.ETLCallBack1)Delegate.Remove(eventTriggerListenerEX4.onPointerUp, new LuaHelper.ETLCallBack1(OnClickEnd));
		}
	}
}
