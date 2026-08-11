using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改技能叠层数据", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改技能叠层数据")]
public class ChangeSkillLayerAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("修改的技能ID")]
	public BBParameter<int> SkillId;

	[Name("是否修改当前叠层层数", 0)]
	[Description("修改当前叠层层数")]
	public bool ChangeCurrentSkillLayer;

	[Name("修改当前叠层层数类型", 0)]
	[Description("修改当前叠层层数类型")]
	public SkillDataChangeType CurrentSkillLayerChargeType;

	[Name("修改当前叠层层数数据", 0)]
	[Description("修改当前叠层层数数据")]
	public int CurrentSkillLayer;

	[Name("是否修改最大叠层层数", 0)]
	[Description("修改最大叠层层数")]
	public bool ChangeMaxSkillLayer;

	[Name("修改最大叠层层数类型", 0)]
	[Description("修改最大叠层层数类型")]
	public SkillDataChangeType MaxSkillLayerChargeType;

	[Name("修改最大叠层层数数据", 0)]
	[Description("修改最大叠层层数数据")]
	public int MaxSkillLayer;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = GetOwnerEntity().GetComponent<SkillComponent>().GetSkillData(SkillId.value);
		if (skillData == null)
		{
			EndAction();
			return;
		}
		if (ChangeCurrentSkillLayer)
		{
			switch (CurrentSkillLayerChargeType)
			{
			case SkillDataChangeType.Set:
				skillData.AmendSkillLayer(CurrentSkillLayer);
				break;
			case SkillDataChangeType.Add:
				skillData.AmendSkillLayer(skillData.CacheLayer + CurrentSkillLayer);
				break;
			case SkillDataChangeType.Dec:
				skillData.AmendSkillLayer(skillData.CacheLayer - CurrentSkillLayer);
				break;
			}
		}
		if (ChangeMaxSkillLayer)
		{
			switch (MaxSkillLayerChargeType)
			{
			case SkillDataChangeType.Set:
				skillData.AmendMaxSkillLayer(MaxSkillLayer);
				break;
			case SkillDataChangeType.Add:
				skillData.AmendMaxSkillLayer(skillData.MaxCacheLayer + MaxSkillLayer);
				break;
			case SkillDataChangeType.Dec:
				skillData.AmendMaxSkillLayer(skillData.MaxCacheLayer - MaxSkillLayer);
				break;
			}
		}
		EndAction();
	}
}
