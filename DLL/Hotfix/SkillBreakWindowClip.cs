using System.Collections.Generic;
using Ase;
using Ase.ECS;

[ClipName("技能打断窗口")]
public class SkillBreakWindowClip : TaskClip
{
	[VariableName("指令类型")]
	public HeroSkillTypeEnum skillType;

	[VariableName("可以打断的指令")]
	public List<HeroSkillTypeEnum> breakSkillTypeList = new List<HeroSkillTypeEnum>();

	[VariableName("开启打断")]
	public bool openBreak;

	public override void OnRunTimeEnter(BaseEntity context, int fps, int currentFrameID)
	{
		base.OnRunTimeEnter(context, fps, currentFrameID);
		context.GetComponent<SkillComponent>().SetCommandBreak(skillType, breakSkillTypeList, openBreak);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"设置指令的打断窗口  指令类型 ： {skillType} OpenBreak : {openBreak} ", context);
		}
	}
}
