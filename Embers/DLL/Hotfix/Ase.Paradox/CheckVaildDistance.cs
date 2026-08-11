using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("检测是否超出距离", 0)]
[Category("✫ DragonLost/EntityCalculateTool")]
[Description("检测实体与目标之间的距离是否超出指定值。")]
public class CheckVaildDistance : ConditionTaskBase
{
	[Name("判断距离", 0)]
	[Description("用于判断是否超出距离的值。")]
	public BBParameter<float> compareDistance;

	[Name("输入坐标", 0)]
	[Description("指定是否使用目标实体或者目标坐标来进行距离判断。")]
	public bool inputPosition;

	[ShowIf("inputPosition", 0)]
	[Name("目标实体", 0)]
	[Description("用于距离判断的目标实体。")]
	public BBParameter<int> targetEntityId;

	[ShowIf("inputPosition", 1)]
	[Name("目标坐标", 0)]
	[Description("用于距离判断的目标坐标。")]
	public BBParameter<Vector3> targetPosition;

	protected override bool OnCheck()
	{
		base.OnCheck();
		float num = float.MinValue;
		if (!inputPosition)
		{
			BaseEntity entity = GetEntity(targetEntityId.value, isSyncEntity: true);
			if (entity != null)
			{
				num = (entity.transform.position - GetOwnerEntity().transform.position).sqrMagnitude;
			}
		}
		else
		{
			num = (targetPosition.value - GetOwnerEntity().transform.position).sqrMagnitude;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"检测是否超出距离 {num}  判断的值 ：{compareDistance.value}  目标实体 : {targetEntityId.value}  目标坐标 ： {targetPosition.value} 输入坐标 : {inputPosition} ", ownerEntity);
		}
		return compareDistance.value * compareDistance.value < num;
	}
}
