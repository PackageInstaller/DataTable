using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("修改技能的充能时间", 0)]
[Category("✫ DragonLost/Skill")]
[Description("只有充能技能才会生效")]
public class AmendSkillChargeTimeAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("充能时间", 0)]
	[Description("充能时间")]
	public BBParameter<float> ChargeTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<CoolingComponent>().AmendSkillChargeTime(SkillId.value, ChargeTime.value);
		EndAction();
	}
}
