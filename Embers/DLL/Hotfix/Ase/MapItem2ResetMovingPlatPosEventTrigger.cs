using UnityEngine;

namespace Ase;

[Trigger("交互物2修改移动平台位置当前位置")]
public class MapItem2ResetMovingPlatPosEventTrigger : MapItemEventTrigger
{
	public int MovingPlatformId;

	public Vector3 NewPos;

	public override string TriggerName => "交互物-交互物2修改移动平台位置当前位置";

	protected override async void DoExecute()
	{
		base.DoExecute();
		LevelMapData levelMapData = sceneSystem.GetLevelMapData();
		if ((Object)(object)levelMapData != null)
		{
			levelMapData.SetMovingPlatPos(MovingPlatformId, NewPos);
		}
	}
}
