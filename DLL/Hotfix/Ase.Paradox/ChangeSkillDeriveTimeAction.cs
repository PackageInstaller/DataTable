using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改技能派生时间", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改技能派生时间")]
public class ChangeSkillDeriveTimeAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("修改的技能ID")]
	public BBParameter<int> SkillId;

	[Name("修改类型", 0)]
	[Description("修改类型")]
	public SkillDataChangeType CurrentChargeType;

	[Name("修改的派生时间", 0)]
	[Description("修改的派生时间")]
	public BBParameter<float> DeriveCurrentTime = 0f;

	[Name("是否修改总派生时间", 0)]
	[Description("是否修改总派生时间")]
	public bool ChangeDriveTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = GetOwnerEntity().GetComponent<SkillComponent>().GetSkillData(SkillId.value);
		if (skillData == null)
		{
			EndAction();
			return;
		}
		switch (CurrentChargeType)
		{
		case SkillDataChangeType.Set:
			skillData?.SkillDeriveData.SetDeriveTime(DeriveCurrentTime.value, ChangeDriveTime);
			break;
		case SkillDataChangeType.Add:
			skillData?.SkillDeriveData.ChangeDeriveTime(DeriveCurrentTime.value, ChangeDriveTime);
			break;
		case SkillDataChangeType.Dec:
			skillData?.SkillDeriveData.ChangeDeriveTime(0f - DeriveCurrentTime.value, ChangeDriveTime);
			break;
		}
		EndAction();
	}
}
