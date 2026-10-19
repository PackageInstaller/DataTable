using ACT;
using ACT.Battle.Configs;
using ACT.World;
using Fundamental;

[AbilityTypeMetadata("判断地图区域", "Predicate", new string[] { "check", "map", "area", "vector", "position", "rotation", "quaternion", "predicate", "condition" })]
public class CheckMapArea : ConfigPredicate
{
	public MapArea targetMapArea;

	public override bool Check(ActionMemory memory)
	{
		return Singleton<GameManager>.instance.worldManager.ActiveMapId == (int)targetMapArea;
	}
}
