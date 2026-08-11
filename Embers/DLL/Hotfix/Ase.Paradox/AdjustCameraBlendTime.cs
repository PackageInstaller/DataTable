using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改相机过渡时间", 0)]
[Category("✫ DragonLost/Camera")]
[Description("用于修改相机过渡时间")]
public class AdjustCameraBlendTime : ActionTaskBase
{
	[Name("过渡时间", 0)]
	[Description("相机切换过渡的时间长度")]
	public float blendTime = 0.3f;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<VirtualCameraSystem>() != null)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>().AdjustBlendTime(blendTime);
			EndAction();
		}
	}
}
