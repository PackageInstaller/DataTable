using Ase.ECS;
using Cysharp.Threading.Tasks;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("传送到场景固定点", 0)]
[Description("将实体传送到指定的场景固定点，可选择是否更新出生点。")]
[Category("✫ DragonLost/Interactive")]
public class TeleportToScenePointAction : ActionTaskBase
{
	[Name("传送点ID", 0)]
	[Description("传送点ID(变量描述)")]
	public BBParameter<int> teleportId;

	[Name("是否更新出生点", 0)]
	[Description("如果为 true，则更新实体的出生点为传送点位置。")]
	public bool updateBornPointKey;

	[Name("洞窟传送", 0)]
	[Description("选择传送类型，是进入洞窟还是离开洞窟。")]
	public CavesTransform CavesTransform;

	[Name("洞窟Id", 0)]
	[Description("进入洞窟的ID")]
	public BBParameter<int> CavesId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
		await UniTask.WaitForSeconds(1);
		GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId();
		GetOwnerEntity().GetSystem<SceneSystem>().SetCavesState(CavesTransform, CavesId.value);
		await GetOwnerEntity().GetSystem<SceneSystem>().Teleport(teleportId.value.ToString(), updateBornPointKey);
		await UniTask.WaitForEndOfFrame();
		await UniTask.WaitUntil(() => !GetOwnerEntity().GetSystem<VirtualCameraSystem>().IsBlendState());
		OnActionFinish();
		blackScreen.Dispose();
		OnActionFinish();
	}
}
