using System;

namespace UnityEngine;

public sealed class WaitUntil : CustomYieldInstruction
{
	private Func<bool> m_Predicate;

	public override bool keepWaiting => !m_Predicate();

	public WaitUntil(Func<bool> predicate)
	{
		m_Predicate = predicate;
	}
}
