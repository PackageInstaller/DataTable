using System.Collections.Generic;

namespace ACT.Battle.Configs;

public class EffectItem : PerformanceItem
{
	public ActionFireEffect effect = new ActionFireEffect();

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		effect.motionState = runtimeState.state.value.stateType;
		effect.configMotionName = ((runtimeState.actualMotion != null) ? runtimeState.actualMotion.name : null);
		try
		{
			effect.CheckDo(new ActionMemory(target.entity, target.entity, target));
		}
		finally
		{
			effect.configMotionName = null;
		}
	}

	public override void Precache(List<YooAssetReference> list)
	{
		effect.Precache(list);
	}

	public void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
		effect?.CollectEffectPrewarm(collector, mapping);
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
