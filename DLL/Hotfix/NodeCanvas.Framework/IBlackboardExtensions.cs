using System;
using System.Collections.Generic;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Framework;

[SpoofAOT]
[Preserve]
public static class IBlackboardExtensions
{
	public static IBlackboard GetRoot(this IBlackboard blackboard)
	{
		if (blackboard.parent == null)
		{
			return blackboard;
		}
		return blackboard.parent.GetRoot();
	}

	public static IEnumerable<IBlackboard> GetAllParents(this IBlackboard blackboard, bool includeSelf)
	{
		if (blackboard != null)
		{
			if (includeSelf)
			{
				yield return blackboard;
			}
			for (IBlackboard current = blackboard.parent; current != null; current = current.parent)
			{
				yield return current;
			}
		}
	}

	public static bool IsPartOf(this IBlackboard blackboard, IBlackboard child)
	{
		if (blackboard == null || child == null)
		{
			return false;
		}
		if (blackboard == child)
		{
			return true;
		}
		return blackboard.IsPartOf(child.parent);
	}

	public static Variable<T> AddVariable<T>(this IBlackboard blackboard, string varName, T value)
	{
		Variable<T> variable = blackboard.AddVariable<T>(varName);
		variable.value = value;
		return variable;
	}

	public static Variable<T> AddVariable<T>(this IBlackboard blackboard, string varName)
	{
		return (Variable<T>)blackboard.AddVariable(varName, typeof(T));
	}

	public static Variable AddVariable(this IBlackboard blackboard, string varName, object value)
	{
		if (value == null)
		{
			return null;
		}
		Variable variable = blackboard.AddVariable(varName, value.GetType());
		if (variable != null)
		{
			variable.value = value;
		}
		return variable;
	}

	public static Variable AddVariable(this IBlackboard blackboard, string varName, Type type)
	{
		if (blackboard.variables.TryGetValue(varName, out var value))
		{
			if (value.CanConvertTo(type))
			{
				return value;
			}
			return null;
		}
		Variable variable = (Variable)Activator.CreateInstance(typeof(Variable<>).RTMakeGenericType(type));
		variable.name = varName;
		blackboard.variables[varName] = variable;
		blackboard.TryInvokeOnVariableAdded(variable);
		return variable;
	}

	public static Variable AddVariable<T>(this IBlackboard blackboard, string varName, object value)
	{
		if (value == null)
		{
			return null;
		}
		Variable variable = blackboard.AddVariable(varName, typeof(T));
		if (variable != null)
		{
			variable.value = value;
		}
		return variable;
	}

	public static Variable RemoveVariable(this IBlackboard blackboard, string varName)
	{
		Variable value = null;
		if (blackboard.variables.TryGetValue(varName, out value))
		{
			blackboard.variables.Remove(varName);
			blackboard.TryInvokeOnVariableRemoved(value);
			value.OnDestroy();
		}
		return value;
	}

	public static T GetVariableValue<T>(this IBlackboard blackboard, string varName)
	{
		Variable<T> variable = blackboard.GetVariable<T>(varName);
		if (variable == null)
		{
			return default(T);
		}
		if (variable != null)
		{
			return variable.value;
		}
		try
		{
			return variable.value;
		}
		catch
		{
		}
		return default(T);
	}

	public static Variable SetVariableValue(this IBlackboard blackboard, string varName, object value)
	{
		if (!blackboard.variables.TryGetValue(varName, out var value2))
		{
			return blackboard.AddVariable(varName, value);
		}
		try
		{
			value2.value = value;
			return value2;
		}
		catch
		{
			return null;
		}
	}

	public static Variable SetVariableValue<T>(this IBlackboard blackboard, string varName, object value)
	{
		if (!blackboard.variables.TryGetValue(varName, out var value2))
		{
			return blackboard.AddVariable<T>(varName, value);
		}
		try
		{
			value2.value = value;
			return value2;
		}
		catch
		{
			return null;
		}
	}

	public static Variable SetVariableValue<T>(this IBlackboard blackboard, string varName, T value)
	{
		if (!blackboard.variables.TryGetValue(varName, out var value2))
		{
			return blackboard.AddVariable(varName, value);
		}
		try
		{
			value2.value = value;
			return value2;
		}
		catch
		{
			return null;
		}
	}

	public static void InitializePropertiesBinding(this IBlackboard blackboard, Component target, bool callSetter)
	{
	}

	public static Variable<T> GetVariable<T>(this IBlackboard blackboard, string varName)
	{
		return (Variable<T>)blackboard.GetVariable(varName, typeof(T));
	}

	public static Variable GetVariable(this IBlackboard blackboard, string varName, Type ofType = null)
	{
		if (blackboard.variables != null && varName != null && blackboard.variables.TryGetValue(varName, out var value))
		{
			return value;
		}
		if (blackboard.parent != null)
		{
			Variable variable = blackboard.parent.GetVariable(varName, ofType);
			if (variable != null)
			{
				return variable;
			}
		}
		return null;
	}

	public static Variable GetVariableByID(this IBlackboard blackboard, string ID)
	{
		if (blackboard.variables != null && ID != null)
		{
			foreach (KeyValuePair<string, Variable> variable in blackboard.variables)
			{
				if (variable.Value.ID == ID)
				{
					return variable.Value;
				}
			}
		}
		if (blackboard.parent != null)
		{
			Variable variableByID = blackboard.parent.GetVariableByID(ID);
			if (variableByID != null)
			{
				return variableByID;
			}
		}
		return null;
	}

	public static IEnumerable<Variable> GetVariables(this IBlackboard blackboard, Type ofType = null)
	{
		if (blackboard.parent != null)
		{
			foreach (Variable variable in blackboard.parent.GetVariables(ofType))
			{
				yield return variable;
			}
		}
		foreach (KeyValuePair<string, Variable> variable2 in blackboard.variables)
		{
			if (ofType == null || ofType == typeof(object) || variable2.Value.CanConvertTo(ofType))
			{
				yield return variable2.Value;
			}
		}
	}

	public static Variable ChangeVariableType(this IBlackboard blackboard, Variable target, Type newType)
	{
		Variable variable = (Variable)Activator.CreateInstance(typeof(Variable<>).RTMakeGenericType(newType), target.name, target.ID);
		blackboard.variables[target.name] = variable;
		blackboard.TryInvokeOnVariableAdded(variable);
		return variable;
	}

	public static void OverwriteFrom(this IBlackboard blackboard, IBlackboard sourceBlackboard, bool removeMissingVariables = true)
	{
		foreach (KeyValuePair<string, Variable> variable in sourceBlackboard.variables)
		{
			if (blackboard.variables.ContainsKey(variable.Key))
			{
				blackboard.SetVariableValue(variable.Key, variable.Value.value);
			}
			else
			{
				blackboard.variables[variable.Key] = variable.Value;
			}
		}
		if (!removeMissingVariables)
		{
			return;
		}
		foreach (string item in new List<string>(blackboard.variables.Keys))
		{
			if (!sourceBlackboard.variables.ContainsKey(item))
			{
				blackboard.variables.Remove(item);
			}
		}
	}
}
