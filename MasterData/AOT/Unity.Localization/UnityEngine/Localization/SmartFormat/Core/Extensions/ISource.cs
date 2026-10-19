namespace UnityEngine.Localization.SmartFormat.Core.Extensions;

public interface ISource
{
	bool TryEvaluateSelector(ISelectorInfo selectorInfo);
}
