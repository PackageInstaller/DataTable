using System.Threading;
using ACT.Model;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class DeleteMissionMarkAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		DeleteMissionMarkActionParam deleteMissionMarkActionParam = Param as DeleteMissionMarkActionParam;
		string key = string.Format("{0}:{1}", "AddMissionMarkAction", deleteMissionMarkActionParam.key);
		AddMissionMarkAction.MissionMark missionMark = Flow.Blackboard.Get(key) as AddMissionMarkAction.MissionMark;
		Flow.Blackboard.Remove(key);
		if (missionMark != null && missionMark.missionPointData != null)
		{
			Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(missionMark.missionPointData);
		}
		return UniTask.CompletedTask;
	}
}
