using System.Collections.Generic;
using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class TipManager : Singleton<TipManager>
{
	private readonly List<TIP_TYPE> tipTypeList = new List<TIP_TYPE>
	{
		TIP_TYPE.TIP_COMMONTIP,
		TIP_TYPE.TIP_COMMONTIP_N,
		TIP_TYPE.TIP_GUIDE,
		TIP_TYPE.TIP_MISSION,
		TIP_TYPE.TIP_GUIDEPROMPT,
		TIP_TYPE.TIP_CHARACTERTEAMTUTORIAL
	};

	private readonly Dictionary<TIP_TYPE, string> tipAssetPathDic = new Dictionary<TIP_TYPE, string>
	{
		{
			TIP_TYPE.TIP_COMMONTIP,
			"TipUI/Tip_Common"
		},
		{
			TIP_TYPE.TIP_COMMONTIP_N,
			"TipUI/Tip_Common_N"
		},
		{
			TIP_TYPE.TIP_GUIDE,
			"TipUI/Tip_Guide"
		},
		{
			TIP_TYPE.TIP_MISSION,
			"TipUI/Tip_Mission"
		},
		{
			TIP_TYPE.TIP_GUIDEPROMPT,
			"TipUI/Tip_GuidePrompt"
		},
		{
			TIP_TYPE.TIP_CHARACTERTEAMTUTORIAL,
			"TipUI/Tip_CharacterTeamTutorial"
		}
	};

	private Dictionary<TIP_TYPE, TipPool> uiTypePoolDic = new Dictionary<TIP_TYPE, TipPool>();

	private Dictionary<TIP_TYPE, BaseTip> curOpTipDic = new Dictionary<TIP_TYPE, BaseTip>();

	private Dictionary<TIP_TYPE, Queue<BaseTipData>> waitOpenTipQueueDic = new Dictionary<TIP_TYPE, Queue<BaseTipData>>();

	public float safeTime = 2f;

	public override ContextType ContextType => ContextType.GLOBAL;

	public Dictionary<TIP_TYPE, Queue<BaseTipData>> WaitOpenTipQueueDic => waitOpenTipQueueDic;

	public override void Init()
	{
		base.Init();
		uiTypePoolDic.Clear();
		curOpTipDic.Clear();
		waitOpenTipQueueDic.Clear();
		foreach (TIP_TYPE tipType in tipTypeList)
		{
			uiTypePoolDic.Add(tipType, new TipPool(tipType, OnTipGet, OnTipRelease));
			curOpTipDic.Add(tipType, null);
			waitOpenTipQueueDic.Add(tipType, new Queue<BaseTipData>());
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Open, OnUIPanelChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Close, OnUIPanelChange);
	}

	public override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Open, OnUIPanelChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Close, OnUIPanelChange);
	}

	private void OnUIPanelChange(BaseEventContent obj)
	{
		EarlyCloseAllTip();
	}

	public void GetTip(TIP_TYPE uiType, BaseTipData data = null)
	{
		if (uiTypePoolDic.TryGetValue(uiType, out var value))
		{
			if (curOpTipDic[uiType] != null)
			{
				BaseTip baseTip = curOpTipDic[uiType];
				if (uiType != TIP_TYPE.TIP_COMMONTIP && baseTip.TimeAfterGet < safeTime && data != null && !data.ignoreWaitQueue)
				{
					waitOpenTipQueueDic[uiType].Enqueue(data);
					return;
				}
				if (baseTip.state < TipState.Closing)
				{
					baseTip.HideSelf();
				}
				BaseTip baseTip2 = value.Get(data);
				baseTip2.SetGetTime(Time.time);
				curOpTipDic[uiType] = baseTip2;
			}
			else
			{
				BaseTip baseTip3 = value.Get(data);
				baseTip3.SetGetTime(Time.time);
				curOpTipDic[uiType] = baseTip3;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"没有初始化 {uiType} 的对象池");
		}
	}

	public void GetTipFromQueue(TIP_TYPE uiType)
	{
		if (uiTypePoolDic.TryGetValue(uiType, out var value) && waitOpenTipQueueDic[uiType].Count > 0)
		{
			if (curOpTipDic[uiType] != null)
			{
				curOpTipDic[uiType].HideSelf();
			}
			BaseTip baseTip = value.Get(waitOpenTipQueueDic[uiType].Dequeue());
			baseTip.SetGetTime(Time.time);
			curOpTipDic[uiType] = baseTip;
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"没有初始化 {uiType} 的对象池");
		}
	}

	public void ReleaseTip(BaseTip tip)
	{
		if (uiTypePoolDic.TryGetValue(tip.tipType, out var value))
		{
			value.Release(tip);
			if (curOpTipDic[tip.tipType] == tip)
			{
				curOpTipDic[tip.tipType] = null;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"没有初始化 {tip.tipType} 的对象池");
		}
	}

	public void EarlyCloseAllTip()
	{
		if (waitOpenTipQueueDic.TryGetValue(TIP_TYPE.TIP_COMMONTIP, out var value))
		{
			value.Clear();
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Tip_EarlyClose, new TipEarlyCloseEvt());
	}

	public void OnTipGet(BaseTip tip)
	{
		tip.gameObject.SetActive(value: true);
		tip.OnGet();
		tip.OnShow();
	}

	public void OnTipRelease(BaseTip tip)
	{
		tip.OnRelease();
		tip.gameObject.SetActive(value: false);
	}

	public void OnTipClose(BaseTip tip)
	{
		tip.CloseTip();
	}

	public string GetTipAssetPathByTipType(TIP_TYPE tipType)
	{
		return tipAssetPathDic[tipType];
	}

	public BaseTip GetTipDataByTipType(TIP_TYPE tipType)
	{
		return curOpTipDic[tipType];
	}
}
