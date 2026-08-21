using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("设置技能是否处于强化状态", 0)]
[Category("✫ DragonLost/Entity")]
[Description("设置技能强化状态。")]
public class SkillStrengthenAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("要设置执行状态的技能的标识符。")]
	public BBParameter<int> SkillId;

	[Name("是否处于强化状态", 0)]
	[Description("是否处于强化状态。")]
	public BBParameter<bool> IsStrength;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().SetSkillStrengthen(SkillId.value, IsStrength.value);
		EndAction();
	}
}
