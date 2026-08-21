using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Serialization;

[Name("判断是否能释放技能", 0)]
[Category("✫ DragonLost/Skill")]
[Description("检查是否可以释放指定类型的技能")]
public class CanReleaseSkillCondition : ConditionTaskBase
{
	[FormerlySerializedAs("skillType")]
	[Name("技能ID", 0)]
	[Description("要检查是否可以释放的技能类型")]
	public BBParameter<int> SkillId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		bool result = ownerEntity.GetComponent<SkillComponent>()?.IsCanReleaseSkill(SkillId.value) ?? false;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"判断是否能释放技能 技能ID : {SkillId.value}", ownerEntity);
		}
		return result;
	}
}
