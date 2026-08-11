using System.Collections.Generic;
using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

[Name("技能执行状态", 0)]
[Category("✫ DragonLost/Entity")]
[Description("设置技能的执行状态，例如开始执行、执行中、执行结束等。")]
public class SkillExecuteStateAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("要设置执行状态的技能的标识符。")]
	public BBParameter<int> SkillId;

	[Name("技能标签", 0)]
	[Description("要释放的技能标签。")]
	public BBParameter<string> skillLabel;

	[Name("执行状态", 0)]
	[Description("要设置的技能执行状态。")]
	public SkillExecuteState SkillExecuteState;

	[Name("技能位置", 0)]
	[Description("技能释放的位置（主要用于道具技能）。")]
	public BBParameter<Vector3> SkillPosition;

	[ShowIf("SkillExecuteState", 2)]
	[Name("是否进入CD", 0)]
	[Description("执行技能时是否进入CD")]
	public bool IsCd;

	[ShowIf("SkillExecuteState", 2)]
	[Name("同时进入CD的技能ID", 0)]
	[Description("设置其他技能一起进入CD,会动态修改技能的CD")]
	public BBParameter<List<int>> CdSkillList;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().ExecuteSkillTiming(SkillExecuteState, SkillId?.value ?? 0, skillLabel?.value, SkillPosition?.value ?? Vector3.zero, IsCd, CdSkillList?.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"技能执行状态  技能ID : {SkillId?.value ?? 0} 技能标签 : {skillLabel?.value}  执行状态 : {SkillExecuteState} " + $"技能位置 : {SkillPosition?.value ?? Vector3.zero}  是否进入CD : {IsCd}", ownerEntity);
		}
		EndAction();
	}
}
