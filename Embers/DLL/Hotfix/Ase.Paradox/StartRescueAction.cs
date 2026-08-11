using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("开始救援", 0)]
[Description("根据是否成功开始救援，设置救援者ID。")]
[Category("✫ DragonLost/Entity")]
public class StartRescueAction : ActionTaskBase
{
	[Name("是否成功开始救援", 0)]
	[Description("指示是否成功开始救援")]
	public BBParameter<bool> IsStartRescue;

	[Name("救援者ID", 0)]
	[Description("成功开始救援的救援者的ID")]
	public BBParameter<int> EntityId;

	[Name("救援指令", 0)]
	[Description("救援指令")]
	public BBParameter<HeroSkillTypeEnum> Command;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = GetOwnerEntity();
		if (baseEntity == null || !baseEntity.IsSurvival)
		{
			OnActionFinish();
			return;
		}
		IsStartRescue.value = baseEntity.GetComponent<NearDeathRescueComponent>().StartRescue(Command.value, out var rescueEntityId);
		EntityId.value = rescueEntityId;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"开始救援  救援指令 : {Command.value} 是否成功开始救援 : {IsStartRescue.value} 救援者ID : {EntityId.value} ", ownerEntity);
		}
		OnActionFinish();
	}
}
