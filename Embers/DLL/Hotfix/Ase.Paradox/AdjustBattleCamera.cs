using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改战斗主相机 弃用", 0)]
[Description("用于修改战斗主相机的各项参数")]
[Category("✫ DragonLost/Camera")]
public class AdjustBattleCamera : ActionTaskBase
{
	[Name("角色实体id", 0)]
	[Description("填0时，修改所有玩家的战斗主相机")]
	public BBParameter<int> entityId;

	[Name("是否修改偏移", 0)]
	[Description("指示是否修改相机的关注点相对目标实体的偏移")]
	public bool IsChangeOffset;

	[Name("关注点相对目标实体的偏移", 0)]
	[ShowIf("IsChangeOffset", 1)]
	[Description("相机的焦点位置相对于目标实体的偏移量")]
	public BBParameter<Vector3> offset = new Vector3(0f, 0f, 0f);

	[Name("是否修改优先级", 0)]
	[Description("指示是否修改相机的渲染优先级")]
	public bool IsChangePriority;

	[Name("相机优先级", 0)]
	[ShowIf("IsChangePriority", 1)]
	[Description("相机的渲染优先级")]
	public int priority = 10;

	[Name("是否修改广角", 0)]
	[Description("指示是否修改相机的广角参数")]
	public bool IsChangeFOV;

	[Name("广角参数", 0)]
	[ShowIf("IsChangeFOV", 1)]
	[Description("相机的广角参数")]
	public float fieldOfView = 15f;

	[Name("是否修改主相机关注目标", 0)]
	[Description("指示是否修改相机关注的目标实体")]
	public bool IsChangeFollowTrans;

	[Name("关注目标实体id", 0)]
	[ShowIf("IsChangeFollowTrans", 1)]
	[Description("相机关注的目标实体的ID")]
	public BBParameter<int> followTarget;

	[Name("是否跟随行为树结束还原", 0)]
	[Description("指示是否在行为树结束时还原相机参数")]
	public bool IsReset;

	private bool isAlreadySet;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}

	private void ChangeFollowTrans()
	{
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
	}
}
