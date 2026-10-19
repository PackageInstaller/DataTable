using System;
using System.Collections.Generic;
using Fundamental;
using UnityEngine;

namespace ACT.Core;

public class Property
{
	protected readonly List<IPropertyProvider> m_Base = new List<IPropertyProvider>();

	protected readonly List<IPropertyProvider> m_Add = new List<IPropertyProvider>();

	protected readonly List<IPropertyProvider> m_Mul = new List<IPropertyProvider>();

	protected float m_Value;

	protected float m_PracticalValue;

	private float m_BaseValue;

	private float m_AddValue;

	private float m_MulValue;

	private bool m_Dirty;

	private bool m_Flushing;

	private float m_ValueBeforeDirty;

	private PropertyDescriptor m_PendingDescriptor;

	public ActionList<float, float, PropertyDescriptor> onValueChange = new ActionList<float, float, PropertyDescriptor>();

	private const float scale = 10000f;

	private const float eps = 1E-06f;

	internal IPropertyFormula formula { get; set; }

	internal PropertyCalculate originalCalType { get; set; }

	public RoundingFunction rounding { get; set; }

	public float value
	{
		get
		{
			if (m_Dirty)
			{
				Flush();
			}
			return m_Value;
		}
	}

	public float PracticalValue => m_PracticalValue;

	private void MarkDirty(PropertyDescriptor descriptor = PropertyDescriptor.None)
	{
		if (!m_Dirty)
		{
			m_Dirty = true;
			m_ValueBeforeDirty = m_Value;
			m_PendingDescriptor = descriptor;
			PropertyDirtyTracker.MarkDirty(this);
		}
		else
		{
			m_PendingDescriptor |= descriptor;
		}
	}

	internal void Flush()
	{
		if (m_Dirty && !m_Flushing)
		{
			m_Dirty = false;
			m_Flushing = true;
			float valueBeforeDirty = m_ValueBeforeDirty;
			PropertyDescriptor pendingDescriptor = m_PendingDescriptor;
			RecalculateInternal();
			if (!Mathf.Approximately(valueBeforeDirty, m_Value))
			{
				onValueChange.Invoke(valueBeforeDirty, m_Value, pendingDescriptor);
			}
			m_Flushing = false;
		}
	}

	private void RecalculateInternal()
	{
		if (formula != null)
		{
			m_Value = formula.Calculate(m_Base, m_Add, m_Mul, out m_BaseValue, out m_AddValue, out m_MulValue);
			Rounding();
		}
	}

	public void PushSubValue(PropertySub subType, IPropertyProvider provider, bool needCal)
	{
		PushSubValueInternal(subType, provider);
		MarkDirty(provider.GetDescriptor());
		if (needCal)
		{
			Flush();
		}
	}

	public void PopSubValue(PropertySub subType, IPropertyProvider provider, bool needCal)
	{
		PopSubValueInternal(subType, provider);
		MarkDirty(provider.GetDescriptor());
		if (needCal)
		{
			Flush();
		}
		provider.Release();
	}

	private void PushSubValueInternal(PropertySub subType, IPropertyProvider provider)
	{
		List<IPropertyProvider> listForSub = GetListForSub(subType);
		if (listForSub != null)
		{
			listForSub.Add(provider);
			provider.onValueChange += OnProviderChange;
		}
	}

	private void PopSubValueInternal(PropertySub subType, IPropertyProvider provider)
	{
		List<IPropertyProvider> listForSub = GetListForSub(subType);
		if (listForSub != null)
		{
			listForSub.Remove(provider);
			provider.onValueChange -= OnProviderChange;
		}
	}

	private List<IPropertyProvider> GetListForSub(PropertySub sub)
	{
		return sub switch
		{
			PropertySub.Base => m_Base, 
			PropertySub.Add => m_Add, 
			PropertySub.Mul => m_Mul, 
			PropertySub.Max => m_Base, 
			_ => null, 
		};
	}

	public void Cal(bool needInvoke)
	{
		if ((m_Dirty || formula == null) && m_Dirty)
		{
			if (needInvoke)
			{
				Flush();
				return;
			}
			m_Dirty = false;
			PropertyDirtyTracker.Remove(this);
			RecalculateInternal();
		}
	}

	public float CalculateProviderFilter(Func<IPropertyProvider, bool> baseFilter, Func<IPropertyProvider, bool> addFilter, Func<IPropertyProvider, bool> mulFilter)
	{
		if (formula == null)
		{
			return 0f;
		}
		return formula.CalculateFiltered(m_Base, m_Add, m_Mul, baseFilter, addFilter, mulFilter);
	}

	public float CalculateBaseProvider(Func<IPropertyProvider, bool> baseProviderFilter)
	{
		if (formula == null)
		{
			return 0f;
		}
		return formula.CalculateBaseFiltered(m_Base, baseProviderFilter);
	}

	public float GetPropertyCoefficient(GetCoefficientType type)
	{
		if (m_Dirty)
		{
			Flush();
		}
		switch (type)
		{
		case GetCoefficientType.Base:
			return m_BaseValue;
		case GetCoefficientType.Add:
			return m_AddValue;
		case GetCoefficientType.Mul:
			if (originalCalType == PropertyCalculate.SimpleAdd || originalCalType == PropertyCalculate.NonLinearAdd || originalCalType == PropertyCalculate.SimpleMax)
			{
				return 0f;
			}
			return m_MulValue;
		case GetCoefficientType.Total:
			return m_Value;
		default:
			return 0f;
		}
	}

	public bool TryGetNumberProvider(PropertySub subType, PropertySource from, int uid, out NumberPropertyProvider provider)
	{
		List<IPropertyProvider> listForSub = GetListForSub(subType);
		if (listForSub != null)
		{
			return TryGetNumberProvider(listForSub, from, uid, out provider);
		}
		provider = null;
		return false;
	}

	protected bool TryGetNumberProvider(List<IPropertyProvider> list, PropertySource from, int uid, out NumberPropertyProvider provider)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] is NumberPropertyProvider numberPropertyProvider && numberPropertyProvider.from.source == from && numberPropertyProvider.from.uid == uid)
			{
				provider = numberPropertyProvider;
				return true;
			}
		}
		provider = null;
		return false;
	}

	public Property CopyProperty()
	{
		if (m_Dirty)
		{
			Flush();
		}
		return new Property
		{
			formula = formula,
			rounding = rounding,
			originalCalType = originalCalType,
			m_Value = m_Value,
			m_BaseValue = m_BaseValue,
			m_AddValue = m_AddValue,
			m_MulValue = m_MulValue
		};
	}

	public void Reset()
	{
		if (m_Dirty)
		{
			m_Dirty = false;
			PropertyDirtyTracker.Remove(this);
		}
		m_Flushing = false;
		onValueChange.Clear();
		ReleaseList(m_Base);
		ReleaseList(m_Add);
		ReleaseList(m_Mul);
		m_Value = 0f;
		m_BaseValue = 0f;
		m_AddValue = 0f;
		m_MulValue = 0f;
	}

	protected void OnProviderChange(IPropertyProvider provider)
	{
		MarkDirty(provider.GetDescriptor());
	}

	protected void ReleaseList(List<IPropertyProvider> list)
	{
		foreach (IPropertyProvider item in list)
		{
			item.Release();
		}
		list.Clear();
	}

	protected void Rounding()
	{
		m_PracticalValue = m_Value;
		m_Value = rounding switch
		{
			RoundingFunction.Ceiling => Mathf.Ceil(m_Value), 
			RoundingFunction.Floor => Mathf.Floor(m_Value), 
			_ => m_Value, 
		};
		m_Value = Mathf.Ceil((m_Value - 1E-06f) * 10000f) / 10000f;
	}

	protected float CalculatePropertyProvider(List<IPropertyProvider> list)
	{
		float num = 0f;
		foreach (IPropertyProvider item in list)
		{
			if (item is NumberPropertyProvider numberPropertyProvider)
			{
				num += numberPropertyProvider.constValue;
			}
		}
		return num;
	}
}
