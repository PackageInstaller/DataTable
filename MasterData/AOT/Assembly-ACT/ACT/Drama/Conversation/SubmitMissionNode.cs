using System.Collections.Generic;
using System.Threading;
using ACT.UI;
using Fundamental;
using XNode;

namespace ACT.Drama.Conversation;

public class SubmitMissionNode : ConversationBaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string pre;

	public bool FinishMission;

	public int finishSubMissionId;

	public int nextSubMissionId;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int TrueExit;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int FalseExit;

	private bool m_subMissionState;

	public override async void EnterNode(CancellationToken cancellationToken)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return;
		}
		conversationGraph.curNode = this;
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPSUBMITMISSIONPANEL, finishSubMissionId);
		if (Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_POPUPSUBMITMISSIONPANEL, out var ui))
		{
			IBaseUIView uIView = ui.GetUIView();
			if (uIView is MonoPopUpMissionSubmitView submitMissionView)
			{
				submitMissionView.nextMissionId = nextSubMissionId;
				submitMissionView.FinishMission = FinishMission;
				m_subMissionState = await submitMissionView.GetSubmitMissionState();
				submitMissionView.Close();
			}
		}
		ExitNode(cancellationToken);
	}

	public override void ExitNode(CancellationToken cancellationToken)
	{
		List<NodePort> list = null;
		list = ((!m_subMissionState) ? GetOutputPort("FalseExit").GetConnections() : GetOutputPort("TrueExit").GetConnections());
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				(list[i].node as ConversationBaseNode).EnterNode(cancellationToken);
			}
		}
	}

	public override void JumpNode(bool isFirst = false)
	{
		CancellationTokenSource cancellationTokenSource = conversationManager.JumpToBranch();
		EnterNode(cancellationTokenSource.Token);
	}
}
