using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase.ECS;

public class EntityViewModel : ViewModelBase
{
	protected readonly ObservableList<BuffItemViewModel> buffList;

	protected readonly ObservableList<AbnormalStateViewModel> abnormalStateList;

	protected readonly ObservableDictionary<string, PropertyData> propertyList;

	protected readonly ObservableDictionary<string, float> propertyLightDic;

	protected PropertyInformCenter PropertyInformCenter;

	protected BaseEntity entity;

	protected int level;

	private float recuseRotation;

	private bool isOffLine;

	private bool openAutoFight;

	private bool beingRescued;

	public ObservableDictionary<string, PropertyData> Property => propertyList;

	public ObservableDictionary<string, float> PropertyLight => propertyLightDic;

	public BaseEntity Entity => entity;

	public float RecuseRotation
	{
		get
		{
			return recuseRotation;
		}
		set
		{
			Set(ref recuseRotation, value, "RecuseRotation");
		}
	}

	public bool IsOffLine
	{
		get
		{
			return isOffLine;
		}
		set
		{
			Set(ref isOffLine, value, "IsOffLine");
		}
	}

	public bool OpenAutoFight
	{
		get
		{
			return openAutoFight;
		}
		set
		{
			Set(ref openAutoFight, value, "OpenAutoFight");
		}
	}

	public bool BeingRescued
	{
		get
		{
			return beingRescued;
		}
		set
		{
			Set(ref beingRescued, value, "BeingRescued");
		}
	}

	public ObservableList<BuffItemViewModel> BuffList => buffList;

	public ObservableList<AbnormalStateViewModel> AbnormalStateList => abnormalStateList;

	protected EntityViewModel()
	{
		propertyList = new ObservableDictionary<string, PropertyData>();
		buffList = new ObservableList<BuffItemViewModel>();
		propertyLightDic = new ObservableDictionary<string, float>();
		abnormalStateList = new ObservableList<AbnormalStateViewModel>();
	}

	public static EntityViewModel Empty()
	{
		EntityViewModel entityViewModel = new EntityViewModel();
		entityViewModel.InitEmptyProperty();
		return entityViewModel;
	}

	protected virtual void OnStart()
	{
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		entity = null;
		foreach (BuffItemViewModel buff in buffList)
		{
			buff?.Dispose();
		}
		buffList.Clear();
		abnormalStateList.Clear();
		IEnumerator<KeyValuePair<string, PropertyData>> enumerator2 = propertyList.GetEnumerator();
		while (enumerator2.MoveNext())
		{
			enumerator2.Current.Value.Clear();
			enumerator2.Current.Value.Dispose();
		}
		propertyList.Clear();
		enumerator2.Dispose();
		propertyLightDic.Clear();
		PropertyInformCenter.OnDisable();
		PropertyInformCenter = null;
	}

	public virtual string GetBattleHeadIcon()
	{
		return string.Empty;
	}

	public virtual string GetName()
	{
		return string.Empty;
	}

	public virtual string GetOccupation()
	{
		return string.Empty;
	}

	public virtual int GetLevel()
	{
		return level;
	}

	protected virtual void InitEmptyPropertyAfter()
	{
	}

	protected virtual void RegisterPropertyChangedAction()
	{
	}

	public void InitProperty()
	{
		PropertyInformCenter = new PropertyInformCenter();
		InitEmptyProperty();
		InitEmptyPropertyAfter();
		RegisterPropertyChangedAction();
		CalcPropertyLight();
	}

	public void StartProperty()
	{
		OnStart();
	}

	protected virtual void CalcPropertyLight()
	{
	}

	public virtual float GetPropertyLight(string propertyKey)
	{
		if (propertyLightDic != null)
		{
			propertyLightDic.TryGetValue(propertyKey, out var value);
			return value;
		}
		return 0f;
	}

	protected virtual void InitEmptyProperty()
	{
		propertyList.Add("Hp", PropertyData.Create(1f, 1f));
		propertyList.Add("Hp", PropertyData.Create(1f, 1f));
		propertyList.Add("Tenacity", PropertyData.Create(1f, 1f));
		propertyList.Add("Attack", PropertyData.Create(0f));
		propertyList.Add("Defence", PropertyData.Create(0f));
		propertyList.Add("Level", PropertyData.Create(0f));
		propertyList.Add("Crit", PropertyData.Create(0f));
		propertyList.Add("CritRadio", PropertyData.Create(0f));
		propertyList.Add("Shield", PropertyData.Create(0f));
		propertyList.Add("StateTime", PropertyData.Create(0f, 0f));
	}

	public bool HasProperty(string propertyKey)
	{
		return propertyList.ContainsKey(propertyKey);
	}

	public PropertyData GetPropertyData(string key)
	{
		if (string.IsNullOrEmpty(key))
		{
			return null;
		}
		if (propertyList == null)
		{
			return null;
		}
		propertyList.TryGetValue(key, out var value);
		return value;
	}

	public PropertyData GetPropertyDataOrCreate(string key)
	{
		if (string.IsNullOrEmpty(key))
		{
			return null;
		}
		if (propertyList == null)
		{
			return null;
		}
		if (!propertyList.TryGetValue(key, out var value))
		{
			value = PropertyData.Create(0f);
			value.SetPropertyName(key);
			propertyList.Add(key, value);
		}
		return value;
	}

	public float MergeProperty(string key, float value, bool isIgnoreMax, bool isResetInitData)
	{
		propertyList.TryGetValue(key, out var value2);
		return value2?.Merge(value, isIgnoreMax, isResetInitData) ?? 0f;
	}

	public float AdditionProperty(string key, float value, bool isIgnoreMax = false, bool isExecuteValueChanged = true, bool isIgnoreMin = false)
	{
		propertyList.TryGetValue(key, out var value2);
		return value2?.Addition(value, isIgnoreMax, isExecuteValueChanged, isIgnoreMin) ?? 0f;
	}

	public float AdditionPropertyBuff(string key, float value, bool isIgnoreMax = false, bool isExecuteValueChanged = true)
	{
		propertyList.TryGetValue(key, out var value2);
		return value2?.AdditionBuff(value, isIgnoreMax, isExecuteValueChanged) ?? 0f;
	}

	public void Set(string key, float value, bool isIgnoreMax = false, bool isExecuteValueChanged = true)
	{
		if (propertyList.TryGetValue(key, out var value2))
		{
			value2.Set(value, isIgnoreMax, isExecuteValueChanged);
			return;
		}
		value2 = PropertyData.Create(value);
		propertyList.Add(key, value2);
		value2.Set(value, isIgnoreMax, isExecuteValueChanged);
	}

	public void SetBuff(string key, float value, bool isIgnoreMax = false, bool isExecuteValueChanged = true)
	{
		if (propertyList.TryGetValue(key, out var value2))
		{
			value2.SetBuff(value, isIgnoreMax, isExecuteValueChanged);
			return;
		}
		value2 = PropertyData.Create(value);
		propertyList.Add(key, value2);
		value2.SetBuff(value, isIgnoreMax, isExecuteValueChanged);
	}

	public void SetInit(string key, float value)
	{
		if (propertyList.ContainsKey(key))
		{
			propertyList[key].ResetInit(value);
		}
	}

	public void Set(string key, float initValue, float maxValue, bool isExecuteValueChanged = true)
	{
		if (propertyList.ContainsKey(key))
		{
			propertyList[key].Set(initValue, maxValue, isExecuteValueChanged);
		}
		else
		{
			propertyList.Add(key, PropertyData.Create(initValue, maxValue));
		}
	}

	public void Set(PropertyAdditionData addition)
	{
		if (!propertyList.TryGetValue(addition.propertyKey, out var value))
		{
			value = PropertyData.Create(addition.value);
			propertyList.Add(addition.propertyKey, value);
		}
		float num = value.CurValue;
		switch (addition.propertyType)
		{
		case PropertyType.Min:
			num = value.MinValue;
			break;
		case PropertyType.Max:
			num = value.MaxValue;
			break;
		case PropertyType.Init:
			num = value.InitValue;
			break;
		}
		float num2 = addition.value;
		switch (addition.valueType)
		{
		case NumericalValueType.Percentage:
			num2 *= num;
			break;
		}
		switch (addition.operation)
		{
		case ChangeType.Set:
			value.Set(num2);
			break;
		case ChangeType.Add:
			value.Addition(num2, addition.ignoreMax);
			break;
		case ChangeType.Dec:
			value.Addition(0f - num2, addition.ignoreMax);
			break;
		case ChangeType.Mul:
		case ChangeType.Div:
		case ChangeType.Clear:
		case ChangeType.Reset:
			break;
		}
	}

	public void ResetProperty(string propertyKey, bool toMax, bool isExecuteValueChanged = true)
	{
		if (propertyList.ContainsKey(propertyKey))
		{
			propertyList[propertyKey].ResetValue(toMax, isExecuteValueChanged);
		}
	}

	public void ResetMax(string key, float maxValue, bool isExecuteValueChanged = true)
	{
		if (propertyList.ContainsKey(key))
		{
			propertyList[key].ResetMax(maxValue, isExecuteValueChanged);
		}
	}

	public void ResetMin(string key, float minValue, bool isExecuteValueChanged = true)
	{
		if (propertyList.ContainsKey(key))
		{
			propertyList[key].ResetMin(minValue, isExecuteValueChanged);
		}
	}

	public void ResetMax2Original(string key, bool isExecuteValueChanged = true)
	{
		if (propertyList.ContainsKey(key))
		{
			propertyList[key].ResetMax2Original(isExecuteValueChanged);
		}
	}

	public void RebornResetAll()
	{
		IEnumerator<KeyValuePair<string, PropertyData>> enumerator = propertyList.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.RebornResetValue(toMax: false, isExecuteValueChanged: false);
		}
		enumerator.Dispose();
	}

	private BuffItemViewModel FindBuffVM(Buff buff)
	{
		for (int i = 0; i < buffList.Count; i++)
		{
			if (buffList[i].Buff == buff)
			{
				return buffList[i];
			}
		}
		return null;
	}

	public void AddBuff(Buff buff)
	{
		buffList.Insert(0, new BuffItemViewModel(buff));
	}

	public void ReplaceBuff(Buff buff, int index)
	{
		buffList[index] = new BuffItemViewModel(buff);
	}

	public void UpdateBuff(Buff buff)
	{
		FindBuffVM(buff)?.Update();
	}

	public void RemoveBuff(Buff buff)
	{
		BuffItemViewModel buffItemViewModel = FindBuffVM(buff);
		if (buffItemViewModel != null)
		{
			buffItemViewModel.SetNoActive();
			buffList.Remove(buffItemViewModel);
			buffItemViewModel.Dispose();
		}
	}

	public int GetBuffIndex(Buff buff)
	{
		for (int i = 0; i < buffList.Count; i++)
		{
			if (buffList[i].Buff == buff)
			{
				return i;
			}
		}
		return -1;
	}

	public void AddAbnormalState(AbnormalState state)
	{
		if (!string.IsNullOrEmpty(state.Config.AbnormalIcon))
		{
			abnormalStateList.Add(new AbnormalStateViewModel(state));
		}
	}

	public void AbnormalStateRecudeRemoveTime(AbnormalState state)
	{
		foreach (AbnormalStateViewModel abnormalState in abnormalStateList)
		{
			if (abnormalState.AbnormalState == state)
			{
				abnormalState.RecudeRemoveTime();
			}
		}
	}

	public void AbnormalStateRemoveTimeChanged(AbnormalState state)
	{
		foreach (AbnormalStateViewModel abnormalState in abnormalStateList)
		{
			if (abnormalState.AbnormalState == state)
			{
				abnormalState.RemoveTimeChanged(abnormalState.AbnormalState.CoolingTime);
			}
		}
	}

	public void RemoveAbnormalState(AbnormalState state)
	{
		for (int i = 0; i < abnormalStateList.Count; i++)
		{
			if (abnormalStateList[i].AbnormalState == state)
			{
				abnormalStateList.RemoveAt(i);
				break;
			}
		}
	}

	public void UpdateAbnormalState(float deltaTime)
	{
		for (int i = 0; i < abnormalStateList.Count; i++)
		{
			abnormalStateList[i].Update(deltaTime);
		}
	}
}
