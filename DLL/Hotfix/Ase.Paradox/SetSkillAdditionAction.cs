using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改技能加成", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改实体的特定技能的加成值。")]
public class SetSkillAdditionAction : ActionTaskBase
{
	[Name("是否是全局加成", 0)]
	[Description("指示是否应用于所有技能，而不仅仅是特定类型的技能。")]
	public bool IsGlobalAddition;

	[HideIf("IsGlobalAddition", 1)]
	[Name("技能加成类型", 0)]
	[Description("根据技能ID or 技能指令")]
	public SkillAdditionType AdditionType;

	[HideIf("IsGlobalAddition", 1)]
	[ShowIf("AdditionType", 0)]
	[Name("技能id", 0)]
	[Description("要修改加成的技能ID。")]
	public int SkillId;

	[HideIf("IsGlobalAddition", 1)]
	[ShowIf("AdditionType", 1)]
	[Name("指令类型", 0)]
	[Description("要修改指令加成")]
	public HeroSkillTypeEnum HeroSkillTypeEnum;

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

	private float addition;

	protected override void OnExecute()
	{
		base.OnExecute();
		addition = Addition.value;
		if (IsGlobalAddition)
		{
			ownerEntity.GetComponent<SkillComponent>()?.GlobalAddition(AdditionKind, addition);
		}
		else
		{
			ownerEntity.GetComponent<SkillComponent>()?.SkillAddition(SkillId, HeroSkillTypeEnum, AdditionKind, addition, AdditionType);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && RefreshAddition)
		{
			if (IsGlobalAddition)
			{
				ownerEntity.GetComponent<SkillComponent>()?.GlobalAddition(AdditionKind, 0f - addition);
			}
			else
			{
				ownerEntity.GetComponent<SkillComponent>()?.SkillAddition(SkillId, HeroSkillTypeEnum, AdditionKind, 0f - addition, AdditionType);
			}
		}
	}
}
