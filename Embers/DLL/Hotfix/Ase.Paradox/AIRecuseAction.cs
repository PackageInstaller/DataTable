using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("AI救援", 0)]
[Description("根据是否成功开始救援，设置救援者ID。")]
[Category("✫ DragonLost/Entity")]
public class AIRecuseAction : ActionTaskBase
{
	[Name("是否成功开始救援", 0)]
	[Description("指示是否成功开始救援")]
	public BBParameter<bool> IsStartRescue;

	[Name("救援者ID", 0)]
	[Description("成功开始救援的救援者的ID")]
	public BBParameter<int> EntityId;

	[Name("倒地实体ID", 0)]
	[Description("被救援的实体ID")]
	public BBParameter<int> WoundEntityId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = GetOwnerEntity();
		if (baseEntity == null || !baseEntity.IsSurvival)
		{
			OnActionFinish();
			return;
		}
		IsStartRescue.value = baseEntity.GetComponent<NearDeathRescueComponent>().AIRecuse(WoundEntityId.value, out var rescueEntityId);
		EntityId.value = rescueEntityId;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"AI救援 ： 救援的实体ID {rescueEntityId}  是否开始救援 ： {IsStartRescue.value} ", ownerEntity);
		}
		OnActionFinish();
	}
}
