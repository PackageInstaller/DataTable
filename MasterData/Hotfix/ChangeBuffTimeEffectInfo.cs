public class ChangeBuffTimeEffectInfo
{
	public readonly int buffId;

	public readonly int buffGroupId;

	public readonly int buffTag;

	public readonly int absChange;

	public readonly int percentChange;

	public ChangeBuffTimeEffectInfo(int buffId, int buffGroupId, int buffTag, int absChange, int percentChange)
	{
		this.buffId = buffId;
		this.buffGroupId = buffGroupId;
		this.buffTag = buffTag;
		this.absChange = absChange;
		this.percentChange = percentChange;
	}
}
