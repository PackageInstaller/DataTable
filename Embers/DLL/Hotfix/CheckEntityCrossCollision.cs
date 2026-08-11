using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

[Name("检测实体位移是否穿过碰撞盒", 0)]
[Category("✫ DragonLost/Skill")]
[Description("检查是否可以释放指定类型的技能")]
public class CheckEntityCrossCollision : ConditionTaskBase
{
	[Name("目标ID", 0)]
	public BBParameter<int> targetId;

	[Name("碰撞距离", 0)]
	public BBParameter<float> Distance;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (ownerEntity.GetSystem<EntitySystem>()?.GetEntity(targetId.value) == null)
		{
			return false;
		}
		Vector3 vector = ownerEntity.GetComponent<KinematicMoveComponent>()?.LastPosition ?? default(Vector3);
		_ = ownerEntity.transform.position - vector;
		return false;
	}
}
