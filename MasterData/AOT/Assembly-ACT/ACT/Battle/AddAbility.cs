using System.Linq;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class AddAbility : Action
{
	public string[] abilityName;

	public SharedBool useSharedString;

	public SharedString[] sharedAbilityName;

	public override void OnStart()
	{
		if (!(Owner is ActBehaviorTree actBehaviorTree) || !actBehaviorTree.Entity.TryGetCompAbility(out CompAbility component))
		{
			return;
		}
		if (useSharedString.Value)
		{
			string[] abilities = sharedAbilityName.Select((SharedString s) => s.Value).ToArray();
			component.AddAbilities(abilities, AbilitySource.BehaviourTree);
		}
		else
		{
			component.AddAbilities(abilityName, AbilitySource.BehaviourTree);
		}
	}

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
