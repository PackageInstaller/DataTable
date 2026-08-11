using UnityEngine;

namespace Ase;

[Trigger("交互物2移动平台触发器")]
public class MapItem2MovingPlatformEventTrigger : MapItemEventTrigger
{
	public int[] MovingPlatformId;

	public bool IsPause;

	public bool IsChangePaltformParam;

	public MovingPlatform.WrapMode WrapMode;

	public float NewTime;

	public AnimationCurve CurveX;

	public AnimationCurve CurveY;

	public AnimationCurve CurveZ;

	public override string TriggerName => "交互物-移动平台触发器";

	public override void OnDisposed()
	{
	}

	protected override void DoExecute()
	{
		base.DoExecute();
		if (sceneSystem == null)
		{
			return;
		}
		LevelMapData levelMapData = sceneSystem.GetLevelMapData();
		if (!((Object)(object)levelMapData != null) || MovingPlatformId == null || MovingPlatformId.Length == 0)
		{
			return;
		}
		int[] movingPlatformId = MovingPlatformId;
		foreach (int movingPaltformId in movingPlatformId)
		{
			levelMapData.SetMovingPaltformPauseById(movingPaltformId, IsPause);
			if (IsChangePaltformParam)
			{
				levelMapData.ChangeMovingPlatformParamById(movingPaltformId, WrapMode, NewTime, CurveX, CurveY, CurveZ);
			}
		}
	}
}
