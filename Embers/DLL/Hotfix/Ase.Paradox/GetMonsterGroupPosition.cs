using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取怪物所在怪物组的世界坐标坐标", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取怪物所在怪物组的世界坐标坐标")]
public class GetMonsterGroupPosition : ActionTaskBase
{
	[Name("怪物实体ID", 0)]
	[Description("怪物实体ID")]
	public BBParameter<int> MonsterEntityId;

	[Name("怪物组世界坐标", 0)]
	[Description("怪物组世界坐标")]
	public BBParameter<Vector3> MonsterGroupPos;

	protected override void OnExecute()
	{
		MonsterGroupPos.value = Vector3.zero;
		base.OnExecute();
		BaseEntity entity = GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(MonsterEntityId.value);
		entity = entity as MonsterEntity;
		if (entity == null)
		{
			OnActionFinish();
			return;
		}
		MonsterGroup data = entity.GetData<MonsterGroup>(MonsterGroup.MONSTERGROUP_KEY);
		if ((Object)(object)data == null)
		{
			OnActionFinish();
			return;
		}
		Vector3 vector = data.GetActivityAreaRangeOffset();
		MonsterGroupPos.value = ((Component)(object)data).transform.position + vector;
		OnActionFinish();
	}
}
