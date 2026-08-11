using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查技能层数", 0)]
[Category("✫ DragonLost/Skill")]
[Description("用于检查技能层数是否满足条件")]
public class CheckSkillLayerAction : ConditionTaskBase
{
	[Name("技能ID", 0)]
	[RequiredField]
	[Description("要比较的技能ID")]
	public BBParameter<int> skillId;

	[Name("比较类型", 0)]
	[RequiredField]
	[Description("用于比较层数的方法")]
	public BBParameter<CompareMethodType> methodType;

	[Name("层数", 0)]
	[RequiredField]
	[Description("要比较的层数")]
	public BBParameter<int> checkLayer;

	protected override bool OnCheck()
	{
		base.OnCheck();
		SkillComponent component = ownerEntity.GetComponent<SkillComponent>();
		HeroSkillData heroSkillData = null;
		if (component != null)
		{
			heroSkillData = component.GetSkillData(skillId.value);
		}
		int num = heroSkillData?.CacheLayer ?? 0;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"SkillId :{skillId.value}  检查技能层数  {num}  checkLayer  {checkLayer}", ownerEntity);
		}
		return ConditionExtensions.CompareValueMethod(methodType.value, heroSkillData.CacheLayer, checkLayer.value);
	}
}
