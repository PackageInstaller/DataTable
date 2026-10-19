using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

[AddComponentMenu("4战斗相关组件/信息点参与到相机组中用的脚本")]
public class AreaCameraTargetPoint : MonoBehaviour
{
	private static readonly List<AreaCameraTargetPoint> s_ActivePoints = new List<AreaCameraTargetPoint>();

	public static IReadOnlyList<AreaCameraTargetPoint> ActivePoints => s_ActivePoints;

	private void OnEnable()
	{
		if (!s_ActivePoints.Contains(this))
		{
			s_ActivePoints.Add(this);
		}
	}

	private void OnDisable()
	{
		s_ActivePoints.Remove(this);
	}

	public static AreaCameraTargetPoint FindInBounds(Bounds bounds)
	{
		AreaCameraTargetPoint result = null;
		float num = float.MaxValue;
		int num2 = 0;
		for (int i = 0; i < s_ActivePoints.Count; i++)
		{
			AreaCameraTargetPoint areaCameraTargetPoint = s_ActivePoints[i];
			if (!areaCameraTargetPoint)
			{
				continue;
			}
			Vector3 position = areaCameraTargetPoint.transform.position;
			if (bounds.Contains(position))
			{
				num2++;
				float sqrMagnitude = (position - bounds.center).sqrMagnitude;
				if (!(sqrMagnitude >= num))
				{
					num = sqrMagnitude;
					result = areaCameraTargetPoint;
				}
			}
		}
		return result;
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = new Color(1f, 0.55f, 0.15f, 0.9f);
		Gizmos.DrawWireSphere(transform.position, 0.35f);
		Gizmos.DrawSphere(transform.position, 0.08f);
	}
}
