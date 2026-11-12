[AdventureEffect(HotfixEnum.effectType.DAMAGE_IMM_ACC)]
public class DamageImmunityAcc : AdventureEffectBase
{
	private int leftTime;

	private int curTime;

	public override void InitParams()
	{
		base.InitParams();
		curTime = 0;
		TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out leftTime);
	}

	public override void AddListenerer()
	{
		base.AddListenerer();
	}

	public override void RemoveListener()
	{
		base.RemoveListener();
	}

	public override void Execute()
	{
		base.Execute();
		for (int i = 0; i < leftTime; i++)
		{
			for (int j = 0; j < _targets.Count; j++)
			{
				_targets.get_Item(j).EnableDamageImmunity();
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < leftTime - curTime; i++)
		{
			for (int j = 0; j < _targets.Count; j++)
			{
				_targets.get_Item(j).DisableDamageImmunity();
			}
		}
	}

	private void AccumulateCost()
	{
		curTime++;
		if (curTime <= leftTime)
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).DisableDamageImmunity();
			}
		}
	}
}
