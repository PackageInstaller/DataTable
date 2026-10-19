namespace ACT.Battle;

public class UseBloodBottle : BaseEvt
{
	public bool used;

	public int canUseCount;

	public override void Reset()
	{
		used = false;
		canUseCount = 0;
	}
}
