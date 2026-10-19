using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

[CreateAssetMenu(menuName = "ACT/UI/Text Animator Tags/Effect")]
public sealed class EffectTextAnimatorTagParserRule : TextAnimatorTagParserRuleBase
{
	private sealed class EffectTextAnimatorTagParser : TextAnimatorRuntimeTagParser, ITextAnimatorActionHandler
	{
		private struct OpenRange
		{
			public int StartIndex;

			public string EffectId;
		}

		private readonly List<OpenRange> m_openRanges = new List<OpenRange>();

		private readonly string m_defaultEffectId;

		private readonly List<TextAnimatorEffectBinding> m_effectBindings;

		public EffectTextAnimatorTagParser(string tagName, string defaultEffectId, List<TextAnimatorEffectBinding> effectBindings)
			: base(tagName)
		{
			m_defaultEffectId = defaultEffectId;
			m_effectBindings = effectBindings;
		}

		protected override void OnResetParser()
		{
			m_openRanges.Clear();
		}

		protected override void ProcessTag(ReadOnlySpan<char> textInsideBrackets, int attributesStart, bool isClosing, ref int realTextIndex)
		{
			if (isClosing)
			{
				CloseRange(realTextIndex);
				return;
			}
			string effectId = TextAnimatorTagParserUtility.ReadString(textInsideBrackets, attributesStart, m_defaultEffectId, "id", "value");
			m_openRanges.Add(new OpenRange
			{
				StartIndex = realTextIndex,
				EffectId = effectId
			});
		}

		private void CloseRange(int realTextIndex)
		{
			int num = m_openRanges.Count - 1;
			if (num >= 0)
			{
				OpenRange openRange = m_openRanges[num];
				m_openRanges.RemoveAt(num);
				for (int i = openRange.StartIndex; i < realTextIndex; i++)
				{
					Context.AddAction(new TextAnimatorAction
					{
						Handler = this,
						Index = i + 1,
						IntValue = i,
						StringValue = openRange.EffectId
					});
				}
			}
		}

		public void Execute(TextAnimatorComponent component, in TextAnimatorAction action)
		{
			if (TryGetEffectBinding(action.StringValue, out var binding))
			{
				TextAnimatorEffectPool.Play(binding, component.EffectRoot, component.GetCharacterLocalPosition(action.IntValue));
			}
		}

		private bool TryGetEffectBinding(string effectId, out TextAnimatorEffectBinding binding)
		{
			if (!string.IsNullOrEmpty(effectId) && m_effectBindings != null)
			{
				for (int i = 0; i < m_effectBindings.Count; i++)
				{
					TextAnimatorEffectBinding textAnimatorEffectBinding = m_effectBindings[i];
					if (textAnimatorEffectBinding != null && string.Equals(textAnimatorEffectBinding.effectId, effectId, StringComparison.Ordinal) && (bool)textAnimatorEffectBinding.prefab)
					{
						binding = textAnimatorEffectBinding;
						return true;
					}
				}
			}
			binding = null;
			return false;
		}

		void ITextAnimatorActionHandler.Execute(TextAnimatorComponent component, in TextAnimatorAction action)
		{
			Execute(component, in action);
		}
	}

	public string defaultEffectId;

	public List<TextAnimatorEffectBinding> effectBindings = new List<TextAnimatorEffectBinding>();

	public override ITagParserBase CreateParser()
	{
		return new EffectTextAnimatorTagParser("effect", defaultEffectId, effectBindings);
	}
}
