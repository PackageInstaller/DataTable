using System;
using ACT.MissionSystem;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
public class ActionReceiveMission : NpcInteractAction
{
	public int missionID;

	public override int ActionId => NpcInteractActionIds.ReceiveMission;

	protected override UniTask DoAction()
	{
		Singleton<MissionManager>.instance.RequestAcceptMission(missionID, (bool result) =>
		{
			if (result)
			{
				Debug.Log($"NPC任务接取成功，任务ID：{missionID}");
			}
			else
			{
				Debug.LogWarning($"NPC任务接取失败，任务ID：{missionID}");
			}
		});
		return base.DoAction();
	}
}
