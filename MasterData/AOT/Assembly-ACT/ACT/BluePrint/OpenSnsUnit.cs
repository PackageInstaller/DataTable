using System.Collections;
using ACT.Model;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.VisualScripting;

namespace ACT.BluePrint;

public class OpenSnsUnit : WaitUnit
{
	[DoNotSerialize]
	private ValueInput _contactId;

	[DoNotSerialize]
	private ValueInput _sessionId;

	[DoNotSerialize]
	private ValueInput _msgId;

	protected override void Definition()
	{
		base.Definition();
		_contactId = ValueInput("_contactId", 0);
		_sessionId = ValueInput("_sessionId", 0);
		_msgId = ValueInput("_msgId", 0);
	}

	protected override IEnumerator Await(Flow flow)
	{
		int contactId = flow.GetValue<int>(_contactId);
		int sessionId = flow.GetValue<int>(_sessionId);
		int msgId = flow.GetValue<int>(_msgId);
		SNSModel.SpecificMsg msg = new SNSModel.SpecificMsg
		{
			ContactId = contactId,
			SessionId = sessionId
		};
		if (Model<SNSModel>.Interface.SetSpecificMsg(msg))
		{
			yield return Fundamental.Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SNS).ToCoroutine();
			while (!Model<SNSModel>.Interface.IsSessionFinished(contactId, sessionId, msgId))
			{
				yield return null;
			}
			yield return exit;
		}
	}
}
