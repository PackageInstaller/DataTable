using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断命中实体朝向Dir", "Predicate", new string[] { "check", "hit", "entity", "face", "dir", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckHitEntityFaceDir : ConfigPredicate
{
	public FaceDir dir;

	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.GetFaceDir() == dir;
	}
}
