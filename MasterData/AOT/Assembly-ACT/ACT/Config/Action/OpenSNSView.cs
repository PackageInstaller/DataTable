using ACT.Model;

namespace ACT.Config.Action;

public class OpenSNSView : GuideStepAction
{
	public int contactId;

	public int sessionId;

	public override void Execute(GuideStepData data)
	{
		SNSModel.SpecificMsg msg = new SNSModel.SpecificMsg
		{
			ContactId = contactId,
			SessionId = sessionId
		};
		Model<SNSModel>.Interface.SetSpecificMsg(msg, needUnlock: true);
	}
}
