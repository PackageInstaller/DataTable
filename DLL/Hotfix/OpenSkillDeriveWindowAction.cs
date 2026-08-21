using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("开启技能的派生窗口", 0)]
[Category("✫ DragonLost/Skill")]
[Description("开启技能的派生窗口，指令绑定的技能将切换到派生的技能")]
public class OpenSkillDeriveWindowAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> CommandType;

	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	[Name("派生的技能ID", 0)]
	[Description("派生的技能将会绑定到指令上,且派生的技能必须是个派生技能")]
	public BBParameter<int> DeriveSkillId;

	[Name("派生的时间", 0)]
	[Description("此次派生的时间")]
	public BBParameter<float> DeriveTime;

	[Name("还原时间", 0)]
	[Description("此次派生结束后是否还原派生时间")]
	public BBParameter<bool> RestoreDeriveTime;

	[Name("派生次数", 0)]
	[Description("设置此次派生的次数")]
	public BBParameter<int> DeriveNumber;

	[Name("跟随行为树关闭窗口", 0)]
	public bool RestoreWindow;

	[Name("是否是状态派生", 0)]
	public bool IsStateDerive;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>()?.OpenSkillDeriveWindow(CommandType.value, SkillId.value, DeriveSkillId.value, DeriveTime.value, RestoreDeriveTime.value, DeriveNumber.value, IsStateDerive);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"开启技能的派生窗口  指令类型 ： {CommandType.value}  技能ID : {SkillId.value} 派生的技能ID : {DeriveSkillId.value} " + $" 派生的时间 : {DeriveTime.value} 还原时间 : {RestoreDeriveTime.value}  派生次数 : {DeriveNumber.value}  是否是状态派生 {IsStateDerive}", ownerEntity);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && RestoreWindow)
		{
			ownerEntity.GetComponent<SkillComponent>()?.HideSkillDeriveWindow(DeriveSkillId.value);
		}
	}
}
