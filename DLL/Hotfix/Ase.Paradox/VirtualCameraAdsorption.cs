#define ENABLE_LOG
using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("相机吸附", 0)]
[Description("开启或关闭相机吸附功能")]
[Category("✫ DragonLost/Camera")]
public class VirtualCameraAdsorption : ActionTaskBase
{
	[Name("是否开启相机吸附", 0)]
	[Description("指示是否开启相机吸附功能")]
	public bool isCameraAdsorption = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		VirtualCameraSystem system = ownerEntity.GetSystem<VirtualCameraSystem>();
		if (system == null)
		{
			LogActionError("未能获取虚拟相机系统，相机吸附功能开启失败");
		}
		else if (isCameraAdsorption)
		{
			system.OpenAdsorption();
		}
		else
		{
			system.HideAdsorption();
		}
		OnActionFinish();
	}
}
