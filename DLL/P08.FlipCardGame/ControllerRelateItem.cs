using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class ControllerRelateItem
{
	[SerializeField]
	public GameObject go;

	[SerializeField]
	public ControllerProperty property;

	[SerializeField]
	public List<string> stateValues;

	[SerializeField]
	public List<NewControllerValue> controllerValues;

	private string _key;

	public ControllerRelateItem(GameObject go, ControllerProperty property, string key, List<string> stateValues, Component target)
	{
		this.go = go;
		this.property = property;
		_key = key;
		this.stateValues = stateValues;
		controllerValues = new List<NewControllerValue>(stateValues.Count);
		for (int i = 0; i < stateValues.Count; i++)
		{
			controllerValues.Add(null);
		}
		InitWithValue(target);
	}

	public void AddOrUpdateNewValue(string state, Component target)
	{
		int num = stateValues.IndexOf(state);
		if (num >= 0)
		{
			if (controllerValues[num] != null)
			{
				controllerValues[num].CopyFromComponent(target);
			}
			else
			{
				controllerValues[num] = NewControllerValue.CreateFromComponent(property, target);
			}
		}
	}

	public NewControllerValue GetNewValue(string state)
	{
		int num = stateValues.IndexOf(state);
		if (num >= 0)
		{
			return controllerValues[num];
		}
		return null;
	}

	private void InitWithValue(Component target)
	{
		for (int i = 0; i < controllerValues.Count; i++)
		{
			controllerValues[i] = NewControllerValue.CreateFromComponent(property, target);
		}
	}

	public ControllerCompareData IsEqualNew(string state)
	{
		Type typeByProperty = Controller.GetTypeByProperty(property);
		Component component = go.GetComponent(typeByProperty);
		return GetNewValue(state).IsEqual(property, component);
	}

	public void ConvertToNewVersion()
	{
	}

	public string PropertyKey()
	{
		return $"{property.ToString()}___{controllerValues[0].flag}";
	}

	public void StopTween()
	{
		for (int i = 0; i < controllerValues.Count; i++)
		{
			controllerValues[i].StopTween(go);
		}
	}

	public string GetKey()
	{
		return _key;
	}

	public bool IsOld()
	{
		return false;
	}
}
