using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class OpenSNSAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		StartOpenSns(Singleton<MissionManager>.instance.CancellationToken).Forget();
		return UniTask.CompletedTask;
	}

	private async UniTaskVoid StartOpenSns(CancellationToken token)
	{
		OpenSNSActionParam openSNSActionParam = Param as OpenSNSActionParam;
		SNSModel.SpecificMsg message = new SNSModel.SpecificMsg
		{
			ContactId = openSNSActionParam.contactId,
			SessionId = openSNSActionParam.messageGroupId
		};
		MessageCharacterData data = CoreUtils.GetData(message.ContactId, RuntimeConfigs.data.messageCharacterDatas);
		MessageConversationGroup data2 = CoreUtils.GetData(message.SessionId, RuntimeConfigs.data.messageConversationGroups);
		if (data != null && data2 != null)
		{
			SNSPreOpenView.Enqueue(message);
			await UniTask.WaitUntil(InBattleMain, PlayerLoopTiming.Update, token);
			SNSPreOpenView.OpenView();
		}
	}

	private bool InBattleMain()
	{
		OpenSNSActionParam openSNSActionParam = Param as OpenSNSActionParam;
		if (!Singleton<NewUIManager>.HasInstance())
		{
			return false;
		}
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var ui))
		{
			return false;
		}
		if (ui.State != UIState.Opened)
		{
			return false;
		}
		if (Model<SNSModel>.Interface.GetContacts(openSNSActionParam.contactId) == null || Model<SNSModel>.Interface.GetSession(openSNSActionParam.messageGroupId) == null)
		{
			return false;
		}
		if (Model<GuideModel>.HasInstance() && Model<GuideModel>.Interface.IsInStrongGuide())
		{
			return false;
		}
		return true;
	}
}
