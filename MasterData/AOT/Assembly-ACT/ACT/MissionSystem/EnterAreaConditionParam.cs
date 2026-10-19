using System;
using ACT.MissionSystem.Internal;
using ACT.World;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class EnterAreaConditionParam : IMissionPointCondition
{
	public enum AreaType
	{
		Sphere,
		Box
	}

	public MapArea mapArea;

	public AreaType areaType;

	public float positionX;

	public float positionY;

	public float positionZ;

	public float offsetX;

	public float offsetY;

	public float offsetZ;

	public float radius;

	public float sizeX;

	public float sizeY;

	public float sizeZ;

	[Header("引导点相关设置")]
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
