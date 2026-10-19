using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.PersistentVariables;

public interface IVariable
{
	object GetSourceValue(ISelectorInfo selector);
}
