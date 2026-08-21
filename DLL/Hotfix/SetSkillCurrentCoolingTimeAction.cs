using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("修改技能的当前冷却时间", 0)]
[Category("✫ DragonLost/Skill")]
[Description("填入的冷却时间进入系统加减处理,正数增加技能CD")]
public class SetSkillCurrentCoolingTimeAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("冷却时间", 0)]
	[Description("冷却时间")]
	public BBParameter<float> CoolingTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<CoolingComponent>().ReviseCurrentCoolingTime(SkillId.value, CoolingTime.value);
		EndAction();
	}
}
