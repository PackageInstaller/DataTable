using System.Collections.Generic;
using Ase;
using Ase.ECS;
using UnityEngine;

[ClipName("执行技能状态")]
public class ExecuteSkillStateClip : TaskClip
{
	[VariableName("技能ID")]
	public int skillId;

	[VariableName("技能标签")]
	public string skillLabel;

	[VariableName("执行状态")]
	public SkillExecuteState skillExecuteState;

	[VariableName("技能位置")]
	public Vector3 skillPosition;

	[VariableName("是否进入CD")]
	public bool isCd;

	[VariableName("同时进入CD的技能ID")]
	public List<int> cdSkillList;

	public override void OnRunTimeEnter(BaseEntity context, int fps, int currentFrameID)
	{
		base.OnRunTimeEnter(context, fps, currentFrameID);
		context.GetComponent<SkillComponent>().ExecuteSkillTiming(skillExecuteState, skillId, skillLabel, skillPosition, isCd, cdSkillList);
	}
}
