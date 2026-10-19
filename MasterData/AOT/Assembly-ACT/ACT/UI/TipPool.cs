using System;
using System.Collections.Generic;
using Bamboo.AssetField;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class TipPool
{
	private TIP_TYPE tipType;

	private GameObject prefab;

	private readonly Stack<BaseTip> m_Stack = new Stack<BaseTip>();

	private readonly Action<BaseTip> m_ActionOnGet;

	private readonly Action<BaseTip> m_ActionOnRelease;

	protected int m_Mul = 1;

	protected int m_Interval;

	public int countAll { get; private set; }

	public int countActive => countAll - countInactive;

	public int countInactive => m_Stack.Count;

	public TipPool(TIP_TYPE tipType)
	{
		Init(tipType);
		m_ActionOnGet = (m_ActionOnRelease = null);
		m_Interval = 20;
	}

	public TipPool(TIP_TYPE tipType, Action<BaseTip> actionOnGet, Action<BaseTip> actionOnRelease, int interval = 10)
	{
		Init(tipType);
		m_ActionOnGet = actionOnGet;
		m_ActionOnRelease = actionOnRelease;
		m_Interval = interval;
	}

	public void Init(TIP_TYPE tipType)
	{
		this.tipType = tipType;
		AssetStationManager.Root.LoadAsync<GameObject>(Singleton<TipManager>.instance.GetTipAssetPathByTipType(tipType), (AssetLoadHandle result) =>
		{
			prefab = result.AsGameObject();
		});
	}

	public BaseTip Get(BaseTipData data = null)
	{
		BaseTip baseTip;
		if (m_Stack.Count == 0)
		{
			baseTip = UnityEngine.Object.Instantiate(prefab, Singleton<NewUIManager>.instance.TipRoot).GetComponent<BaseTip>();
			baseTip.state = TipState.Hidden;
			baseTip.tipType = tipType;
			countAll++;
			if (countActive > m_Interval * m_Mul)
			{
				m_Mul *= 2;
				if (!LuminApplication.LogEnabled)
				{
				}
			}
		}
		else
		{
			baseTip = m_Stack.Pop();
		}
		baseTip.SetTipData(data);
		m_ActionOnGet?.Invoke(baseTip);
		return baseTip;
	}

	public void Release(BaseTip tip)
	{
		m_ActionOnRelease?.Invoke(tip);
		if (m_Stack.Count > 0 && m_Stack.Contains(tip))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Internal error. Trying to destroy object that is already released to pool.");
			}
		}
		else
		{
			m_Stack.Push(tip);
		}
	}
}
