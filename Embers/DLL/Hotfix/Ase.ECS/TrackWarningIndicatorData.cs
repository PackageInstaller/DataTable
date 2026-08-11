namespace Ase.ECS;

public class TrackWarningIndicatorData : WarningIndicatorData
{
	public float MoveSpeed;

	public float MoveTimer;

	public int TargetId;

	public void ProcessTrack(float speed, float time, int targetId)
	{
		MoveSpeed = speed;
		MoveTimer = time;
		TargetId = targetId;
	}

	public override void Clear()
	{
		base.Clear();
		TargetId = 0;
		MoveSpeed = 0f;
		MoveTimer = 0f;
	}
}
