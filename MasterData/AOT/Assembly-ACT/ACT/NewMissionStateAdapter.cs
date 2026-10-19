using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.NumberString;
using Fundamental;
using UnityEngine;

namespace ACT;

public class NewMissionStateAdapter : MissionStateAdapter
{
	public ACT.MissionSystem.MissionData m_MissionData;

	private float m_Distance;

	private string m_DistanceText;

	private string m_TeleportText;

	private string m_MissionText;

	private Color m_DistanceColor;

	private bool isCrossMap;

	private bool isInZone;

	public override int Id => m_MissionData.Id;

	public NewMissionStateAdapter(ACT.MissionSystem.MissionData missionData)
	{
		m_MissionData = missionData;
	}

	public override bool IsTracing()
	{
		return Singleton<MissionManager>.instance.GetTracingMission() == m_MissionData.Id;
	}

	public override bool IsFirstMissionInGroup()
	{
		return RuntimeConfigs.data.missionRGroups[m_MissionData.Config.MissionGroupId].firstMission == m_MissionData.Id;
	}

	public override bool IsLastMissionInGroup()
	{
		return RuntimeConfigs.data.missionRGroups[m_MissionData.Config.MissionGroupId].lastMission == m_MissionData.Config.MissionId;
	}

	public override int GetMissionType()
	{
		return m_MissionData.Config.MissionType;
	}

	public override string GetMissionName()
	{
		return m_MissionData.Config.GetMissionName();
	}

	public override string GetMissionTitle()
	{
		return m_MissionData.Config.GetMissionTitle();
	}

	public override string GetMissionContent()
	{
		return m_MissionData.Config.GetMissionContent();
	}

	public override void RefreshDistanceText()
	{
		try
		{
			IReadOnlyList<MissionPointData> points = Model<BattleMainMarkModelV2>.Interface.Points;
			Vector3? vector = MonoECS.instance.mainEntity.GetCompTransform()?.physicsPosition;
			if (!vector.HasValue)
			{
				return;
			}
			float num = float.MaxValue;
			MissionPointData missionPointData = points.FirstOrDefault();
			foreach (MissionPointData item in points)
			{
				float num2 = Vector3.Distance(item.GetActualPos(), vector.Value);
				if (num2 < num)
				{
					num = num2;
					missionPointData = item;
				}
			}
			if (missionPointData == null)
			{
				return;
			}
			isCrossMap = !missionPointData.IsSameWorld;
			if (!isCrossMap)
			{
				isInZone = num < missionPointData.Radius;
			}
			else
			{
				isInZone = false;
			}
			if (isCrossMap)
			{
				ColorUtility.TryParseHtmlString("#EFE073", out var color);
				m_DistanceColor = color;
				MapArea data = CoreUtils.GetData((int)missionPointData.MapArea, RuntimeConfigs.data.mapAreas);
				if (data != null)
				{
					int name = data.name;
					m_TeleportText = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, name);
					m_DistanceText = string.Empty;
				}
				else
				{
					m_TeleportText = string.Empty;
					m_DistanceText = string.Empty;
				}
				return;
			}
			if (!isInZone)
			{
				ColorUtility.TryParseHtmlString("#FFFD58", out var color2);
				m_DistanceColor = color2;
				if (Mathf.Approximately(m_Distance, num))
				{
					return;
				}
				m_Distance = (int)Math.Ceiling(num);
				m_DistanceText = m_Distance.FastToString() + "m";
			}
			else
			{
				m_DistanceText = string.Empty;
			}
			m_TeleportText = string.Empty;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			m_DistanceText = string.Empty;
		}
	}

	public override string GetDistanceText()
	{
		return m_DistanceText;
	}

	public override string GetTeleportText()
	{
		return m_TeleportText;
	}

	public override Color GetDistanceColor()
	{
		return m_DistanceColor;
	}

	public override bool IsInZone()
	{
		return isInZone;
	}

	public override bool IsCrossMap()
	{
		return isCrossMap;
	}

	public override bool IsBlocked()
	{
		return false;
	}

	public override string GetBlockText()
	{
		return string.Empty;
	}
}
