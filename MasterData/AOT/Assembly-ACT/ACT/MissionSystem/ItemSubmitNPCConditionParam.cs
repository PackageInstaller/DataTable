using System;
using ACT.MissionSystem.Internal;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class ItemSubmitNPCConditionParam : ItemSubmitConditionParam, IMissionPointCondition
{
	[Header("引导点相关配置")]
	public int npcId;

	public bool use3DLogic;

	public bool showMissionPointIcon = true;

	public bool showMissionPointRadius;

	public float missionPointRadius = 10f;

	[Header("引导点覆盖配置")]
	public bool missionPointOverride;

	public float positionX;

	public float positionY;

	public float positionZ;

	bool IMissionPointCondition.ShowMissionPointIcon
	{
		get
		{
			return showMissionPointIcon;
		}
		set
		{
			showMissionPointIcon = value;
		}
	}

	bool IMissionPointCondition.ShowMissionPointRadius
	{
		get
		{
			return showMissionPointRadius;
		}
		set
		{
			showMissionPointRadius = value;
		}
	}

	float IMissionPointCondition.MissionPointRadius
	{
		get
		{
			return missionPointRadius;
		}
		set
		{
			missionPointRadius = value;
		}
	}
}
