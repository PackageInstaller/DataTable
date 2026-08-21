using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("获取技能的层数", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通过节点《修改技能的层数》添加的资源")]
public class GetSkillLayerAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("层数", 0)]
	[Description("层数")]
	public BBParameter<int> Layer;

	protected override void OnExecute()
	{
		base.OnExecute();
		Layer.value = ownerEntity.GetComponent<SkillComponent>().GetSkillLayer(SkillId.value);
		EndAction();
	}
}
