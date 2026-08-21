using System.Collections.Generic;
using Ase;
using Ase.ECS;

public class PropertyInformCenter
{
	private BaseEntity entity;

	private Dictionary<string, PropertyObservable> _propertyObservables = new Dictionary<string, PropertyObservable>();

	private Dictionary<string, string> _propertyInfluence = new Dictionary<string, string>();

	public void Init(BaseEntity entity)
	{
		this.entity = entity;
	}

	public void RegisterPropertyRelation(string property, string influenceProperty)
	{
		if (!_propertyInfluence.ContainsKey(property))
		{
			_propertyInfluence.Add(property, influenceProperty);
		}
	}

	public void RegisterObservable(string propertyKey, PropertyObservable propertyObservable)
	{
		if (!_propertyObservables.ContainsKey(propertyKey))
		{
			_propertyObservables.Add(propertyKey, propertyObservable);
		}
	}

	public void RemoveObservable(string propertyKey)
	{
		if (_propertyObservables.ContainsKey(propertyKey))
		{
			_propertyObservables.Remove(propertyKey);
		}
	}

	public void OnPropertyChanged(string propertyName, float beforeChangedValue, float laterChangedValue, PropertyChangedEnum propertyChangedEnum)
	{
		if (!string.IsNullOrEmpty(propertyName))
		{
			if (_propertyInfluence.TryGetValue(propertyName, out var value))
			{
				_propertyObservables.TryGetValue(value, out var value2);
				value2?.OnInfluencePropertyChanged(beforeChangedValue, laterChangedValue, propertyChangedEnum);
			}
			if (_propertyObservables.TryGetValue(propertyName, out var value3))
			{
				value3?.OnMonitorPropertyChanged(beforeChangedValue, laterChangedValue, propertyChangedEnum);
			}
		}
	}

	public void OnSpecialPropertyChanged(string propertyName, PropertyChangedEnum changedEnum)
	{
		List<string> specialPropertyRelevantOther = BattleFormulaUtility.GetSpecialPropertyRelevantOther(propertyName);
		if (specialPropertyRelevantOther.IsNullOrEmpty() || entity == null)
		{
			return;
		}
		foreach (string item in specialPropertyRelevantOther)
		{
			entity.GetPropertyData(item)?.OnPropertyChanged(changedEnum);
		}
	}

	public void OnDisable()
	{
		foreach (PropertyObservable value in _propertyObservables.Values)
		{
			value.Clear();
		}
		_propertyObservables.Clear();
		_propertyObservables = null;
		_propertyInfluence.Clear();
		_propertyInfluence = null;
		entity = null;
	}
}
