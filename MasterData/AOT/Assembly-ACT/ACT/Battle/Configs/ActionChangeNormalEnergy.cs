using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改普通能量", "Action", new string[] { "change", "normal", "energy" })]
public class ActionChangeNormalEnergy : ConfigAction
{
	public enum ModifySource
	{
		None,
		consmueAbility,
		role13
	}

	public enum State
	{
		Normal,
		ToAnyPercent,
		Set
	}

	public ConfigFunction<float> energyValue = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 100f
		}
	};

	public State state;

	[Range(0f, 1f)]
	public float percent;

	public ModifySource modifySource;

	public override void Do(ActionMemory memory)
	{
		float value = 0f;
		switch (state)
		{
		case State.Normal:
			value = energyValue.Return(memory);
			break;
		case State.ToAnyPercent:
			value = memory.target.entity.GetCompAbility().EnergyValue * percent;
			break;
		case State.Set:
			value = Mathf.Min(memory.target.entity.GetCompAbility().MaxNormalEnergy, energyValue.Return(memory));
			break;
		}
		memory.target.entity.GetCompAbility().ActionModifyNormalEnergy(value, memory.ability, state, modifySource);
	}
}
