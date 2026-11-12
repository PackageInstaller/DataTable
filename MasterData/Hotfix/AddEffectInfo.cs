using TrueSync;

public class AddEffectInfo
{
	public readonly int effectId;

	public readonly int takeEffectLimit;

	public FP initCD;

	public AddEffectInfo(int effectId, int takeEffectLimit = -1, long initCD = 0L)
	{
		this.effectId = effectId;
		this.takeEffectLimit = takeEffectLimit;
		this.initCD = new FP(initCD);
	}
}
