using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

namespace Yarn.Unity;

[HelpURL("https://yarnspinner.dev/docs/unity/components/variable-storage/")]
public class InMemoryVariableStorage : VariableStorageBehaviour, IEnumerable<KeyValuePair<string, object>>, IEnumerable
{
	private Dictionary<string, object> variables = new Dictionary<string, object>();

	private Dictionary<string, Type> variableTypes = new Dictionary<string, Type>();

	[HideInInspector]
	[Header("Optional debugging tools")]
	public bool showDebug;

	[SerializeField]
	[Tooltip("(optional) output list of variables and values to Text UI in-game")]
	internal Text debugTextView;

	internal void Update()
	{
		if (debugTextView != null)
		{
			debugTextView.text = GetDebugList();
			debugTextView.SetAllDirty();
		}
	}

	public string GetDebugList()
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (KeyValuePair<string, object> variable in variables)
		{
			stringBuilder.AppendLine(string.Format("{0} = {1} ({2})", variable.Key, variable.Value.ToString(), variableTypes[variable.Key].ToString().Substring("System.".Length)));
		}
		return stringBuilder.ToString();
	}

	private void SetVariable(string name, IType type, string value)
	{
		if (type == BuiltinTypes.Boolean)
		{
			if (!bool.TryParse(value, out var result))
			{
				throw new InvalidCastException("Couldn't initialize default variable " + name + " with value " + value + " as Bool");
			}
			SetValue(name, result);
		}
		else if (type == BuiltinTypes.Number)
		{
			if (!float.TryParse(value, out var result2))
			{
				throw new InvalidCastException("Couldn't initialize default variable " + name + " with value " + value + " as Number (Float)");
			}
			SetValue(name, result2);
		}
		else
		{
			if (type != BuiltinTypes.String)
			{
				throw new ArgumentOutOfRangeException("Unsupported type " + type.Name);
			}
			SetValue(name, value);
		}
	}

	private void ValidateVariableName(string variableName)
	{
		if (!variableName.StartsWith("$"))
		{
			throw new ArgumentException(variableName + " is not a valid variable name: Variable names must start with a '$'. (Did you mean to use '$" + variableName + "'?)");
		}
	}

	public override void SetValue(string variableName, string stringValue)
	{
		ValidateVariableName(variableName);
		variables[variableName] = stringValue;
		variableTypes[variableName] = typeof(string);
	}

	public override void SetValue(string variableName, float floatValue)
	{
		ValidateVariableName(variableName);
		variables[variableName] = floatValue;
		variableTypes[variableName] = typeof(float);
	}

	public override void SetValue(string variableName, bool boolValue)
	{
		ValidateVariableName(variableName);
		variables[variableName] = boolValue;
		variableTypes[variableName] = typeof(bool);
	}

	public override bool TryGetValue<T>(string variableName, out T result)
	{
		ValidateVariableName(variableName);
		if (!variables.ContainsKey(variableName))
		{
			result = default(T);
			return false;
		}
		object obj = variables[variableName];
		if (typeof(T).IsAssignableFrom(obj.GetType()))
		{
			result = (T)obj;
			return true;
		}
		throw new InvalidCastException($"Variable {variableName} exists, but is the wrong type (expected {typeof(T)}, got {obj.GetType()}");
	}

	public override void Clear()
	{
		variables.Clear();
		variableTypes.Clear();
	}

	public override bool Contains(string variableName)
	{
		return variables.ContainsKey(variableName);
	}

	IEnumerator<KeyValuePair<string, object>> IEnumerable<KeyValuePair<string, object>>.GetEnumerator()
	{
		return ((IEnumerable<KeyValuePair<string, object>>)variables).GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable<KeyValuePair<string, object>>)variables).GetEnumerator();
	}

	public override (Dictionary<string, float>, Dictionary<string, string>, Dictionary<string, bool>) GetAllVariables()
	{
		Dictionary<string, float> dictionary = new Dictionary<string, float>();
		Dictionary<string, string> dictionary2 = new Dictionary<string, string>();
		Dictionary<string, bool> dictionary3 = new Dictionary<string, bool>();
		foreach (KeyValuePair<string, object> variable in variables)
		{
			Type type = variableTypes[variable.Key];
			if (type == typeof(float))
			{
				float value = Convert.ToSingle(variable.Value);
				dictionary.Add(variable.Key, value);
			}
			else if (type == typeof(string))
			{
				string value2 = Convert.ToString(variable.Value);
				dictionary2.Add(variable.Key, value2);
			}
			else if (type == typeof(bool))
			{
				bool value3 = Convert.ToBoolean(variable.Value);
				dictionary3.Add(variable.Key, value3);
			}
			else
			{
				Debug.Log(variable.Key + " is not a valid type");
			}
		}
		return (dictionary, dictionary2, dictionary3);
	}

	public override void SetAllVariables(Dictionary<string, float> floats, Dictionary<string, string> strings, Dictionary<string, bool> bools, bool clear = true)
	{
		if (clear)
		{
			variables.Clear();
			variableTypes.Clear();
		}
		foreach (KeyValuePair<string, float> @float in floats)
		{
			SetValue(@float.Key, @float.Value);
		}
		foreach (KeyValuePair<string, string> @string in strings)
		{
			SetValue(@string.Key, @string.Value);
		}
		foreach (KeyValuePair<string, bool> @bool in bools)
		{
			SetValue(@bool.Key, @bool.Value);
		}
		Debug.Log($"bulk loaded {floats.Count} floats, {strings.Count} strings, {bools.Count} bools");
	}
}
