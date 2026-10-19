using ACT.Battle.Configs;
using ACT.UI;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.Actions;

public class LightTowerInteract : InteractAction
{
	public CinemachineVirtualCamera VirtualCamera;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_PHAROSPANEL, new PharosPanel.MyParam
		{
			LightHouseUId = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid,
			VirtualCamera = VirtualCamera
		});
		return UniTask.CompletedTask;
	}
}
