public class QWChangeInteractionModeAction : QWAgentAction
{
	public QWInteractionModeEnum mode;

	public QWChangeInteractionModeAction()
		: base(E_Type.ChangeInteractionMode)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
