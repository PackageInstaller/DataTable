public class AttrFixEffectAmendEffectInfo
{
	public readonly int effectId;

	public readonly string effectTag;

	public readonly int absAmend;

	public readonly int percentAmend;

	public AttrFixEffectAmendEffectInfo(int effectId, string effectTag, int absAmend, int percentAmend)
	{
		this.effectId = effectId;
		this.effectTag = effectTag;
		this.absAmend = absAmend;
		this.percentAmend = percentAmend;
	}
}
