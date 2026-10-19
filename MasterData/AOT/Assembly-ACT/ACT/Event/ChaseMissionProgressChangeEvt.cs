namespace ACT.Event;

public class ChaseMissionProgressChangeEvt : BaseEventContent
{
	public bool isDanger;

	public float preProgress;

	public float curProgress;

	public bool ToFull
	{
		get
		{
			if (preProgress < 1f)
			{
				return curProgress >= 1f;
			}
			return false;
		}
	}

	public bool ToZero
	{
		get
		{
			if (preProgress > 0f)
			{
				return curProgress == 0f;
			}
			return false;
		}
	}

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		preProgress = 0f;
		curProgress = 0f;
	}
}
