#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取坐标相对实体朝向的偏移角度", 0)]
[Description("获取目标实体朝向与指定坐标的偏移角度。要加180才是正确的。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityAngleByVector3 : ActionTaskBase
{
	[Name("目标实体", 0)]
	[Description("要获取角度的目标实体的ID。")]
	public BBParameter<int> entityId;

	[Name("坐标", 0)]
	[Description("指定的坐标点。")]
	public BBParameter<Vector3> targetPoint;

	[Name("返回的角度", 0)]
	[Description("存储获取到的角度。")]
	public BBParameter<float> angle;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError("获取坐标相对实体朝向的偏移角度错误：输入的实体为空!");
			EndAction();
		}
		else
		{
			angle.value = TSUtil.TargetFwdAngleToSelf(entity.transform.position, entity.transform.eulerAngles.y, targetPoint.value);
			EndAction();
		}
	}
}
