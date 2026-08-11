using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Trigger("交互物2传送触发器")]
public class MapItem2TeleportEventTrigger : MapItemEventTrigger
{
	public string teleportId;

	public bool updateBornPointKey;

	public bool useBlack;

	public CavesTransform CavesTransform;

	public int CavesId;

	public override string TriggerName => "交互物-传送触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		BlackScreen blackScreen = null;
		if (useBlack)
		{
			blackScreen = await BlackScreen.Show("TIMELINE");
			await new WaitForSecondsRealtime(1f);
		}
		sceneSystem.SetCavesState(CavesTransform, CavesId);
		await sceneSystem.Teleport(teleportId, updateBornPointKey);
		await UniTask.WaitForEndOfFrame();
		await UniTask.WaitUntil(() => !sceneSystem.GetSystem<VirtualCameraSystem>().IsBlendState());
		await new WaitForSeconds(0.05f);
		blackScreen?.Dispose();
	}
}
