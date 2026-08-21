using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体是否在副本的活动区域", 0)]
[Category("✫ DragonLost/Entity")]
[Description("获取实体是否在副本的活动区域")]
public class GetEntityInActiveArea : ConditionTaskBase
{
	[Name("目标实体ID", 0)]
	[Description("目标实体ID")]
	public BBParameter<int> targetEntityId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		CreateCopyData mapData = GetOwnerEntity().GetWorld().GetMapData();
		if (mapData == null)
		{
			return false;
		}
		if (!mapData.IsCopyMapData())
		{
			return false;
		}
		BaseEntity entity = GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(targetEntityId.value);
		if (entity == null)
		{
			return false;
		}
		int battleActiveType = mapData.GetBattleActiveType();
		Vector3 battleActiveAreaPos = mapData.GetBattleActiveAreaPos();
		Vector2 battleActiveBounds = mapData.GetBattleActiveBounds();
		return battleActiveType switch
		{
			0 => Vector2.Distance(battleActiveAreaPos, entity.transform.position.ToVector2()) <= battleActiveBounds.x, 
			1 => TSUtil.IsPointInsideBox(battleActiveAreaPos.x, 0.0, battleActiveAreaPos.y, battleActiveBounds.x / 2f, 0.0, battleActiveBounds.y / 2f, entity.transform.position.x, 0.0, entity.transform.position.z), 
			_ => false, 
		};
	}
}
