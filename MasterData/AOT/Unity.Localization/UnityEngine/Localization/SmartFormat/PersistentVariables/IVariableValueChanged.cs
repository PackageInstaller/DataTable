using System;

namespace UnityEngine.Localization.SmartFormat.PersistentVariables;

public interface IVariableValueChanged : IVariable
{
	event Action<IVariable> ValueChanged;
}
