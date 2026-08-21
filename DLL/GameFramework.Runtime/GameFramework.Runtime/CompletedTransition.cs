using System.Collections;

namespace GameFramework.Runtime;

public class CompletedTransition : Transition
{
	public CompletedTransition(IManageable window)
		: base(window)
	{
		IsDone = true;
	}

	protected override IEnumerator DoTransition()
	{
		yield break;
	}
}
