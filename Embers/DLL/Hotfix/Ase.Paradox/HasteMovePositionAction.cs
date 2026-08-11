using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("闪现到目标位置", 0)]
[Description("立即将实体移动到指定的目标位置。可以选择是否忽略地形碰撞。(带偏移)")]
[Category("✫ DragonLost/Transform")]
public class HasteMovePositionAction : ActionTaskBase
{
	[Name("无视地形", 0)]
	[Description("如果勾选，将忽略地形碰撞，直接移动到目标位置。")]
	public bool ignoreCollider;

	[Name("目标位置", 0)]
	[Description("要移动到的目标位置。")]
	public BBParameter<Vector3> targetBBP;

	private int waitFrameCount;

	private float offset;

	protected override void OnExecute()
	{
		base.OnExecute();
		Vector3 value = targetBBP.value;
		value.x += offset;
		value.z += offset;
		BattleWorldMode battleMode = ownerEntity.GetSystem<BattleSystem>().BattleMode;
		if (battleMode == BattleWorldMode.SyncBattle || battleMode == BattleWorldMode.GameBack)
		{
			ownerEntity.GetComponent<KinematicMoveComponent>().SetPosition(value, "闪现到目标位置.ignoreCollider = false");
		}
		else if (!ignoreCollider)
		{
			ownerEntity.GetComponent<KinematicMoveComponent>().SetPosition(value, "闪现到目标位置.ignoreCollider = false", MovePriority.HasteMove);
		}
		else
		{
			ownerEntity.GetComponent<KinematicMoveComponent>().Teleport(value);
			OnActionFinish();
		}
		waitFrameCount = 0;
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (waitFrameCount++ == 1)
		{
			OnActionFinish();
		}
	}
}
