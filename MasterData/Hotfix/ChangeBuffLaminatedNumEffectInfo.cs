public class ChangeBuffLaminatedNumEffectInfo
{
	public readonly int buffId;

	public readonly int buffGroupId;

	public readonly int buffTag;

	public readonly int changeNum;

	public ChangeBuffLaminatedNumEffectInfo(int buffId, int buffGroupId, int buffTag, int changeNum)
	{
		this.buffId = buffId;
		this.buffGroupId = buffGroupId;
		this.buffTag = buffTag;
		this.changeNum = changeNum;
	}
}
