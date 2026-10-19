using UnityEngine;

namespace ACT;

public class SwitchInstruction : CustomYieldInstruction
{
	public bool status;

	public override bool keepWaiting => !status;

	public SwitchInstruction()
	{
		status = false;
	}

	public override void Reset()
	{
		status = false;
	}
}
