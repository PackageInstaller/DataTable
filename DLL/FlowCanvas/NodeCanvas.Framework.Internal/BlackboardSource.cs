using System;
using System.Collections.Generic;
using System.Linq;
using ParadoxNotion;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[Serializable]
public sealed class BlackboardSource : IBlackboard
{
	[SerializeField]
	private string _name;

	[SerializeField]
	private Dictionary<string, Variable> _variables = new Dictionary<string, Variable>(StringComparer.Ordinal);

	public string name
	{
		get
		{
			return _name;
		}
		set
		{
			_name = value;
		}
	}

	public Dictionary<string, Variable> variables
	{
		get
		{
			return _variables;
		}
		set
		{
			_variables = value;
		}
	}

	public GameObject propertiesBindTarget => null;

	public object this[string varName]
	{
		get
		{
			try
			{
				return variables[varName].value;
			}
			catch
			{
				return null;
			}
		}
		set
		{
			SetValue(varName, value);
		}
	}

	public event Action<Variable> onVariableAdded;

	public event Action<Variable> onVariableRemoved;

	public void InitializePropertiesBinding(GameObject targetGO, bool callSetter)
	{
		foreach (Variable value in variables.Values)
		{
			value.InitializePropertyBinding(targetGO, callSetter);
		}
	}

	public Variable AddVariable(string varName, object value)
	{
		if (value == null)
		{
			Debug.LogError("<b>Blackboard:</b> You can't use AddVariable with a null value. Use AddVariable(string, Type) to add the new data first");
			return null;
		}
		Variable variable = AddVariable(varName, value.GetType());
		if (variable != null)
		{
			variable.value = value;
		}
		return variable;
	}

	public Variable AddVariable(string varName, Type type)
	{
		if (variables.ContainsKey(varName))
		{
			Variable variable = GetVariable(varName, type);
			if (variable == null)
			{
				Debug.LogError($"<b>Blackboard:</b> Variable with name '{varName}' already exists in blackboard '{name}', but is of different type! Returning null instead of new.");
			}
			return variable;
		}
		Variable variable2 = (Variable)Activator.CreateInstance(typeof(Variable<>).RTMakeGenericType(type));
		variable2.name = varName;
		variables[varName] = variable2;
		if (onVariableAdded != null)
		{
			onVariableAdded(variable2);
		}
		return variable2;
	}

	public Variable AddVariable(string varName, Type type, bool fullType)
	{
		if (variables.ContainsKey(varName))
		{
			Variable variable = GetVariable(varName, type);
			if (variable == null)
			{
				Debug.LogError($"<b>Blackboard:</b> Variable with name '{varName}' already exists in blackboard '{name}', but is of different type! Returning null instead of new.");
			}
			return variable;
		}
		Variable variable2 = null;
		variable2 = ((!fullType) ? ((Variable)Activator.CreateInstance(typeof(Variable<>).RTMakeGenericType(type))) : ((Variable)Activator.CreateInstance(type)));
		variable2.name = varName;
		variables[varName] = variable2;
		if (onVariableAdded != null)
		{
			onVariableAdded(variable2);
		}
		return variable2;
	}

	public Variable RemoveVariable(string varName)
	{
		Variable value = null;
		if (variables.TryGetValue(varName, out value))
		{
			variables.Remove(varName);
			if (onVariableRemoved != null)
			{
				onVariableRemoved(value);
			}
		}
		return value;
	}

	public T GetValue<T>(string varName)
	{
		if (variables.TryGetValue(varName, out var value) && value != null)
		{
			if (value is Variable<T>)
			{
				return (variables[varName] as Variable<T>).value;
			}
			T val = (T)variables[varName].value;
			if (val != null)
			{
				return val;
			}
		}
		return default(T);
	}

	public Variable SetValue(string varName, object value)
	{
		try
		{
			Variable variable = variables[varName];
			variable.value = value;
			return variable;
		}
		catch
		{
			if (!variables.ContainsKey(varName))
			{
				Debug.Log(string.Format("<b>Blackboard:</b> No Variable of name '{0}' and type '{1}' exists on Blackboard '{2}'. Adding new instead...", varName, (value != null) ? value.GetType().FriendlyName() : "null", name));
				Variable variable2 = AddVariable(varName, value);
				variable2.isProtected = true;
				return variable2;
			}
		}
		Debug.LogError(string.Format("<b>Blackboard:</b> Can't cast value '{0}' to blackboard variable of name '{1}' and type '{2}'", (value != null) ? value.ToString() : "null", varName, variables[varName].varType.Name));
		return null;
	}

	public Variable GetVariable(string varName, Type ofType = null)
	{
		if (variables != null && varName != null && variables.TryGetValue(varName, out var value) && (ofType == null || value.CanConvertTo(ofType)))
		{
			return value;
		}
		return null;
	}

	public Variable GetVariableByID(string ID)
	{
		if (variables != null && ID != null)
		{
			foreach (KeyValuePair<string, Variable> variable in variables)
			{
				if (variable.Value.ID == ID)
				{
					return variable.Value;
				}
			}
		}
		return null;
	}

	public Variable<T> GetVariable<T>(string varName)
	{
		return (Variable<T>)GetVariable(varName, typeof(T));
	}

	public string[] GetVariableNames()
	{
		return variables.Keys.ToArray();
	}

	public string[] GetVariableNames(Type ofType)
	{
		return (from v in variables.Values
			where v.CanConvertTo(ofType)
			select v.name).ToArray();
	}

	public Variable<T> AddVariable<T>(string varName, T value)
	{
		Variable<T> variable = AddVariable<T>(varName);
		variable.value = value;
		return variable;
	}

	public Variable<T> AddVariable<T>(string varName)
	{
		return (Variable<T>)AddVariable(varName, typeof(T));
	}
}
