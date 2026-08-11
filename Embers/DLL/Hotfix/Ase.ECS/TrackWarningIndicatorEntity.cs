namespace Ase.ECS;

public class TrackWarningIndicatorEntity : WarningIndicatorEntity
{
	private bool _isStopTrack;

	private BaseEntity _targetEntity;

	public TrackWarningIndicatorData trackData;

	public BaseEntity TargetEntity => _targetEntity;

	public bool IsStopTrack => _isStopTrack;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_isStopTrack = false;
		trackData = userData as TrackWarningIndicatorData;
		if (trackData != null)
		{
			_targetEntity = world.GetSystem<EntitySystem>().GetEntity(trackData.TargetId);
		}
	}

	public void SetTrackState(bool state)
	{
		_isStopTrack = state;
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		_targetEntity = null;
		_isStopTrack = false;
	}
}
