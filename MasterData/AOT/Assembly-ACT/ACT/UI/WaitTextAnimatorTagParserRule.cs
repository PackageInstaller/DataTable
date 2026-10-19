using System;
using UnityEngine;

namespace ACT.UI;

[CreateAssetMenu(menuName = "ACT/UI/Text Animator Tags/Wait")]
public sealed class WaitTextAnimatorTagParserRule : TextAnimatorTagParserRuleBase
{
	private sealed class WaitTextAnimatorTagParser : TextAnimatorRuntimeTagParser, ITextAnimatorActionHandler
	{
		private readonly float m_defaultMilliseconds;

		public WaitTextAnimatorTagParser(string tagName, float defaultMilliseconds)
			: base(tagName)
		{
			m_defaultMilliseconds = defaultMilliseconds;
		}

		protected override void ProcessTag(ReadOnlySpan<char> textInsideBrackets, int attributesStart, bool isClosing, ref int realTextIndex)
		{
			if (!isClosing)
			{
				Context.AddAction(new TextAnimatorAction
				{
					Handler = this,
					Index = realTextIndex,
					FloatValue = TextAnimatorTagParserUtility.ReadFloat(textInsideBrackets, attributesStart, m_defaultMilliseconds, "time", "value")
				});
			}
		}

		public void Execute(TextAnimatorComponent component, in TextAnimatorAction action)
		{
			component.Wait(action.FloatValue);
		}

		void ITextAnimatorActionHandler.Execute(TextAnimatorComponent component, in TextAnimatorAction action)
		{
			Execute(component, in action);
		}
	}

	public float defaultMilliseconds = 500f;

	public override ITagParserBase CreateParser()
	{
		return new WaitTextAnimatorTagParser("wait", defaultMilliseconds);
	}
}
