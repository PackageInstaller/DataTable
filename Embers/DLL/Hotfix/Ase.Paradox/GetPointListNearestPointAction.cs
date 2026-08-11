#define ENABLE_LOG
using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取坐标列表中最近或最远的点", 0)]
[Description("从提供的坐标列表中找到与指定实体或自身最近或最远的点，并将结果存储在指定的变量中。")]
[Category("✫ DragonLost/Transform")]
public class GetPointListNearestPointAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要比较距离的实体的ID。如果选择了自己，将使用当前任务拥有者的位置。")]
	public BBParameter<int> EntityId;

	[Name("是否选择自己", 0)]
	[Description("如果为真，则使用当前任务拥有者的位置作为参考点。如果为假，则使用指定实体的位置作为参考点。")]
	public bool IsSelf = true;

	[Name("Point列表", 0)]
	[Description("要比较距离的坐标点列表。")]
	public BBParameter<List<Vector3>> PointList;

	[Name("返回的位置", 0)]
	[Description("存储最近或最远的点的变量。")]
	public BBParameter<Vector3> Point;

	[Name("最近", 0)]
	[Description("如果为真，则返回最近的点；如果为假，则返回最远的点。")]
	[Tooltip("最近为True，最远为False")]
	public bool isNearset;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (PointList.value == null)
		{
			LogActionError("获取坐标列表中最近或最远的点错误: 没有提供比对的位置！");
			EndAction();
			return;
		}
		Vector3 vector = (IsSelf ? ownerEntity.transform.position : GetEntityPosition());
		float num = (isNearset ? float.MaxValue : float.MinValue);
		foreach (Vector3 item in PointList.value)
		{
			float num2 = Vector3.SqrMagnitude(vector - item);
			if ((isNearset && num2 < num) || (!isNearset && num2 > num))
			{
				Point.value = item;
				num = num2;
			}
		}
		EndAction();
	}

	private Vector3 GetEntityPosition()
	{
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity != null)
		{
			return entity.transform.position;
		}
		LogActionError("获取坐标列表中最近或最远的点错误：实体为空!");
		return Vector3.zero;
	}
}
