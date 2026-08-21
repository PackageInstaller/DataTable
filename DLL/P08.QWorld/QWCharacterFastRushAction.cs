internal class QWCharacterFastRushAction : QWAgentAction
{
	public bool isFastRush;

	public QWCharacterFastRushAction()
		: base(E_Type.ChangeFastRush)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
