using System.Collections.Generic;
using UnityEngine;

namespace Yarn.Unity;

public abstract class VariableStorageBehaviour : MonoBehaviour, IVariableStorage
{
	public abstract bool TryGetValue<T>(string variableName, out T result);

	public abstract void SetValue(string variableName, string stringValue);

	public abstract void SetValue(string variableName, float floatValue);

	public abstract void SetValue(string variableName, bool boolValue);

	public abstract void Clear();

	public abstract bool Contains(string variableName);

	public abstract void SetAllVariables(Dictionary<string, float> floats, Dictionary<string, string> strings, Dictionary<string, bool> bools, bool clear = true);

	public abstract (Dictionary<string, float> FloatVariables, Dictionary<string, string> StringVariables, Dictionary<string, bool> BoolVariables) GetAllVariables();
}
