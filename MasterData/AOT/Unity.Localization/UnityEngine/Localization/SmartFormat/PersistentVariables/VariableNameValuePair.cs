using System;

namespace UnityEngine.Localization.SmartFormat.PersistentVariables;

[Serializable]
internal class VariableNameValuePair
{
	public string name;

	[SerializeReference]
	public IVariable variable;

	public override string ToString()
	{
		return name + " - " + variable?.GetType().Name;
	}
}
