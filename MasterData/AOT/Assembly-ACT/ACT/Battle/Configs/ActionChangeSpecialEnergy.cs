using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改特殊能量", "Action", new string[] { "change", "special", "energy" })]
public class ActionChangeSpecialEnergy : ConfigAction
{
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

	public override void Do(ActionMemory memory)
	{
		float value = 0f;
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		switch (state)
		{
		case State.Normal:
			value = energyValue.Return(memory);
			break;
		case State.ToAnyPercent:
			value = compAbility.SpecialEnergyValue * percent;
			break;
		case State.Set:
			value = Mathf.Min(compAbility.MaxSpecialEnergy, energyValue.Return(memory));
			break;
		}
		compAbility.ActionModifySpecialEnergy(value, memory.ability, state);
	}
}
