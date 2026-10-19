using System;
using ACT.UI;
using ACT.World;
using Fundamental;
using UnityEngine;

namespace ACT.BluePrint;

public class BPMission : BPCommon
{
	private GameObject bpAsset;

	private uint m_MissionPointUid;

	private long m_BlurPrintId;

	protected override void OnStart()
	{
		base.OnStart();
	}

	private void CloseSubMission()
	{
		machine.enabled = false;
	}

	[Obsolete]
	public void FinishMission()
	{
	}

	[Obsolete]
	public void FailSubMission()
	{
	}

	[Obsolete]
	public void PassSubMission(int to)
	{
	}

	[Obsolete]
	public void EnableFixedAreaMissionPoint(Vector3 worldPosition, MapArea mapArea, int mapLayer, bool use3DLogic)
	{
	}

	[Obsolete]
	public void EnableFixedAreaMissionPoint(GameObject worldPosition, MapArea mapArea, int mapLayer, bool use3DLogic)
	{
	}

	[Obsolete]
	public void DisableFixedAreaMissionPoint(GameObject worldPosition)
	{
	}

	[Obsolete]
	public void DisableFixedAreaMissionPoint(Vector3 worldPosition)
	{
	}

	[Obsolete]
	public void EnableNPCMissionPoint(int NPCId, MapArea mapArea, int mapLayer, bool use3DLogic)
	{
	}

	[Obsolete]
	public void DisableNPCAreaMissionPoint(int NPCId)
	{
	}

	[Obsolete]
	public void EnableInteractObjectMissionPoint(int uid, MapArea mapArea, int mapLayer, bool use3DLogic)
	{
	}

	[Obsolete]
	public void DisableInteractObjectAreaMissionPoint(int uid)
	{
	}

	[Obsolete]
	public void EnableChaseMissionPoint(int uid, MapArea mapArea, int mapLayer, bool use3DLogic)
	{
	}

	[Obsolete]
	public void DisableChaseMissionPoint(int uid)
	{
	}

	[Obsolete]
	private void ServerChangeMissionState()
	{
	}

	[Obsolete("用MissionPointUnit，但是这个别删，有远古任务在用")]
	public void SetMissionPointState(int pointId = 0, bool setActive = true)
	{
	}

	public void ShowTaskPopView(int mainMissionId, bool isOpen)
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TASKPOP, new MonoTaskPopView.TaskPopPara
		{
			mainMissionId = mainMissionId,
			isOpen = isOpen
		});
	}

	[Obsolete]
	public void AddRecommendEntries(int uid)
	{
	}

	[Obsolete]
	public void RemoveRecommendEntries(int uid)
	{
	}

	[Obsolete]
	public void FinishMissionBluePrint()
	{
	}

	[Obsolete]
	public void MissionApplyItem(int collectionId)
	{
	}
}
