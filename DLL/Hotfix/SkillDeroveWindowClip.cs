using Ase;
using Ase.ECS;

[ClipName("开启技能派生窗口Clip")]
public class SkillDeroveWindowClip : TaskClip
{
	[VariableName("指令类型")]
	public HeroSkillTypeEnum commandType;

	[VariableName("技能ID")]
	public int skillId;

	[VariableName("派生的技能ID")]
	public int deriveSkillId;

	[VariableName("派生的时间")]
	public float deriveTime;

	[VariableName("还原时间")]
	public bool restoreDeriveTime;

	[VariableName("派生次数")]
	public int deriveNumber;

	[VariableName("跟随行为树关闭窗口")]
	public bool restoreWindow;

	[VariableName("是否是状态派生")]
	public bool isStateDerive;

	public override void OnRunTimeEnter(BaseEntity context, int fps, int currentFrameID)
	{
		base.OnRunTimeEnter(context, fps, currentFrameID);
		context.GetComponent<SkillComponent>()?.OpenSkillDeriveWindow(commandType, skillId, deriveSkillId, deriveTime, restoreDeriveTime, deriveNumber, isStateDerive);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"开启技能的派生窗口  指令类型 ： {commandType}  技能ID : {skillId} 派生的技能ID : {deriveSkillId} " + $" 派生的时间 : {deriveTime} 还原时间 : {restoreDeriveTime}  派生次数 : {deriveNumber}  是否是状态派生 {isStateDerive}", context);
		}
	}
}
