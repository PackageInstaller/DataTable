using UnityEngine;

namespace Ase;

[Trigger("移动平台触发器")]
public class MovingPlatformPauseTrigger : BaseTrigger
{
	public int[] MovingPlatformId;

	public bool IsPause;

	public bool IsChangePaltformParam;

	public MovingPlatform.WrapMode WrapMode;

	public float NewTime;

	public AnimationCurve CurveX;

	public AnimationCurve CurveY;

	public AnimationCurve CurveZ;

	public override string TriggerName => "移动平台触发器";

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
		for (int i = 0; i < MovingPlatformId.Length; i++)
		{
			levelMapData.SetMovingPaltformPauseById(MovingPlatformId[i], IsPause);
			if (IsChangePaltformParam)
			{
				levelMapData.ChangeMovingPlatformParamById(MovingPlatformId[i], WrapMode, NewTime, CurveX, CurveY, CurveZ);
			}
		}
	}
}
