using Unity.Mathematics;

public class BuffEffect_NormalDot : BuffEffect_DotBase
{
	protected override void Enter()
	{
		base.Enter();
		if (TryParseStringParamToInt(buffEffectConfig.Param1, out var intValue, allowEmpty: true))
		{
			onceDamage = CalculateDamage(intValue);
			if (hitDamageConfigTemp == null)
			{
				onceDamage = 0L;
			}
			else
			{
				onceDamage = math.max(1L, onceDamage);
			}
		}
	}

	protected override void Execute()
	{
		base.Execute();
	}

	protected override void Exit()
	{
		base.Exit();
		hitDamageConfigTemp = null;
		onceDamage = 0L;
	}
}
