using System.Collections.Generic;

namespace ACT.UI;

public sealed class TextAnimatorParseContext
{
	private List<TextAnimatorAction> m_actions;

	private List<TextAnimatorEffectRange> m_effectRanges;

	private List<TextAnimatorInstantRange> m_instantRanges;

	public void Reset(List<TextAnimatorAction> actions, List<TextAnimatorEffectRange> effectRanges, List<TextAnimatorInstantRange> instantRanges)
	{
		m_actions = actions;
		m_effectRanges = effectRanges;
		m_instantRanges = instantRanges;
	}

	public void AddAction(TextAnimatorAction action)
	{
		m_actions?.Add(action);
	}

	public void AddEffectRange(TextAnimatorEffectRange range)
	{
		m_effectRanges?.Add(range);
	}

	public void AddInstantRange(TextAnimatorInstantRange range)
	{
		m_instantRanges?.Add(range);
	}
}
