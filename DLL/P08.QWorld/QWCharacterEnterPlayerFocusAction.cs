internal class QWCharacterEnterPlayerFocusAction : QWAgentAction
{
	public bool isEnter;

	public QWCharacterEnterPlayerFocusAction()
		: base(E_Type.EnterPlayerFocusState)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
