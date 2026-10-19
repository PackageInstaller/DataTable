using System;
using System.Collections.Generic;
using ACT.MissionSystem.Internal;
using ACT.World;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class InteractObjectStateConditionParam : IMissionPointCondition
{
	public enum MissionPointType
	{
		Normal,
		Chase
	}

	[Serializable]
	public struct InteractObjectState
	{
		public int swid;

		public int state;
	}

	public MapArea mapArea;

	public MissionPointType pointType;

	public List<InteractObjectState> interactObjectStates = new List<InteractObjectState>();

	[Header("引导点相关配置")]
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
