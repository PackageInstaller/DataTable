using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;
using UnityEngine;

namespace Unity.VisualScripting.Community.Utility;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Utility.Editor.CustomVariables")]
[IncludeInSettings(true)]
[Inspectable]
public sealed class CustomVariables
{
	[InspectorWide]
	[Inspectable]
	[SerializeField]
	public List<CustomVariable> variables = new List<CustomVariable>();

	public event Action onVariablesChanged = () =>
	{
	};

	public bool Has(string name)
	{
		for (int i = 0; i < variables.Count; i++)
		{
			if (variables[i].name == name)
			{
				return true;
			}
		}
		return false;
	}

	public object Get(string name)
	{
		for (int i = 0; i < variables.Count; i++)
		{
			if (variables[i].name == name)
			{
				return variables[i].value;
			}
		}
		return null;
	}

	public T Get<T>(string name)
	{
		return (T)Get(name);
	}

	public void Set(string name, object value)
	{
		for (int i = 0; i < variables.Count; i++)
		{
			if (variables[i].name == name)
			{
				variables[i].value = value;
				return;
			}
		}
		variables.Add(new CustomVariable
		{
			name = name,
			value = value
		});
		onVariablesChanged();
	}

	public void CopyFrom(CustomVariables other, bool forceValue = false)
	{
		for (int i = 0; i < other.variables.Count; i++)
		{
			string name = other.variables[i].name;
			object obj = other.variables[i].value;
			if (obj != null && obj.GetType().Is().Enumerable())
			{
				obj = ((IEnumerable)obj).ConvertTo(obj.GetType());
			}
			if (!Has(name) | forceValue)
			{
				Set(name, obj);
			}
		}
	}

	public void Clear()
	{
		variables.Clear();
	}
}
