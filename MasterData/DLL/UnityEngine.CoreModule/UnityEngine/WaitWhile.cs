using System;

namespace UnityEngine;

public sealed class WaitWhile : CustomYieldInstruction
{
	private Func<bool> m_Predicate;

	public override bool keepWaiting => m_Predicate();

	public WaitWhile(Func<bool> predicate)
	{
		m_Predicate = predicate;
	}
}
