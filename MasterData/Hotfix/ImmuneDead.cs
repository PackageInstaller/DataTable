[AdventureEffect(HotfixEnum.effectType.IMMUNE_DEAD)]
public class ImmuneDead : AdventureEffectBase
{
	private int _maxTime;

	private int _curTime;

	public override void InitParams()
	{
		base.InitParams();
		_curTime = 0;
		TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out _maxTime);
		if (_maxTime <= 0)
		{
			_maxTime = 99999;
		}
	}

	public override void AddListenerer()
	{
		base.AddListenerer();
		_owner.RigisterDeadImmunity(AccumulateTime);
	}

	public override void RemoveListener()
	{
		base.RemoveListener();
		_owner.UnRigisterDeadImmunity(AccumulateTime);
	}

	public override void Execute()
	{
		base.Execute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).EnableDeadImmunity(_maxTime);
		}
	}

	private void AccumulateTime()
	{
		_curTime++;
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).DisableDeadImmunity();
		}
	}
}
