using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置实体无视脉冲", 0)]
[Category("✫ DragonLost/Camera")]
[Description("脉冲不会影响到该实体")]
public class EntityIgnoreImpulseAction : ActionTaskBase
{
	[Name("是否忽略脉冲影响", 0)]
	[Description("是否忽略脉冲影响")]
	public bool IgnoreImpulse;

	[Name("实体ID", 0)]
	[Description("实体ID")]
	public BBParameter<int> EntityId;

	[Name("是否随行为树结束关闭无视", 0)]
	[Description("当行为树结束时无论当前是否无视脉冲都设置为不无视脉冲")]
	public bool FollowTreeCloseIgnore;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<VirtualCameraSystem>()?.SetIgnoreImpulse(IgnoreImpulse, EntityId.value);
		OnActionFinish();
	}

	protected override void OnStop(bool interrupted)
	{
		base.OnStop(interrupted);
		if (FollowTreeCloseIgnore)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>()?.SetIgnoreImpulse(ignoreImpulse: false, EntityId.value);
		}
	}
}
