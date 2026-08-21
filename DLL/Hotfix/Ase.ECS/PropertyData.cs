using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase.ECS;

public class PropertyData : ViewModelBase
{
	private List<IPropertyEstimatedChanged> estimatedChangedList;

	private List<IPropertyChangedBefore> changedBeforeList;

	private List<IPropertyChanged> changedList;

	private string _propertyName;

	private bool _minValueLimit;

	private PropertyInformCenter _propertyInformCenter;

	private float _originalMaxValue;

	private bool _rebornIsCanRefresh;

	private float curValue;

	private float buffValue;

	private float initValue;

	private float maxValue;

	private float minValue;

	public float BuffValue => buffValue;

	public float ReadCurValue => curValue;

	public bool MinValueLimit => _minValueLimit;

	public float CurValue
	{
		get
		{
			return Mathf.Clamp(curValue + buffValue, minValue, maxValue);
		}
		private set
		{
			Set(ref curValue, value, "CurValue");
		}
	}

	public float MaxValue
	{
		get
		{
			return maxValue;
		}
		private set
		{
			Set(ref maxValue, value, "MaxValue");
		}
	}

	public float MinValue
	{
		get
		{
			return minValue;
		}
		private set
		{
			Set(ref minValue, value, "MinValue");
		}
	}

	public float InitValue
	{
		get
		{
			return initValue;
		}
		private set
		{
			Set(ref initValue, value, "InitValue");
		}
	}

	public float ScaleValue => Mathf.Clamp01(CurValue / MaxValue);

	public bool RebornIsCanRefresh => _rebornIsCanRefresh;

	public bool IsMax => curValue.FloatEquals(maxValue);

	public bool IsMin => curValue.FloatEquals(minValue);

	public bool IsInit => curValue.FloatEquals(initValue);

	public bool IsHalf => curValue.FloatEquals(maxValue / 2f);

	public string PropertyName => _propertyName;

	public void SetPropertyInformCenter(PropertyInformCenter propertyInformCenter)
	{
		_propertyInformCenter = propertyInformCenter;
	}

	public void SetPropertyName(string propertyName)
	{
		_propertyName = propertyName;
	}

	public static PropertyData Create(float initValue, bool rebornIsCanRefresh = true)
	{
		return new PropertyData
		{
			initValue = initValue,
			CurValue = initValue,
			MinValue = 0f,
			MaxValue = 50000f,
			_originalMaxValue = 50000f,
			_rebornIsCanRefresh = rebornIsCanRefresh
		};
	}

	public static PropertyData Create(float initValue, float maxValue, bool rebornIsCanRefresh = true)
	{
		return new PropertyData
		{
			initValue = initValue,
			CurValue = initValue,
			MinValue = -1f,
			MaxValue = maxValue,
			_originalMaxValue = maxValue,
			_rebornIsCanRefresh = rebornIsCanRefresh
		};
	}

	public static PropertyData Create(float initValue, float minValue, float maxValue, bool rebornIsCanRefresh = true)
	{
		return new PropertyData
		{
			initValue = initValue,
			CurValue = initValue,
			MinValue = minValue,
			MaxValue = maxValue,
			_originalMaxValue = maxValue,
			_rebornIsCanRefresh = rebornIsCanRefresh
		};
	}

	public static PropertyData Create(float initValue, float minValue, float maxValue, bool minValueLimit, bool rebornIsCanRefresh = true)
	{
		return new PropertyData
		{
			initValue = initValue,
			CurValue = initValue,
			MinValue = minValue,
			MaxValue = maxValue,
			_originalMaxValue = maxValue,
			_rebornIsCanRefresh = rebornIsCanRefresh,
			_minValueLimit = minValueLimit
		};
	}

	public float Addition(float addition, bool isIgnoreMax, bool isExecuteValueChanged = true, bool isIgnoreMin = false)
	{
		if (_minValueLimit && !isIgnoreMin && addition < 0f)
		{
			if (CurValue < 0f)
			{
				addition = 0f;
			}
			else if (addition + CurValue < 0f)
			{
				addition = 0f - CurValue;
			}
		}
		float num = CurValue;
		float beforeChangedValue = MaxValue;
		if (isIgnoreMax)
		{
			OnPropertyChangedBefore(PropertyChangedEnum.MaxValue, addition);
			maxValue += addition;
			addition = Mathf.Clamp(curValue + addition, minValue, maxValue);
			OnPropertyChangedBefore(PropertyChangedEnum.CurValue, addition);
			CurValue = addition;
			OnPropertyChanged(num, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
			OnPropertyChanged(beforeChangedValue, MaxValue, PropertyChangedEnum.MaxValue, isExecuteValueChanged);
			return CurValue;
		}
		OnPropertyEstimatedChanged(PropertyChangedEnum.CurValue, addition);
		addition = Mathf.Clamp(curValue + addition, minValue, maxValue);
		OnPropertyChangedBefore(PropertyChangedEnum.CurValue, addition - num);
		CurValue = addition;
		OnPropertyChanged(num, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
		return CurValue;
	}

	public float AdditionBuff(float addition, bool isIgnoreMax, bool isExecuteValueChanged = true)
	{
		float beforeChangedValue = CurValue;
		float beforeChangedValue2 = MaxValue;
		if (isIgnoreMax)
		{
			OnPropertyChangedBefore(PropertyChangedEnum.CurValue, addition);
			OnPropertyChangedBefore(PropertyChangedEnum.MaxValue, addition);
			maxValue += addition;
			buffValue += addition;
			Set(ref buffValue, buffValue + addition, "AdditionBuff");
			OnPropertyChanged(beforeChangedValue, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
			OnPropertyChanged(beforeChangedValue2, MaxValue, PropertyChangedEnum.MaxValue, isExecuteValueChanged);
			return CurValue;
		}
		OnPropertyEstimatedChanged(PropertyChangedEnum.CurValue, addition);
		beforeChangedValue = buffValue;
		float detla = buffValue + addition - beforeChangedValue;
		OnPropertyChangedBefore(PropertyChangedEnum.BuffValue, detla);
		Set(ref buffValue, buffValue + addition, "AdditionBuff");
		OnPropertyChanged(beforeChangedValue, buffValue, PropertyChangedEnum.BuffValue, isExecuteValueChanged);
		return CurValue;
	}

	public float Merge(float value, bool isIgnoreMax, bool isResetInitValue)
	{
		_ = curValue;
		CurValue += value;
		if (isIgnoreMax && maxValue < curValue)
		{
			MaxValue = curValue;
		}
		if (isResetInitValue)
		{
			InitValue = CurValue;
		}
		return CurValue;
	}

	public void ResetUnification(float value)
	{
		initValue = value;
		maxValue = value;
		CurValue = value;
	}

	public void Reset(float initValue, float minValue, float maxValue)
	{
		InitValue = initValue;
		MinValue = minValue;
		MaxValue = maxValue;
	}

	public void Set(float value, bool isIgnoreMax = false, bool isExecuteValueChanged = true)
	{
		float num = CurValue;
		float num2 = MaxValue;
		if (isIgnoreMax)
		{
			OnPropertyChangedBefore(PropertyChangedEnum.MaxValue, value - num2);
			OnPropertyChangedBefore(PropertyChangedEnum.CurValue, value - num);
			MaxValue = value;
			OnPropertyChanged(num2, MaxValue, PropertyChangedEnum.MaxValue, isExecuteValueChanged);
			CurValue = value;
			OnPropertyChanged(num, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
		}
		else
		{
			OnPropertyEstimatedChanged(PropertyChangedEnum.CurValue, value - num);
			value = Mathf.Clamp(value, minValue, maxValue);
			OnPropertyChangedBefore(PropertyChangedEnum.CurValue, value - num);
			CurValue = value;
			OnPropertyChanged(num, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
		}
	}

	public void SetBuff(float value, bool isIgnoreMax = false, bool isExecuteValueChanged = true)
	{
		if (isIgnoreMax)
		{
			OnPropertyChangedBefore(PropertyChangedEnum.MaxValue, value - MaxValue);
			MaxValue = value;
		}
		OnPropertyChangedBefore(PropertyChangedEnum.BuffValue, value - buffValue);
		float beforeChangedValue = buffValue;
		buffValue = value;
		OnPropertyChanged(beforeChangedValue, buffValue, PropertyChangedEnum.BuffValue, isExecuteValueChanged);
	}

	public void Set(float value, float max, bool isExecuteValueChanged = true)
	{
		float num = CurValue;
		float num2 = MaxValue;
		OnPropertyChangedBefore(PropertyChangedEnum.MaxValue, value - num2);
		MaxValue = max;
		OnPropertyChanged(num2, MaxValue, PropertyChangedEnum.MaxValue, isExecuteValueChanged);
		OnPropertyEstimatedChanged(PropertyChangedEnum.CurValue, value);
		value = Mathf.Clamp(value, minValue, maxValue);
		OnPropertyChangedBefore(PropertyChangedEnum.CurValue, value - num);
		CurValue = value;
		OnPropertyChanged(num, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
	}

	public void ResetValue(bool toMax, bool isExecuteValueChanged = true)
	{
		float num = CurValue;
		if (toMax)
		{
			OnPropertyChangedBefore(PropertyChangedEnum.CurValue, maxValue - num);
			CurValue = maxValue;
		}
		else
		{
			OnPropertyChangedBefore(PropertyChangedEnum.CurValue, initValue - num);
			CurValue = initValue;
		}
		OnPropertyChanged(num, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
	}

	public void RebornResetValue(bool toMax, bool isExecuteValueChanged = true)
	{
		if (RebornIsCanRefresh)
		{
			float num = CurValue;
			if (toMax)
			{
				OnPropertyChangedBefore(PropertyChangedEnum.CurValue, maxValue - num);
				CurValue = MaxValue;
			}
			else
			{
				OnPropertyChangedBefore(PropertyChangedEnum.CurValue, initValue - num);
				CurValue = initValue;
			}
			OnPropertyChanged(num, CurValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
		}
	}

	public void ResetMax(float value, bool isExecuteValueChanged = true)
	{
		float num = CurValue;
		float num2 = MaxValue;
		OnPropertyChangedBefore(PropertyChangedEnum.MaxValue, value - num2);
		MaxValue = value;
		OnPropertyChanged(num2, MaxValue, PropertyChangedEnum.MaxValue, isExecuteValueChanged);
		float laterChangedValue = CurValue;
		OnPropertyChangedBefore(PropertyChangedEnum.CurValue, value - num);
		CurValue = laterChangedValue;
		OnPropertyChanged(num, laterChangedValue, PropertyChangedEnum.CurValue, isExecuteValueChanged);
	}

	public void ResetMin(float value, bool isExecuteValueChanged = true)
	{
		float num = minValue;
		OnPropertyChangedBefore(PropertyChangedEnum.MinValue, value - num);
		minValue = value;
		OnPropertyChanged(num, minValue, PropertyChangedEnum.MinValue, isExecuteValueChanged);
	}

	public void ResetMax2Original(bool isExecuteValueChanged = true)
	{
		float beforeChangedValue = MaxValue;
		MaxValue = _originalMaxValue;
		OnPropertyChanged(beforeChangedValue, MaxValue, PropertyChangedEnum.MaxValue, isExecuteValueChanged);
	}

	public void SetPropertyRefreshState(bool rebornIsCanRefresh)
	{
		_rebornIsCanRefresh = rebornIsCanRefresh;
	}

	public void ResetInit(float value)
	{
		InitValue = value;
	}

	public void OnPropertyChanged(PropertyChangedEnum changedEnum)
	{
		OnPropertyChangedNotify(changedEnum, 0f);
	}

	private void OnPropertyChanged(float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum, bool isExecuteValueChanged)
	{
		OnPropertyChangedNotify(propertyChangedEnum, laterChangedValue - beforeChangedValue);
		if (_propertyInformCenter != null)
		{
			_propertyInformCenter.OnSpecialPropertyChanged(_propertyName, propertyChangedEnum);
			if (isExecuteValueChanged)
			{
				_propertyInformCenter.OnPropertyChanged(_propertyName, beforeChangedValue, laterChangedValue, propertyChangedEnum);
			}
		}
	}

	private void OnPropertyEstimatedChanged(PropertyChangedEnum changedEnum, float detla)
	{
		if (estimatedChangedList == null)
		{
			return;
		}
		foreach (IPropertyEstimatedChanged estimatedChanged in estimatedChangedList)
		{
			estimatedChanged.OnPropertyEstimatedChanged(_propertyName, changedEnum, detla);
		}
	}

	private void OnPropertyChangedBefore(PropertyChangedEnum changedEnum, float detla)
	{
		if (changedBeforeList == null)
		{
			return;
		}
		foreach (IPropertyChangedBefore changedBefore in changedBeforeList)
		{
			changedBefore.OnPropertyChangedBefore(_propertyName, changedEnum, detla);
		}
	}

	private void OnPropertyChangedNotify(PropertyChangedEnum changedEnum, float detla)
	{
		if (changedList == null)
		{
			return;
		}
		foreach (IPropertyChanged changed in changedList)
		{
			changed.OnPropertyChanged(_propertyName, changedEnum, detla);
		}
	}

	public void RegisterOnEstimatedChangedCallback(IPropertyEstimatedChanged changed)
	{
		if (estimatedChangedList == null)
		{
			estimatedChangedList = new List<IPropertyEstimatedChanged>();
			estimatedChangedList.Add(changed);
		}
		else if (!estimatedChangedList.Contains(changed))
		{
			estimatedChangedList.Add(changed);
		}
	}

	public void RemoveOnEstimatedChangedCallback(IPropertyEstimatedChanged changed)
	{
		if (estimatedChangedList != null && estimatedChangedList.Contains(changed))
		{
			estimatedChangedList.Remove(changed);
		}
	}

	public void RegisterOnChangedBeforeCallback(IPropertyChangedBefore changed)
	{
		if (changedBeforeList == null)
		{
			changedBeforeList = new List<IPropertyChangedBefore>();
			changedBeforeList.Add(changed);
		}
		else if (!changedBeforeList.Contains(changed))
		{
			changedBeforeList.Add(changed);
		}
	}

	public void RemoveOnChangedBeforeCallback(IPropertyChangedBefore changed)
	{
		if (changedBeforeList != null && changedBeforeList.Contains(changed))
		{
			changedBeforeList.Remove(changed);
		}
	}

	public void RegisterOnChangedCallback(IPropertyChanged changed)
	{
		if (changedList == null)
		{
			changedList = new List<IPropertyChanged>();
			changedList.Add(changed);
		}
		else if (!changedList.Contains(changed))
		{
			changedList.Add(changed);
		}
	}

	public void RemoveOnChangedCallback(IPropertyChanged changed)
	{
		if (changedList != null && changedList.Contains(changed))
		{
			changedList.Remove(changed);
		}
	}

	public override string ToString()
	{
		return $"属性名:{PropertyName} 初始值:{InitValue} 当前值:{CurValue} Buff值:{BuffValue} 最小值:{MinValue} 最大值:{MaxValue}";
	}

	public void Clear()
	{
		_propertyInformCenter = null;
	}

	public PropertyData Clone(float ratio = 1f)
	{
		return new PropertyData
		{
			_propertyName = _propertyName,
			_originalMaxValue = _originalMaxValue,
			_rebornIsCanRefresh = _rebornIsCanRefresh,
			curValue = curValue * ratio,
			buffValue = buffValue,
			initValue = initValue * ratio,
			maxValue = maxValue,
			minValue = minValue
		};
	}
}
