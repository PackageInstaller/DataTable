#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获得带偏移量坐标", 0)]
[Description("根据指定的目标对象的位置和角度，获取带有偏移量的目标坐标。")]
[Category("✫ DragonLost/Transform")]
public class GetTargetLocalPosOffset : ActionTaskBase
{
	[Name("_目标的坐标存储的位置", 0)]
	[Description("用于存储带有偏移量的目标坐标的变量。")]
	public BBParameter<Vector3> TargetPosition;

	[Name("偏移距离", 0)]
	[Description("偏移量的距离。")]
	public BBParameter<float> OffSet;

	[Name("偏移角度", 0)]
	[Description("偏移量的角度。")]
	public BBParameter<float> OffSetAngle;

	[Name("要获取坐标的目标对象的ID", 0)]
	[Description("要获取坐标的目标对象的ID。")]
	public BBParameter<int> TargetID;

	protected override void OnExecute()
	{
		base.OnExecute();
		GetForward();
		EndAction();
	}

	private void GetForward()
	{
		BaseEntity entity = GetEntity(TargetID.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError("获得带偏移量坐标错误：实体为空!");
		}
		else
		{
			TargetPosition.value = TSUtil.MoveForward2D(entity.transform.position, entity.transform.rotation.y + OffSetAngle.value, OffSet.value);
		}
	}
}
