using System.Threading;
using ACT.Battle.Configs;
using ACT.Model;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.MissionSystem;

public class AddMissionMarkAction : MissionAction
{
	public class MissionMark
	{
		public MissionPointData missionPointData;
	}

	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		AddMissionMarkActionParam addMissionMarkActionParam = Param as AddMissionMarkActionParam;
		if (addMissionMarkActionParam.showMissionPointIcon || addMissionMarkActionParam.showMissionPointRadius)
		{
			Vector3 fixedPos = new Vector3(addMissionMarkActionParam.positionX, addMissionMarkActionParam.positionY, addMissionMarkActionParam.positionZ);
			int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
			FixedAreaMissionPoint fixedAreaMissionPoint = new FixedAreaMissionPoint(Flow.Id, newPointId, addMissionMarkActionParam.use3DLogic, addMissionMarkActionParam.mapArea, fixedPos);
			fixedAreaMissionPoint.ShowIcon = addMissionMarkActionParam.showMissionPointIcon;
			fixedAreaMissionPoint.ShowRadius = addMissionMarkActionParam.showMissionPointRadius;
			fixedAreaMissionPoint.Radius = addMissionMarkActionParam.missionPointRadius;
			Model<BattleMainMarkModelV2>.Interface.RegisterPoint(fixedAreaMissionPoint);
			Flow.Blackboard.Add(string.Format("{0}:{1}", "AddMissionMarkAction", addMissionMarkActionParam.key), new MissionMark
			{
				missionPointData = fixedAreaMissionPoint
			});
		}
		return UniTask.CompletedTask;
	}
}
