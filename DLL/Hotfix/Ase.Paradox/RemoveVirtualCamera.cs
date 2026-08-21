using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("移除虚拟相机 (弃用)", 0)]
[Category("✫ DragonLost/Camera")]
[Description("移除指定的虚拟相机，并解除实体绑定的虚拟相机")]
public class RemoveVirtualCamera : ActionTaskBase
{
	[Name("相机Id", 0)]
	[Description("要移除的虚拟相机的ID列表。")]
	public BBParameter<List<int>> camId;

	[Name("实体Id", 0)]
	[Description("要解除绑定的实体的ID。")]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
