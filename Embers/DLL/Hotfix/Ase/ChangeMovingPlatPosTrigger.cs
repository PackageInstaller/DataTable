using UnityEngine;

namespace Ase;

[Trigger("修改移动平台位置触发器")]
public class ChangeMovingPlatPosTrigger : BaseTrigger
{
	public int MovingPlatId;

	public Vector3 NewPos;

	public override string TriggerName => "修改移动平台位置触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		LevelMapData levelMapData = sceneSystem.GetLevelMapData();
		if ((Object)(object)levelMapData != null)
		{
			levelMapData.SetMovingPlatPos(MovingPlatId, NewPos);
		}
	}
}
