using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("修改技能的充能次数", 0)]
[Category("✫ DragonLost/Skill")]
[Description("只有充能技能才会生效")]
public class AmendSkillChargeNumberAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("充能次数", 0)]
	[Description("直接修改技能的当前充能次数")]
	public BBParameter<int> ChargeTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<CoolingComponent>().AmendSkillCurrentChargeTime(SkillId.value, ChargeTime.value);
		EndAction();
	}
}
