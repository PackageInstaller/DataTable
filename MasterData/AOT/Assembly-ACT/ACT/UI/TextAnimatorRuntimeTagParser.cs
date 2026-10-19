using System;
using System.Text;

namespace ACT.UI;

public abstract class TextAnimatorRuntimeTagParser : ITextAnimatorRuntimeTagParser, ITagParserBase
{
	private readonly string m_tagName;

	protected TextAnimatorParseContext Context { get; private set; }

	public char StartSymbol => '<';

	public char EndSymbol => '>';

	protected TextAnimatorRuntimeTagParser(string tagName)
	{
		m_tagName = tagName;
	}

	public void ResetParser(TextAnimatorParseContext context)
	{
		Context = context;
		OnResetParser();
	}

	public bool TryProcessingTag(ReadOnlySpan<char> textInsideBrackets, int tagLength, ref int realTextIndex, StringBuilder finalTextBuilder, int internalOrder)
	{
		if (string.IsNullOrEmpty(m_tagName) || tagLength <= 0)
		{
			return false;
		}
		if (!TextAnimatorTagParserUtility.TryReadTagName(textInsideBrackets, out var tagName, out var attributesStart, out var isClosing))
		{
			return false;
		}
		if (!tagName.SequenceEqual(m_tagName))
		{
			return false;
		}
		ProcessTag(textInsideBrackets, attributesStart, isClosing, ref realTextIndex);
		return true;
	}

	protected virtual void OnResetParser()
	{
	}

	protected abstract void ProcessTag(ReadOnlySpan<char> textInsideBrackets, int attributesStart, bool isClosing, ref int realTextIndex);
}
