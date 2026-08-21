using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查是否在新手引导关卡", 0)]
[Description("检查是否在新手引导关卡。")]
[Category("✫ DragonLost/Entity")]
public class GetIsInTeachGuideLevel : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity.GetSystem<SceneSystem>().GetIsInTeachGuideLevel();
	}
}
