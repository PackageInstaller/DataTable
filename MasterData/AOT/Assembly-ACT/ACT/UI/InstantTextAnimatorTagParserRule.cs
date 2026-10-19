using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

[CreateAssetMenu(menuName = "ACT/UI/Text Animator Tags/Instant")]
public sealed class InstantTextAnimatorTagParserRule : TextAnimatorTagParserRuleBase
{
	private sealed class InstantTextAnimatorTagParser(string tagName) : TextAnimatorRuntimeTagParser(tagName)
	{
		private readonly List<int> m_openRanges = new List<int>();

		protected override void OnResetParser()
		{
			m_openRanges.Clear();
		}

		protected override void ProcessTag(ReadOnlySpan<char> textInsideBrackets, int attributesStart, bool isClosing, ref int realTextIndex)
		{
			if (isClosing)
			{
				CloseRange(realTextIndex);
			}
			else
			{
				m_openRanges.Add(realTextIndex);
			}
		}

		private void CloseRange(int realTextIndex)
		{
			int num = m_openRanges.Count - 1;
			if (num >= 0)
			{
				int num2 = m_openRanges[num];
				m_openRanges.RemoveAt(num);
				int num3 = realTextIndex - num2;
				if (num3 > 0)
				{
					Context.AddInstantRange(new TextAnimatorInstantRange
					{
						StartIndex = num2,
						Length = num3
					});
				}
			}
		}
	}

	public override ITagParserBase CreateParser()
	{
		return new InstantTextAnimatorTagParser("instant");
	}
}
