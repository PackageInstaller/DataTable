using ACT.Utility;

namespace ACT.Battle;

public class EvtStateChange : BaseEvt
{
	public PlayState pre;

	public PlayState now;

	public override void Reset()
	{
		pre = PlayState.UnBattle;
		now = PlayState.UnBattle;
	}
}
