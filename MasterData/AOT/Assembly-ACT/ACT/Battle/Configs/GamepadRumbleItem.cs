namespace ACT.Battle.Configs;

public class GamepadRumbleItem : PerformanceItem
{
	public ActionGamepadRumble rumbleAction = new ActionGamepadRumble();

	public float endTime;

	public int endTimeFrame;

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		if (endTime > 0f)
		{
			rumbleAction.durationOverride = runtimeState.actualMotion.clip.length * ((endTime > time) ? (endTime - time) : (1f - time));
		}
		rumbleAction.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
