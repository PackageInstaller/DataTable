using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("开始特效截屏", 0)]
[Category("✫ DragonLost/Effect")]
[Description("必须在破碎效果之前调用这个节点，防止破碎效果加载上来是黑色的...")]
public class StartCaptureAction : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<SceneSystem>().StartCapture();
		OnActionFinish();
	}
}
