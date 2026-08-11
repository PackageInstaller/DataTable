using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("设置玩家输入的移动方向", 0)]
[Description("修改玩家大遥感位移的方向，改为该节点传入的方向")]
[Category("✫ DragonLost/Entity")]
public class ChangePlayerMoveDirAction : ActionTaskBase
{
	[Name("新的位移方向", 0)]
	[Description("设置新的玩家位移的方向")]
	public BBParameter<Vector2> MoveDir;

	[Name("是否开启修改玩家位移方向", 0)]
	[Description("开启修改方向开关")]
	public bool IsOpenChangeMoveDir;

	[Name("是否随行为树还原", 0)]
	public bool IsRefreshOnTreeStop;

	protected override void OnExecute()
	{
		base.OnExecute();
		MoveComponent component = ownerEntity.GetComponent<MoveComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		component.ChangePlayerMoveDir(MoveDir.value, IsOpenChangeMoveDir);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"设置玩家输入的移动方向 ： {MoveDir.value} 是否开启修改玩家位移方向 ：{IsOpenChangeMoveDir} ", ownerEntity);
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && IsRefreshOnTreeStop)
		{
			MoveComponent component = ownerEntity.GetComponent<MoveComponent>();
			if (component == null)
			{
				OnActionFail();
			}
			else
			{
				component.ChangePlayerMoveDir(Vector2.zero, openChangeDir: false);
			}
		}
	}
}
