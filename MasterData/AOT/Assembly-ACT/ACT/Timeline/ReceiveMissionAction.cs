using ACT.MissionSystem;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ReceiveMissionAction : ISignalAction
{
	public int missionId;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		Singleton<MissionManager>.instance.RequestAcceptMission(missionId);
		return UniTask.CompletedTask;
	}
}
