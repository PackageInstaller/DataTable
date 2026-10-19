using System;
using System.Text;

namespace ACT;

public interface ITagParserBase
{
	char StartSymbol { get; }

	char EndSymbol { get; }

	bool TryProcessingTag(ReadOnlySpan<char> textInsideBrackets, int tagLength, ref int realTextIndex, StringBuilder finalTextBuilder, int internalOrder);
}
