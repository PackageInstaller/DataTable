[AdventureEffect(HotfixEnum.effectType.AMEND_NO_COST)]
public class AmendNoCostEffect : AdventureEffectBase
{
	private int leftTime;

	private int curTime;

	public override void InitParams()
	{
		base.InitParams();
		curTime = 0;
		TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out leftTime);
	}

	public override void Execute()
	{
		base.Execute();
		RefreshTargetAmmoState(isCostAmmo: true);
	}

	public override void PostExecute()
	{
		base.PostExecute();
		RefreshTargetAmmoState(isCostAmmo: false);
	}

	private void AccumulateCostAmmo(IEvent evt)
	{
		AmmoInfo flowAmmoInfo = ActorHelper.GetFlowAmmoInfo(_owner.gameObject);
		if (evt.sender is AmmoInfo ammoInfo && ammoInfo == flowAmmoInfo)
		{
			curTime++;
			if (curTime >= leftTime)
			{
				RefreshTargetAmmoState(isCostAmmo: false);
			}
		}
	}

	private void RefreshTargetAmmoState(bool isCostAmmo)
	{
		for (int i = 0; i < _targets.Count; i++)
		{
			AdventureActor adventureActor = _targets.get_Item(i);
			if (adventureActor.ammoInfo != null)
			{
				adventureActor.ammoInfo.isNoCostAmmo = isCostAmmo;
			}
		}
	}

	public override void AddListenerer()
	{
		base.AddListenerer();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_SHOOT_COST_AMMO", AccumulateCostAmmo);
	}

	public override void RemoveListener()
	{
		base.RemoveListener();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_SHOOT_COST_AMMO", AccumulateCostAmmo);
	}
}
