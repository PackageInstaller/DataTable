using System.Threading;
using ACT.Model;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class EnableTPBtnAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		if (Flow.Blackboard.Get("DisableTPBtn") != null)
		{
			Model<MapModel>.Interface.PopDisableTP();
		}
		return UniTask.CompletedTask;
	}
}
