using System.Collections.Generic;
using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("设置指令的打断窗口", 0)]
[Category("✫ DragonLost/Skill")]
[Description("设置技能的打断窗口,系统只是定义的这个窗口")]
public class SkillBreakWindowAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> SkillType;

	[Name("可以打断的指令", 0)]
	[Description("设置指令可以打断上面的指令")]
	public BBParameter<List<HeroSkillTypeEnum>> BreakSkillTypeList;

	[Name("开启打断", 0)]
	[Description("开启指令的打断")]
	public bool OpenBreak;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().SetCommandBreak(SkillType.value, BreakSkillTypeList.value, OpenBreak);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"设置指令的打断窗口  指令类型 ： {SkillType.value} OpenBreak : {OpenBreak} ", ownerEntity);
		}
		EndAction();
	}
}
