using System.IO;
using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.Core.Output;

public class TextWriterOutput : IOutput
{
	public TextWriter Output { get; }

	public TextWriterOutput(TextWriter output)
	{
		Output = output;
	}

	public void Write(string text, IFormattingInfo formattingInfo)
	{
		Output.Write(text);
	}

	public void Write(string text, int startIndex, int length, IFormattingInfo formattingInfo)
	{
		Output.Write(text.Substring(startIndex, length));
	}
}
