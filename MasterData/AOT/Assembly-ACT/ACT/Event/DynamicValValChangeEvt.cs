namespace ACT.Event;

public class DynamicValValChangeEvt : BaseEventContent
{
	public int characterId;

	public string name;

	public float preVal;

	public float curVal;

	public float delta;

	public float min;

	public float max;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
		name = string.Empty;
		preVal = 0f;
		curVal = 0f;
		delta = 0f;
		min = 0f;
		max = 0f;
	}
}
