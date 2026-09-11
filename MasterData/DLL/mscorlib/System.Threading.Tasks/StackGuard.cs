using System.Runtime.CompilerServices;

namespace System.Threading.Tasks;

internal class StackGuard
{
	private int m_inliningDepth;

	private const int MAX_UNCHECKED_INLINING_DEPTH = 20;

	internal bool TryBeginInliningScope()
	{
		if (m_inliningDepth < 20 || RuntimeHelpers.TryEnsureSufficientExecutionStack())
		{
			m_inliningDepth++;
			return true;
		}
		return false;
	}

	internal void EndInliningScope()
	{
		m_inliningDepth--;
		if (m_inliningDepth < 0)
		{
			m_inliningDepth = 0;
		}
	}
}
