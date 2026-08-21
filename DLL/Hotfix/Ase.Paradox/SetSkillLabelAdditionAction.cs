using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Pool;

namespace Ase.Paradox;

[Name("修改技能加成（根据技能标签）", 0)]
[Category("✫ DragonLost/Skill")]
[Description("根据技能标签修改实体的特定技能的加成值。")]
public class SetSkillLabelAdditionAction : ActionTaskBase
{
	[Name("技能标签", 0)]
	[Description("要修改加成的技能ID。")]
	public string SkillLabel;

	[Name("加成种类", 0)]
	[Description("指定加成的具体种类，如攻击力、防御力等。")]
	public AdditionKind AdditionKind;

	[SliderField(-1, 5)]
	[Name("加成", 0)]
	[Description("要添加或减少的加成值。")]
	public BBParameter<float> Addition;

	[Name("重置技能加成", 0)]
	[Description("指示在行为树结束时是否应重置技能的加成值。")]
	public bool RefreshAddition;

	private List<HeroSkillData> heroSkillDataList;

	protected override void OnExecute()
	{
		base.OnExecute();
		SkillComponent component = ownerEntity.GetComponent<SkillComponent>();
		if (component == null)
		{
			return;
		}
		heroSkillDataList = component.GetSkillDataListByLabel(SkillLabel);
		if (heroSkillDataList == null)
		{
			return;
		}
		foreach (HeroSkillData heroSkillData in heroSkillDataList)
		{
			heroSkillData.SetSkillAddition(AdditionKind, Addition.value);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (heroSkillDataList == null)
		{
			return;
		}
		if (ownerEntity != null && RefreshAddition && ownerEntity.GetComponent<SkillComponent>() != null)
		{
			foreach (HeroSkillData heroSkillData in heroSkillDataList)
			{
				heroSkillData.SetSkillAddition(AdditionKind, 0f - Addition.value);
			}
		}
		CollectionPool<List<HeroSkillData>, HeroSkillData>.Release(heroSkillDataList);
	}
}
