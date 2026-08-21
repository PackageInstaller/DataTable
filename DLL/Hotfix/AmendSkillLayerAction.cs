using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

[Name("修改技能的层数", 0)]
[Category("✫ DragonLost/Skill")]
[Description("动态修改技能的层数")]
public class AmendSkillLayerAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("操作", 0)]
	public OperationMethod Operation;

	[Name("层数", 0)]
	[Description("层数")]
	public BBParameter<int> Layer;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = ownerEntity.GetComponent<SkillComponent>().GetSkillData(SkillId.value);
		if (skillData != null)
		{
			int layer = OperationTools.Operate(skillData.CacheLayer, Layer.value, Operation);
			skillData.AmendSkillLayer(layer);
		}
		EndAction();
	}
}
