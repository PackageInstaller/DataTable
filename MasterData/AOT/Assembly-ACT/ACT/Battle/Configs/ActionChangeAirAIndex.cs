using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改空中A索引", "Action", new string[] { "change", "air", "index" })]
public class ActionChangeAirAIndex : ConfigAction
{
	public int index;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompMotion().AirAIndex = index;
	}
}
