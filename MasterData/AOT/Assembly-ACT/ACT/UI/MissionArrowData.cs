using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MissionArrowData
{
	public static ObjectPool<MissionArrowData> s_MissionDataPool = new ObjectPool<MissionArrowData>(null, (MissionArrowData x) =>
	{
		x.arrow = null;
		x.missionPointData = null;
		x.Asset = null;
		x.effectGo = null;
		x.Distance = 0L;
		x.isActive = false;
	});

	public MissionPointData missionPointData;

	public MissionArrow arrow;

	private long m_Distance;

	public YooAssetReference Asset;

	public InstanceHandle effectGo;

	public long Distance
	{
		get
		{
			return m_Distance;
		}
		set
		{
			if (value != m_Distance)
			{
				if (arrow != null)
				{
					arrow.SetDistance(m_Distance, value);
				}
				m_Distance = value;
			}
		}
	}

	public bool isActive { get; private set; }

	public bool IsInsideScreen
	{
		get
		{
			if ((bool)arrow)
			{
				return arrow.IsInsideScreen;
			}
			return false;
		}
	}

	public void Activate()
	{
		isActive = true;
	}

	public bool TryDeactivate()
	{
		if (!isActive)
		{
			return false;
		}
		isActive = false;
		return true;
	}

	public void UpdateEffectPosition(BaseEventContent e = null)
	{
		Vector3 actualPos = missionPointData.GetActualPos();
		if (Physics.Raycast(new Ray(actualPos, Vector3.down), out var hitInfo, 2.5f, 7))
		{
			if ((bool)effectGo.Result)
			{
				effectGo.Result.transform.position = hitInfo.point;
			}
		}
		else
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"任务点特效 {actualPos} 没有下方找到地面?");
			}
			if ((bool)effectGo.Result)
			{
				effectGo.Result.transform.position = actualPos;
			}
		}
		if ((bool)effectGo.Result)
		{
			effectGo.Result.gameObject.SetActive(missionPointData.IsSameWorld);
		}
	}

	public bool CanMerge(MissionArrowData other)
	{
		return Vector2.Distance(other.arrow.transform.position, arrow.transform.position) <= 3f;
	}
}
