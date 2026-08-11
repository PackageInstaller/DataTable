using System;
using ParadoxNotion.Design;

namespace Ase;

[Serializable]
public class BulletTrackedStageData
{
	[Name("位置距离/存活时间", 0)]
	public bool isDistanceOrTimeTracked = true;

	[Name("创建位置距离/目标距离", 0)]
	[ShowIf("isDistanceOrTimeTracked", 1)]
	public bool useCreatePoint;

	[ShowIf(new string[] { "isDistanceOrTimeTracked", "useCreatePoint" }, new int[] { 1, 0 })]
	[Name("与目标位置的距离", 0)]
	public float targetDistance;

	[Name("与创建位置的距离", 0)]
	[ShowIf(new string[] { "isDistanceOrTimeTracked", "useCreatePoint" }, new int[] { 1, 1 })]
	public float createDistance;

	[Name("存活时间（秒）", 0)]
	[ShowIf("isDistanceOrTimeTracked", 0)]
	public float trackedTime;

	[Name("比较类型", 0)]
	[ShowIf("isDistanceOrTimeTracked", 0)]
	public CompareMethodType compareType;

	[Name("旋转角度", 0)]
	public float rotateAngle;

	[Name("转向后的移速", 0)]
	public float moveSpeed;

	[Name("优先级", 0)]
	public int priority;

	public float GetDistance()
	{
		if (!useCreatePoint)
		{
			return targetDistance;
		}
		return createDistance;
	}
}
