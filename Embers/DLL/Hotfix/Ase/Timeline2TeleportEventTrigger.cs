using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Trigger("Timeline2传送")]
public class Timeline2TeleportEventTrigger : TimelineEventTrigger
{
	public string teleportId;

	public bool updateBornPointKey;

	public bool useBlack;

	public float blackScreenTime = 0.05f;

	public CavesTransform CavesTransform;

	public int CavesId;

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
		await UniTask.WaitForSeconds(blackScreenTime);
		blackScreen?.Dispose();
	}
}
