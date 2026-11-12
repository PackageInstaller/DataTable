using Unity.Mathematics;
using UnityEngine;

public class BuffEffect_OnceDot : BuffEffect_DotBase
{
	private long excptDamage;

	protected override void Enter()
	{
		base.Enter();
		if (TryParseStringParamToInt(buffEffectConfig.Param1, out var intValue, allowEmpty: true))
		{
			long num = CalculateDamage(intValue);
			if (hitDamageConfigTemp == null)
			{
				onceDamage = 0L;
				return;
			}
			long maxDamage = GetMaxDamage(num);
			num += excptDamage;
			num /= processCount;
			onceDamage = num;
			onceDamage = math.max(1L, onceDamage);
			onceDamage = ((onceDamage > maxDamage) ? maxDamage : onceDamage);
		}
	}

	private long GetMaxDamage(long _damage)
	{
		long y = _damage / processCount;
		y = math.max(1L, y);
		return y * buffEntity.GetBuffNum();
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
		excptDamage = 0L;
	}

	public void SetExceptDamage(long damage)
	{
		excptDamage = damage;
	}

	public long GetExceptDamage()
	{
		return excptDamage;
	}

	public void PreCalculateEnd()
	{
		int num = Mathf.CeilToInt((buffEntity.LeftTime / period).AsFloat());
		excptDamage = num * onceDamage;
		EndProcess();
	}
}
