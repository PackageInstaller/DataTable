using TrueSync;
using UnityEngine;

public class AdventureLevelAdjustment : MonoBehaviour
{
	public TSVector2 SceneOffset;

	private void Awake()
	{
		AdventureModuleConfigureData config = AdventureModuleController.Config;
		TSVector2 tSVector = ((AdventureModuleController.sceneLimitZoneType != AdventureModuleController.SceneLimitZoneType._256x256) ? config.Level_MaxSceneSize : config.Level_MaxSceneSize_Min);
		TSVector2 tSVector2 = tSVector;
		FP x = SceneOffset.x - tSVector2.x * 0.5;
		FP y = SceneOffset.y - tSVector2.y * 0.5;
		AdventureModuleController.sceneLimitZone = new TSRect(x, y, tSVector2.x, tSVector2.y);
	}
}
