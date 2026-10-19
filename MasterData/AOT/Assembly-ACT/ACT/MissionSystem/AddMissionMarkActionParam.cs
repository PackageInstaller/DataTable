using System;
using ACT.MissionSystem.Internal;
using ACT.World;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class AddMissionMarkActionParam : IMissionPointCondition
{
	public int key;

	public MapArea mapArea;

	public float positionX;

	public float positionY;

	public float positionZ;

	[Header("引导点相关配置")]
	public bool use3DLogic;

	public bool showMissionPointIcon = true;

	public bool showMissionPointRadius;

	public float missionPointRadius = 10f;

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
