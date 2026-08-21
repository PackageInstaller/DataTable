using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("修改技能的冷却时间", 0)]
[Category("✫ DragonLost/Skill")]
[Description("动态去修改技能的冷却时间")]
public class SetSkillCoolingTimeAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("冷却时间", 0)]
	[Description("冷却时间")]
	public BBParameter<float> CoolingTime;

	[Name("还原冷却时间", 0)]
	[Description("在行为树结束时还原数据")]
	public bool RestoreCacheTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<CoolingComponent>().SetCoolingTime(SkillId.value, CoolingTime.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && RestoreCacheTime)
		{
			ownerEntity.GetComponent<CoolingComponent>().ResetCoolingTime(SkillId.value);
		}
	}
}
