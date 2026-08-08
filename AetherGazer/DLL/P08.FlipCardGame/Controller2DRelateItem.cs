using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class Controller2DRelateItem
{
	[SerializeField]
	public GameObject go;

	[SerializeField]
	public Controller2DProperty property;

	[SerializeField]
	public List<string> stateValues;

	[SerializeField]
	public List<Controller2DValue> values;

	private string _key;

	public Controller2DRelateItem(GameObject go, Controller2DProperty property, string key, List<string> stateValues, Component target)
	{
		this.go = go;
		this.property = property;
		_key = key;
		this.stateValues = stateValues;
		values = new List<Controller2DValue>(stateValues.Count);
		for (int i = 0; i < stateValues.Count; i++)
		{
			values.Add(null);
		}
		InitWithValue(target);
	}

	public void AddOrUpdateValue(string state, Component target)
	{
		int num = stateValues.IndexOf(state);
		if (num >= 0)
		{
			if (values[num] != null)
			{
				values[num].CopyFromComponent(property, target);
			}
			else
			{
				values[num] = Controller2DValue.CreateFromComponent(property, target);
			}
		}
	}

	public Controller2DValue GetValue(string state)
	{
		int num = stateValues.IndexOf(state);
		if (num >= 0)
		{
			return values[num];
		}
		return null;
	}

	private void InitWithValue(Component target)
	{
		for (int i = 0; i < values.Count; i++)
		{
			values[i] = Controller2DValue.CreateFromComponent(property, target);
		}
	}

	public Controller2DCompareData IsEqual(string state)
	{
		Type typeByProperty = Controller2D.GetTypeByProperty(property);
		Component component = go.GetComponent(typeByProperty);
		return GetValue(state).IsEqual(property, component);
	}

	public string GetKey()
	{
		return _key;
	}
}
