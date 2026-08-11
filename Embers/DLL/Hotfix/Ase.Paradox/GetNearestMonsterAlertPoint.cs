using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取给定坐标的最近警戒区内坐标", 0)]
[Description("计算距离目标坐标最近的怪物警戒区内的坐标，并将结果存储在指定的变量中。")]
[Category("✫ DragonLost/Transform")]
public class GetNearestMonsterAlertPoint : ActionTaskBase
{
	[Name("目标坐标", 0)]
	[Description("要计算最近警戒区内坐标的目标坐标。")]
	public BBParameter<Vector3> targetPosition;

	[Name("获取结果", 0)]
	[Description("存储最近警戒区内坐标的变量。")]
	public BBParameter<Vector3> resultPosition;

	protected override void OnExecute()
	{
		base.OnExecute();
		MonsterNode data = GetOwnerEntity().GetData<MonsterNode>(MonsterGroup.MONSTERNODE_KEY);
		if ((Object)(object)data == null)
		{
			OnActionFinish();
			return;
		}
		float data2 = GetOwnerEntity().GetData<float>(MonsterGroup.LOW_MONSTER_ALERTRANGE_KEY);
		Vector3 vector = ((Component)(object)data).transform.position - targetPosition.value;
		if (vector.sqrMagnitude > data2 * data2)
		{
			resultPosition.value = ((Component)(object)data).transform.position + vector.normalized * data2;
		}
		else
		{
			resultPosition.value = targetPosition.value;
		}
		OnActionFinish();
	}
}
