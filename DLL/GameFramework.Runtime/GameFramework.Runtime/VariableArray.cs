using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using UnityEngine;

namespace GameFramework.Runtime;

[Serializable]
public class VariableArray
{
	[SerializeField]
	private List<ViewVariable> variables;

	public ReadOnlyCollection<ViewVariable> Variables => variables.AsReadOnly();

	public ViewVariable this[int index] => variables[index];

	public object Get(string name)
	{
		if (variables == null || variables.Count <= 0)
		{
			return null;
		}
		return variables.Find((ViewVariable v) => v.Name.Equals(name))?.GetValue();
	}

	public T Get<T>(string name)
	{
		if (variables == null || variables.Count <= 0)
		{
			return default(T);
		}
		ViewVariable viewVariable = variables.Find((ViewVariable v) => v.Name.Equals(name));
		if (viewVariable == null)
		{
			return default(T);
		}
		return viewVariable.GetValue<T>();
	}

	public static implicit operator List<ViewVariable>(VariableArray array)
	{
		return array.variables;
	}

	public static implicit operator VariableArray(List<ViewVariable> variables)
	{
		return new VariableArray
		{
			variables = variables
		};
	}
}
