using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改虚拟相机广角与优先级 （弃用）", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改虚拟相机的广角和优先级")]
public class AdjustVirtualCamera : ActionTaskBase
{
	[Name("相机Id", 0)]
	[Description("要修改的虚拟相机的Id")]
	public BBParameter<int> camId;

	[Name("是否修改优先级", 0)]
	[Description("是否修改虚拟相机的优先级")]
	public bool IsChangePriority;

	[Name("相机优先级", 0)]
	[ShowIf("IsChangePriority", 1)]
	[Description("虚拟相机的新优先级")]
	public int priority = 10;

	[Name("是否修改广角", 0)]
	[Description("是否修改虚拟相机的广角")]
	public bool IsChangeFOV;

	[Name("广角参数", 0)]
	[ShowIf("IsChangeFOV", 1)]
	[Description("虚拟相机的新广角")]
	public float fieldOfView = 15f;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
