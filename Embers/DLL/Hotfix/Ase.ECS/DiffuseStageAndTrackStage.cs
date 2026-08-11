namespace Ase.ECS;

public class DiffuseStageAndTrackStage : BaseStage
{
	public bool isTrack;

	private TrackWarningIndicatorData _trackData;

	public override void InitStage(WarningIndicatorStageSwitcher switcher, WarningIndicatorData warnData)
	{
		base.InitStage(switcher, warnData);
		isTrack = true;
		_trackData = warnData as TrackWarningIndicatorData;
	}

	public override void Update(float dateTime)
	{
		if (timer >= _trackData.MoveTimer && isTrack)
		{
			SetTargetEntityEndPos();
			isTrack = false;
		}
		base.Update(dateTime);
	}

	protected override void ChangeStage(WarningIndicatorStageSwitcher switcher)
	{
		base.ChangeStage(switcher);
		switcher.ChangeStage<DelayLifeTimeStage>(timerData.delayLifeTimer);
	}

	private void SetTargetEntityEndPos()
	{
	}

	protected override void StageOver()
	{
		if (_trackData.MoveTimer == base.StageTimer)
		{
			SetTargetEntityEndPos();
		}
	}
}
