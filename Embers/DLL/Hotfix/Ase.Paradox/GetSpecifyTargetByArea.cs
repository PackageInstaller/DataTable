using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.Paradox;

[Name("获取特定范围内最远或最近的目标", 0)]
[Description("获取当前实体周围特定范围内指定的目标，最远or最近")]
[Category("✫ DragonLost/Target")]
public class GetSpecifyTargetByArea : ActionTaskBase
{
	public enum RangeEnum
	{
		None,
		Closest,
		Farthest
	}

	[Name("目标类型", 0)]
	[Description("计算目标的类型/Friend/Enemy/Self/All/Player")]
	public BBParameter<TargetTeamEnum> CalculationType;

	[Name("范围类型", 0)]
	[Description("目标范围的类型/Box/Circle/Sector")]
	public BBParameter<ShapeEnum> ColliderType;

	[Name("返回的实体ID", 0)]
	public BBParameter<int> returnEntityId;

	[Name("参数1", 0)]
	[Description("Box:长 / Circle：半径 / Sector：半径")]
	public BBParameter<float> param1;

	[Name("参数2", 0)]
	[Description("Box:宽 / Circle：无 / Sector：角度")]
	public BBParameter<float> param2;

	[Name("范围旋转角度", 0)]
	[Description("范围的旋转角度。")]
	public BBParameter<float> rotation;

	[Name("Y轴范围", 0)]
	[Description("Y轴范围，建议范围最小为0.5f")]
	public BBParameter<float> YValue = new BBParameter<float>(0.5f);

	[Name("偏移量XZ", 0)]
	public BBParameter<VectorXZ> offset = new BBParameter<VectorXZ>(default(VectorXZ));

	[Name("范围类型", 0)]
	public RangeEnum rangeEnum;

	private float Param1;

	private float Param2;

	private float angle;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (rangeEnum == RangeEnum.None)
		{
			OnActionFail("范围类型错误");
			return;
		}
		Param1 = param1.value;
		Param2 = param2.value;
		angle = rotation.value;
		List<int> list = CollectionPool<List<int>, int>.Get();
		MathModelCalcArea.GetAllRoleByArea(offset: new Vector2(offset.value.x, offset.value.z), ownerEntity: ownerEntity, colliderType: ColliderType.value, angle: angle, param1: Param1, param2: Param2, calculationType: CalculationType.value, enemies: list, yAxleLimit: YValue.value);
		if (list.Count == 0)
		{
			EndAction();
			return;
		}
		EntitySystem system = ownerEntity.GetSystem<EntitySystem>();
		if (system == null)
		{
			EndAction();
			return;
		}
		if (rangeEnum == RangeEnum.Closest)
		{
			BaseEntity baseEntity = system.GetEntity(list[0]);
			for (int i = 1; i < list.Count; i++)
			{
				BaseEntity entity = system.GetEntity(list[i]);
				if (Vector3.Distance(baseEntity.transform.position, ownerEntity.transform.position) > Vector3.Distance(entity.transform.position, ownerEntity.transform.position))
				{
					baseEntity = entity;
				}
			}
			returnEntityId.value = baseEntity.Id;
		}
		else if (rangeEnum == RangeEnum.Farthest)
		{
			BaseEntity baseEntity2 = system.GetEntity(list[0]);
			for (int j = 1; j < list.Count; j++)
			{
				BaseEntity entity2 = system.GetEntity(list[j]);
				if (Vector3.Distance(baseEntity2.transform.position, ownerEntity.transform.position) < Vector3.Distance(entity2.transform.position, ownerEntity.transform.position))
				{
					baseEntity2 = entity2;
				}
			}
			returnEntityId.value = baseEntity2.Id;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取特定范围内指定的目标：{returnEntityId}", ownerEntity);
		}
		EndAction();
	}
}
