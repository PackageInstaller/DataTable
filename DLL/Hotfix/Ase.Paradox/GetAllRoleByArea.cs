using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取特定范围内的目标", 0)]
[Description("获取当前实体周围特定范围内的目标，并存储在指定的列表中。")]
[Category("✫ DragonLost/Target")]
public class GetAllRoleByArea : ActionTaskBase
{
	[Name("目标类型", 0)]
	[Description("计算目标的类型/Friend/Enemy/Self/All/Player")]
	public BBParameter<TargetTeamEnum> CalculationType;

	[Name("范围类型", 0)]
	[Description("目标范围的类型/Box/Circle/Sector")]
	public BBParameter<ShapeEnum> ColliderType;

	[Name("目标数量", 0)]
	[Description("存储获取到的目标数量。")]
	public BBParameter<int> EnemyNumber;

	[Name("返回的Role", 0)]
	[Description("存储获取到的目标的列表。")]
	public BBParameter<List<int>> enemys;

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

	private float Param1;

	private float Param2;

	private float angle;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (param1 == null || param2 == null || rotation == null || enemys == null || EnemyNumber == null || ColliderType == null || CalculationType == null)
		{
			EndAction();
			return;
		}
		enemys.value = new List<int>();
		Param1 = param1.value;
		Param2 = param2.value;
		angle = rotation.value;
		MathModelCalcArea.GetAllRoleByArea(offset: new Vector2(offset.value.x, offset.value.z), ownerEntity: ownerEntity, colliderType: ColliderType.value, angle: angle, param1: Param1, param2: Param2, calculationType: CalculationType.value, enemies: enemys.value, yAxleLimit: YValue.value);
		EnemyNumber.value = enemys.value.Count;
		string text = null;
		for (int i = 0; i < enemys.value.Count; i++)
		{
			text += $"ID : {enemys.value[i]}";
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("获取特定范围内的目标：" + text, ownerEntity);
		}
		EndAction();
	}
}
