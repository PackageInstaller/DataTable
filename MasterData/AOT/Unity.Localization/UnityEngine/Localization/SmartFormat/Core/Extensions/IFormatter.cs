namespace UnityEngine.Localization.SmartFormat.Core.Extensions;

public interface IFormatter
{
	string[] Names { get; set; }

	bool TryEvaluateFormat(IFormattingInfo formattingInfo);
}
