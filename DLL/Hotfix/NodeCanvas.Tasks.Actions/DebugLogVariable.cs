using System;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Utility")]
[Description("Logs the value of a variable in the console")]
[Obsolete("Use Debug Log Text")]
public class DebugLogVariable : ActionTask
{
	[BlackboardOnly]
	public BBParameter<object> log;

	public BBParameter<string> prefix;

	public float secondsToRun = 1f;

	public CompactStatus finishStatus = CompactStatus.Success;

	protected override string info => "Log '" + log?.ToString() + "'" + ((secondsToRun > 0f) ? (" for " + secondsToRun + " sec.") : "");

	protected override void OnExecute()
	{
	}

	protected override void OnUpdate()
	{
		if (base.elapsedTime >= secondsToRun)
		{
			EndAction(finishStatus == CompactStatus.Success);
		}
	}
}
