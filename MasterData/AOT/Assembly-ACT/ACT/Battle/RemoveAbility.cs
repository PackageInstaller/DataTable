using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class RemoveAbility : Action
{
	public string[] abilityNames;

	public SharedBool useSharedString;

	public SharedString[] sharedAbilityName;

	public bool removeAll;

	public override void OnStart()
	{
		if (!(Owner is ActBehaviorTree { Entity: { IsValid: not false } entity }) || !entity.TryGetCompAbility(out CompAbility component))
		{
			return;
		}
		if (useSharedString.Value)
		{
			for (int i = 0; i < sharedAbilityName.Length; i++)
			{
				if (removeAll)
				{
					if (removeAll)
					{
						component.RemoveAbility(sharedAbilityName[i].Value);
					}
					else
					{
						component.RemoveAbilityStack(sharedAbilityName[i].Value, 1);
					}
				}
			}
			return;
		}
		string[] array = abilityNames;
		foreach (string name in array)
		{
			if (removeAll)
			{
				if (removeAll)
				{
					component.RemoveAbility(name);
				}
				else
				{
					component.RemoveAbilityStack(name, 1);
				}
			}
		}
	}

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
