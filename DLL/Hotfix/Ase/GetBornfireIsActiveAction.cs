using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("获取篝火是否被激活", 0)]
[Description("获取篝火是否被激活。")]
[Category("✫ DragonLost/Interactive")]
public class GetBornfireIsActiveAction : ActionTaskBase
{
	[Name("篝火Id", 0)]
	[Description("篝火Id。")]
	public BBParameter<int> bornfireId = new BBParameter<int>();

	public BBParameter<bool> IsActive = false;

	protected override void OnExecute()
	{
		base.OnExecute();
		int levelId = GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
		IsActive.value = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetBornfireIsActive(levelId, bornfireId.value);
		OnActionFinish();
	}
}
