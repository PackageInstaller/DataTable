public class ExecuteEffectInfo
{
	public int effectId;

	public string effectTag;

	public ExecuteEffectInfo(int effectId, string effectTag)
	{
		this.effectId = effectId;
		this.effectTag = effectTag;
	}

	public void Clear()
	{
		effectId = 0;
		effectTag = "";
	}

	public bool IsEqual(int effectId, string effectTag)
	{
		if (this.effectId == effectId)
		{
			return this.effectTag == effectTag;
		}
		return false;
	}
}
