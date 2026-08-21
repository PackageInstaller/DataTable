using UnityEngine;

namespace GameFramework.Runtime;

public class WaitForMainThread : CustomYieldInstruction
{
	public static readonly WaitForMainThread Default = new WaitForMainThread();

	public override bool keepWaiting => false;
}
