using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("获取宝箱是否被开启", 0)]
[Description("获取宝箱是否被开启。")]
[Category("✫ DragonLost/Interactive")]
public class GetTreasureOpenAction : ActionTaskBase
{
	public BBParameter<bool> IsOpen = false;

	protected override void OnExecute()
	{
		base.OnExecute();
		int levelId = GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
		int data = GetOwnerEntity().GetData<int>(MapItemNode.MAPITEMUID);
		IsOpen.value = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetTreasureIsOpen(levelId, data);
		OnActionFinish();
	}
}
