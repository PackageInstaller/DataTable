using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("增加战斗主相机的虚拟相机拷贝", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于在战斗主相机的基础上创建虚拟相机的拷贝")]
public class CreateBattleCameraCopy : ActionTaskBase
{
	[Name("相机主人实体Id", 0)]
	[Description("要创建虚拟相机的实体的ID。")]
	public BBParameter<int> ownerId;

	[Name("是否启用优先级影响", 0)]
	public bool IsOpenPriorityInf;

	[Name("相机优先级", 0)]
	[Description("新虚拟相机的优先级。")]
	public int priority = 10;

	[Name("返回的相机Id", 0)]
	[Description("新创建的虚拟相机的ID。")]
	public BBParameter<int> returnCamId;

	[Name("是否刷新列表", 0)]
	[Description("如果勾选，刷新相机列表。")]
	public BBParameter<bool> isFreshList;

	[Name("相机列表", 0)]
	[Description("用于记录新创建虚拟相机的ID列表。")]
	public BBParameter<List<int>> cameraIds;

	[Name("是否跟随行为树结束销毁", 0)]
	[Description("如果勾选，相机会随着行为树的结束而销毁。")]
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
