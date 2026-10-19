namespace ACT.Battle.Configs;

public class EffectDressItem : PerformanceItem
{
	public string cueKey;

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		EffectDressRuntimeUtility.FireMotionCue(target.entity, cueKey);
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
