using System;
using UnityEngine;

namespace ACT.UI;

[CreateAssetMenu(menuName = "ACT/UI/Text Animator Tags/Speed")]
public sealed class SpeedTextAnimatorTagParserRule : TextAnimatorTagParserRuleBase
{
	private sealed class SpeedTextAnimatorTagParser : TextAnimatorRuntimeTagParser, ITextAnimatorActionHandler
	{
		private readonly float m_defaultTimeSpace;

		public SpeedTextAnimatorTagParser(string tagName, float defaultTimeSpace)
			: base(tagName)
		{
			m_defaultTimeSpace = defaultTimeSpace;
		}

		protected override void ProcessTag(ReadOnlySpan<char> textInsideBrackets, int attributesStart, bool isClosing, ref int realTextIndex)
		{
			if (!isClosing)
			{
				Context.AddAction(new TextAnimatorAction
				{
					Handler = this,
					Index = realTextIndex,
					FloatValue = TextAnimatorTagParserUtility.ReadFloat(textInsideBrackets, attributesStart, m_defaultTimeSpace, "value", "interval")
				});
			}
		}

		public void Execute(TextAnimatorComponent component, in TextAnimatorAction action)
		{
			component.SetTypewriterTimeSpace(action.FloatValue);
		}

		void ITextAnimatorActionHandler.Execute(TextAnimatorComponent component, in TextAnimatorAction action)
		{
			Execute(component, in action);
		}
	}

	public float defaultTimeSpace = 33f;

	public override ITagParserBase CreateParser()
	{
		return new SpeedTextAnimatorTagParser("speed", defaultTimeSpace);
	}
}
