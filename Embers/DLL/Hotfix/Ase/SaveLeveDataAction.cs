using ParadoxNotion.Design;

namespace Ase;

[Name("保存关卡", 0)]
[Description("保存当前关卡数据。")]
[Category("✫ DragonLost/Interactive")]
public class SaveLeveDataAction : ActionTaskBase
{
	protected override async void OnExecute()
	{
		base.OnExecute();
		await Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId());
		OnActionFinish();
	}
}
