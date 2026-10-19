using ACT.Game.Data;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断场景状态", "Predicate", new string[] { "check", "scene", "state", "status", "tag", "predicate", "condition" })]
public class CheckSceneState : ConfigPredicate
{
	public SceneStatus sceneStatus;

	public override bool Check(ActionMemory memory)
	{
		return MonoECS.instance.sceneStatus == sceneStatus;
	}
}
