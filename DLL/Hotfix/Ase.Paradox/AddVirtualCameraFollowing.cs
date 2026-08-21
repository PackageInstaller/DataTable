using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("增加跟随目标的虚拟相机  (弃用)", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于在场景中增加跟随目标的虚拟相机")]
public class AddVirtualCameraFollowing : ActionTaskBase
{
	[Name("关注点相对目标实体的偏移量", 0)]
	[Description("虚拟相机的焦点位置相对于目标实体的偏移量")]
	public Vector3 offset = Vector3.zero;

	[Name("相对主相机的相机角度的绝对偏移", 0)]
	[Description("虚拟相机的角度相对于主相机角度的偏移")]
	public Vector3 rotate = Vector3.zero;

	[Name("相机优先级", 0)]
	[Description("虚拟相机的渲染优先级")]
	public int priority = 10;

	[Name("返回的相机Id", 0)]
	[Description("新创建的虚拟相机的ID")]
	public BBParameter<int> returnCamId;

	[Name("广角参数", 0)]
	[Description("虚拟相机的广角参数")]
	public float FieldOfView = 15f;

	[Name("是否跟随行为树结束销毁", 0)]
	[Description("是否在行为树结束时销毁虚拟相机")]
	public bool isFollowDispose;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
	}
}
