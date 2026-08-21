using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("获取技能的充能次数", 0)]
[Category("✫ DragonLost/Skill")]
[Description("只有充能技能才会生效")]
public class GetSkillChargeNumber : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("充能次数", 0)]
	[Description("获取到技能的当前充能次数")]
	public BBParameter<int> ChargeTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		ChargeTime.value = ownerEntity.GetComponent<CoolingComponent>().GetSkillChargeNumber(SkillId.value);
		EndAction();
	}
}
