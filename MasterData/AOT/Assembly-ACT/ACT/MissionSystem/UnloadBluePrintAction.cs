using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class UnloadBluePrintAction : MissionAction
{
	public override bool OnlyInMissionWorld => false;

	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		UnloadBluePrintActionParam unloadBluePrintActionParam = Param as UnloadBluePrintActionParam;
		string key = "RuntimeBluePrintData:" + unloadBluePrintActionParam.key;
		if (!(Flow.Blackboard.Get(key) is LoadBluePrintAction.RuntimeBluePrintData runtimeBluePrintData))
		{
			return UniTask.CompletedTask;
		}
		Flow.Blackboard.Remove(key);
		runtimeBluePrintData.Dispose();
		return UniTask.CompletedTask;
	}
}
