using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.Core.Output;

public interface IOutput
{
	void Write(string text, IFormattingInfo formattingInfo);

	void Write(string text, int startIndex, int length, IFormattingInfo formattingInfo);
}
