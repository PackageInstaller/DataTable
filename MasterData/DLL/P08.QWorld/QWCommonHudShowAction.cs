public class QWCommonHudShowAction : QWAgentAction
{
	public string iconName;

	public string jobName;

	public string baseBoardName;

	public bool isAdd = true;

	public QWCommonHudShowAction()
		: base(E_Type.CommonHudShow)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
