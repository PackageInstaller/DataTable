using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("判断实体是否在目标朝向偏移范围内", 0)]
[Category("✫ DragonLost/Target")]
[Description("检查当前实体是否在目标朝向偏移范围内。")]
public class CheckEntityInRange : ConditionTaskBase
{
	[Name("目标实体Id", 0)]
	[Description("要检查的目标实体的ID")]
	public BBParameter<int> TargetId;

	[Name("范围类型", 0)]
	[Description("用于检查的范围类型/矩形/圆形/扇形")]
	public BBParameter<ShapeEnum> ColliderType;

	[Name("参数1", 0)]
	[Description("矩形：长/圆形：半径/扇形：半径")]
	public BBParameter<float> param1;

	[Name("参数2", 0)]
	[Description("矩形：宽/圆形：无/扇形：角度")]
	public BBParameter<float> param2;

	[Name("范围旋转角度", 0)]
	[Description("范围的旋转角度")]
	public BBParameter<float> rotation;

	[Name("Y轴范围", 0)]
	[Description("Y轴范围，建议范围最小为0.5f")]
	public BBParameter<float> YValue = new BBParameter<float>(0.5f);

	[Name("偏移量XZ", 0)]
	public BBParameter<VectorXZ> offset = new BBParameter<VectorXZ>(default(VectorXZ));

	private List<int> enemys;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(TargetId.value, isSyncEntity: false);
		if (entity == null)
		{
			return false;
		}
		enemys = new List<int>();
		float value = param1.value;
		float value2 = param2.value;
		float value3 = rotation.value;
		MathModelCalcArea.GetAllRoleByArea(offset: new Vector2(offset.value.x, offset.value.z), ownerEntity: entity, colliderType: ColliderType.value, angle: value3, param1: value, param2: value2, calculationType: TargetTeamEnum.All, enemies: enemys, yAxleLimit: YValue.value);
		foreach (int enemy in enemys)
		{
			if (enemy == ownerEntity.Id)
			{
				return true;
			}
		}
		return false;
	}
}
