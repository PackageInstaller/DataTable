using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("Boss被击倒时间更新", 0)]
[Category("✫ Entity")]
[Description("Boss被击倒时间更新(节点描述)")]
public class BossDownStageAction : ActionTaskBase
{
	[RequiredField]
	[Name("被击倒时长", 0)]
	[Description("被击倒状态的剩余时长百分比。")]
	public BBParameter<float> downTime;

	[Name("是否跟随行为树结束重置", 0)]
	[Description("指示是否在行为树结束时重置被击倒状态。")]
	public bool followTreeRecovery = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().SetBossDownFillMax(downTime.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		if (followTreeRecovery)
		{
			ownerEntity?.GetSystem<BattleSystem>()?.SetBossDownFillMax(0f);
		}
	}
}
