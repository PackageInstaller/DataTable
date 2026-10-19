namespace UnityEngine.Localization.SmartFormat.PersistentVariables;

public interface IVariableGroup
{
	bool TryGetValue(string key, out IVariable value);
}
