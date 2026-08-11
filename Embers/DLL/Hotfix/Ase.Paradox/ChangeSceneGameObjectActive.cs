using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("改变场景物体激活状态", 0)]
[Category("✫ DragonLost/Scene")]
[Description("改变场景物体激活状态")]
public class ChangeSceneGameObjectActive : ActionTaskBase
{
	[Name("场景物体Key", 0)]
	[Description("在场景中添加物体的Key")]
	public int GoKey;

	[Name("场景物体的激活状态", 0)]
	[Description("改变场景物体的激活状态")]
	public bool ActiveGo;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<SceneSystem>().ChangeSceneGobjActive(GoKey, ActiveGo);
		OnActionFinish();
	}
}
