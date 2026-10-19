using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class ExitAreaCondition : MissionCondition
{
	private AreaConditionHelper m_Helper;

	private MissionPointData m_MissionPoint;

	private LocalizedString m_Description;

	public override bool AllowRepeat => true;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (m_MissionPoint != null)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
			yield return new ConditionDescription
			{
				HaveContent = (Desc != 0),
				DescriptionContent = m_Description,
				HaveMissionPoint = true,
				MissionPointId = m_MissionPoint.PointId
			};
		}
	}

	protected override async void OnInMissionWorld()
	{
		ExitAreaConditionParam exitAreaConditionParam = Param as ExitAreaConditionParam;
		m_Helper = new GameObject($"ExitAreaConditionHelper:{Id}").AddComponent<AreaConditionHelper>();
		m_Helper.transform.SetParent(Flow.Env.transform, worldPositionStays: true);
		m_Helper.transform.position = new Vector3(exitAreaConditionParam.positionX, exitAreaConditionParam.positionY, exitAreaConditionParam.positionZ);
		m_Helper.SetInitInArea(b: true);
		switch (exitAreaConditionParam.areaType)
		{
		case ExitAreaConditionParam.AreaType.Sphere:
		{
			SphereCollider sphereCollider = m_Helper.gameObject.AddComponent<SphereCollider>();
			sphereCollider.radius = exitAreaConditionParam.radius;
			sphereCollider.isTrigger = true;
			break;
		}
		case ExitAreaConditionParam.AreaType.Box:
		{
			BoxCollider boxCollider = m_Helper.gameObject.AddComponent<BoxCollider>();
			boxCollider.size = new Vector3(exitAreaConditionParam.sizeX, exitAreaConditionParam.sizeY, exitAreaConditionParam.sizeZ);
			boxCollider.center = Vector3.zero;
			boxCollider.isTrigger = true;
			break;
		}
		}
		if (IsRepeat)
		{
			do
			{
				if (!CheckCondition())
				{
					await UniTask.Yield();
					continue;
				}
				MarkSuccess();
				while (InMissionWorld && CheckCondition())
				{
					await UniTask.Yield();
				}
			}
			while (InMissionWorld);
			return;
		}
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	protected override void OnOutMissionWorld()
	{
		if (m_Helper != null)
		{
			Object.Destroy(m_Helper.gameObject);
			m_Helper = null;
		}
	}

	private bool CheckCondition()
	{
		if ((bool)m_Helper && !m_Helper.InArea)
		{
			return true;
		}
		return false;
	}
}
