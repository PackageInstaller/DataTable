using System;
using System.Collections.Generic;
using UnityEngine;

namespace NodeCanvas.Framework;

public interface IBlackboard
{
	string identifier { get; }

	IBlackboard parent { get; }

	Dictionary<string, Variable> variables { get; set; }

	Component propertiesBindTarget { get; }

	UnityEngine.Object unityContextObject { get; }

	string independantVariablesFieldName { get; }

	event Action<Variable> onVariableAdded;

	event Action<Variable> onVariableRemoved;

	void TryInvokeOnVariableAdded(Variable variable);

	void TryInvokeOnVariableRemoved(Variable variable);

	void RefreshVariables();
}
