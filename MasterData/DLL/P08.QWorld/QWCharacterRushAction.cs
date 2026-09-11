internal class QWCharacterRushAction : QWAgentAction
{
	public bool isRush;

	public QWCharacterRushAction()
		: base(E_Type.ChangeRush)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
