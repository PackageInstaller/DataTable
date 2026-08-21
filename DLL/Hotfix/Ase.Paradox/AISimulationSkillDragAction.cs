using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体1指向实体2的向量并旋转向量", 0)]
[Category("✫ DragonLost/Skill")]
[Description("获取两个实体之间的向量之后对向量进行旋转")]
public class AISimulationSkillDragAction : ActionTaskBase
{
	[Name("实体1的实体ID", 0)]
	[Description("实体1的实体ID")]
	public BBParameter<int> Entity1Id;

	[Name("实体2的实体ID", 0)]
	[Description("实体1的实体ID")]
	public BBParameter<int> Entity2Id;

	[Name("旋转的角度值", 0)]
	[Description("旋转的角度值")]
	public BBParameter<float> OffsetAngleValue;

	[Name("返回的向量", 0)]
	[Description("返回的向量")]
	public BBParameter<Vector2> ResultDir;

	protected override void OnExecute()
	{
		base.OnExecute();
		EntitySystem system = ownerEntity.GetSystem<EntitySystem>();
		if (system == null)
		{
			OnActionFinish();
			return;
		}
		BaseEntity entity = system.GetEntity(Entity1Id.value);
		BaseEntity entity2 = system.GetEntity(Entity2Id.value);
		if (entity == null || entity2 == null)
		{
			OnActionFinish();
			return;
		}
		Vector3 vector = entity2.transform.position - entity.transform.position;
		vector.y = 0f;
		ResultDir.value = (Quaternion.Euler(0f, OffsetAngleValue.value, 0f) * vector).ToVector2();
		vector = vector.normalized;
		OnActionFinish();
	}
}
