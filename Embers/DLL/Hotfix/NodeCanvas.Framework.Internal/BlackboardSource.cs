using System;
using System.Collections.Generic;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[Serializable]
public class BlackboardSource : IBlackboard
{
	[SerializeField]
	private Dictionary<string, Variable> _variables = new Dictionary<string, Variable>(StringComparer.Ordinal);

	[NonSerialized]
	private Dictionary<string, object> _copyVariables = new Dictionary<string, object>();

	private bool isInit;

	public Dictionary<string, object> copyVariables
	{
		get
		{
			return _copyVariables;
		}
		set
		{
			_copyVariables = value;
		}
	}

	public string identifier => "Graph";

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

	public IBlackboard parent { get; set; }

	public UnityEngine.Object unityContextObject { get; set; }

	public Component propertiesBindTarget { get; set; }

	string IBlackboard.independantVariablesFieldName => null;

	public event Action<Variable> onVariableAdded;

	public event Action<Variable> onVariableRemoved;

	void IBlackboard.TryInvokeOnVariableAdded(Variable variable)
	{
		onVariableAdded?.Invoke(variable);
	}

	void IBlackboard.TryInvokeOnVariableRemoved(Variable variable)
	{
		onVariableRemoved?.Invoke(variable);
	}

	public void InitCopyVariables()
	{
		if (variables == null || _copyVariables == null || variables.Count == 0 || isInit)
		{
			return;
		}
		isInit = true;
		foreach (KeyValuePair<string, Variable> variable in variables)
		{
			if (variable.Value != null && variable.Key != "BaseEntity")
			{
				_copyVariables.TryAdd(variable.Key, variable.Value.value);
			}
		}
	}

	public void RefreshVariables()
	{
		if (variables == null || _copyVariables == null)
		{
			return;
		}
		foreach (string key in variables.Keys)
		{
			if (_copyVariables.TryGetValue(key, out var value) && key != "BaseEntity")
			{
				variables[key].value = value;
			}
		}
	}

	public override string ToString()
	{
		return identifier;
	}
}
