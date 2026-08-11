using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("改变技能指示器参数", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改技能指示器的参数")]
public class SkillIndicatorChangeAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("最大技能范围", 0)]
	[Description("最大技能范围")]
	public float ChangeSkillRange;

	[Name("技能范围插值帧数", 0)]
	[Description("技能范围插值帧数")]
	public float ChangeSkillRangeTime;

	[Name("最大技能宽度", 0)]
	[Description("技能ID")]
	public float ChangeSkillWidth;

	[Name("技能宽度插值帧数", 0)]
	[Description("技能宽度插值帧数")]
	public float ChangeSkillWidthTime;

	[Name("最大技能角度", 0)]
	[Description("最大技能角度")]
	public float ChangeSkillAngle;

	[Name("技能角度插值帧数", 0)]
	[Description("技能角度插值帧数")]
	public float ChangeSkillAngleTime;

	private SkillIndicatorEntity skillIndicatorEntity;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = GetOwnerEntity().GetComponent<SkillComponent>().GetSkillData(SkillId.value);
		if (skillData == null)
		{
			EndAction();
			return;
		}
		skillData.RunTimeChangeIndicator(ChangeSkillRange, ChangeSkillRangeTime, ChangeSkillWidth, ChangeSkillWidthTime, ChangeSkillAngle, ChangeSkillAngleTime);
		EndAction();
	}
}
