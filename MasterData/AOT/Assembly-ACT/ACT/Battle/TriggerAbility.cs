using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using Utility;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class TriggerAbility : Action
{
	public string[] abilityName;

	public SharedBool useSharedString;

	public SharedString[] sharedAbilityName;

	public override void OnStart()
	{
		if (!(Owner is ActBehaviorTree actBehaviorTree))
		{
			return;
		}
		Entity eb = actBehaviorTree.Entity;
		if (!eb.IsValid)
		{
			return;
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		if (useSharedString.Value)
		{
			sharedAbilityName.ForEach((SharedString s) =>
			{
				systemAbility.TriggerAbility(eb, eb, s.Value);
			});
		}
		else
		{
			abilityName.ForEach((string s) =>
			{
				systemAbility.TriggerAbility(eb, eb, s);
			});
		}
	}

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
