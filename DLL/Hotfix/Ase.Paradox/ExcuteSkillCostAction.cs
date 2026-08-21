using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("执行技能消耗", 0)]
[Category("✫ DragonLost/Skill")]
[Description("执行技能消耗")]
public class ExcuteSkillCostAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> skillId;

	[Name("属性消耗", 0)]
	[Description("属性消耗类型选择")]
	public SkillCostEnum PropertyCost = SkillCostEnum.All;

	[Name("属性名", 0)]
	[Description("指定属性消耗")]
	[ShowIf("PropertyCost", 1)]
	public List<string> CertainPropertys;

	[Name("Buff消耗", 0)]
	[Description("Buff消耗类型选择")]
	public SkillCostEnum BuffCost = SkillCostEnum.All;

	[Name("Buff ID", 0)]
	[Description("指定buff消耗")]
	[ShowIf("BuffCost", 1)]
	public List<int> CertainBuffs;

	[Name("技能层数消耗", 0)]
	[Description("技能层数消耗类型选择")]
	public SkillCostEnum SkillLayerCost = SkillCostEnum.All;

	[Name("叠层技能ID", 0)]
	[Description("指定技能层数消耗")]
	[ShowIf("SkillLayerCost", 1)]
	public List<int> CertainSkillLayers;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = ownerEntity.GetComponent<SkillComponent>().GetSkillData(skillId.value);
		if (skillData == null)
		{
			EndAction();
			return;
		}
		skillData?.SkillCoolingData.ExcutePropertyConsume(PropertyCost, CertainPropertys);
		skillData?.SkillCoolingData.ExcuteBuffConsume(BuffCost, CertainBuffs);
		skillData?.SkillCoolingData.ExcuteSkillLayerConsume(SkillLayerCost, CertainSkillLayers);
		EndAction();
	}
}
