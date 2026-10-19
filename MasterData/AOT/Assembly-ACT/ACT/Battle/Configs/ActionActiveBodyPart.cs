using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("激活身体Part", "Action", new string[] { "active", "body", "part", "state", "status", "tag" })]
public class ActionActiveBodyPart : ConfigAction
{
	public int[] indexes;

	public bool active;

	public override void Do(ActionMemory memory)
	{
		MonoEntity mono = memory.owner.GetMono();
		int[] array = indexes;
		foreach (int num in array)
		{
			mono.bodyParts[num].SetRuntimeActive(active);
		}
	}
}
