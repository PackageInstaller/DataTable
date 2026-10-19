using System.Threading;
using ACT.Model;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class DisableTPBtnAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		Model<MapModel>.Interface.PushDisableTP();
		Flow.Blackboard.Add("DisableTPBtn", "DisableTPBtn");
		return UniTask.CompletedTask;
	}
}
