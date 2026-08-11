using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("激活篝火", 0)]
[Description("更新指定篝火的激活状态。")]
[Category("✫ DragonLost/Interactive")]
public class UpdateBonfireActiveStateAction : ActionTaskBase
{
	[Name("篝火Id", 0)]
	[Description("要更新激活状态的篝火的Id。")]
	public BBParameter<int> bonfireId;

	[Name("是否更新状态成功", 0)]
	[Description("返回值，是否激活篝火成功")]
	public BBParameter<bool> IsScuess;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BBParameter<bool> isScuess = IsScuess;
		isScuess.value = await Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateBonfireMapMaskState(GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId(), bonfireId.value, 0L);
		OnActionFinish();
	}
}
