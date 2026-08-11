using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体是否在怪物组活动区域或者区域边缘", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取目标实体实体是否在怪物所在的怪物组活动区域或者区域边缘，如果勾选了是否在区域边缘就获取是否在区域边缘，否则就获取是否在活动区域")]
public class GetMonsterInAreaRange : ConditionTaskBase
{
	[Name("怪物实体ID", 0)]
	[Description("怪物实体ID")]
	public BBParameter<int> MonsterEntityId;

	[Name("目标实体ID", 0)]
	[Description("目标实体ID")]
	public BBParameter<int> targetEntityId;

	[Name("区域边缘值", 0)]
	[Description("区域边缘值")]
	public BBParameter<float> AreaEdge;

	[Name("是否在区域边缘", 0)]
	[Description("是否在区域边缘")]
	[ShowIf("IsInAreaRange", true)]
	public bool IsInAreaEdge;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(MonsterEntityId.value);
		entity = entity as MonsterEntity;
		if (entity == null)
		{
			return false;
		}
		MonsterGroup data = entity.GetData<MonsterGroup>(MonsterGroup.MONSTERGROUP_KEY);
		if ((Object)(object)data == null)
		{
			return false;
		}
		Vector3 vector = data.GetActivityAreaRangeOffset();
		Vector3 vector2 = ((Component)(object)data).transform.position + vector;
		float num = Vector2.Distance(b: GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(targetEntityId.value).transform.position.ToVector2(), a: vector2.ToVector2());
		if (IsInAreaEdge)
		{
			if (num <= data.GetActivityAreaRange())
			{
				return num >= data.GetActivityAreaRange() - AreaEdge.value;
			}
			return false;
		}
		return num <= data.GetActivityAreaRange();
	}
}
