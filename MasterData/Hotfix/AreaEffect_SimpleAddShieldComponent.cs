using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_护盾(简易)")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_SimpleAddShieldComponent : AreaEffect_Component
{
	public List<int> shieldIdList;

	public TargetFilterCriteriaInfo criteriaInfo;

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (!_context.CheckEntitySearchable(entity) || !(entity is AdventureActor adventureActor) || !_context.CheckTarget(adventureActor, criteriaInfo) || (checkTargetWithTag && _checkTagHashCode != 0 && !adventureActor.CheckTag(_checkTagHashCode)))
		{
			return;
		}
		List<int> list = shieldIdList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (int shieldId in shieldIdList)
		{
			if (shieldId > 0)
			{
				adventureActor.actorShield?.AddShield(shieldId, _owner);
			}
		}
	}

	protected override void OnDeterministicCollisionExit(LogicEntity entity)
	{
		base.OnDeterministicCollisionExit(entity);
		if (!_context.CheckEntitySearchable(entity) || !(entity is AdventureActor adventureActor) || !_context.CheckTarget(adventureActor, criteriaInfo) || (checkTargetWithTag && _checkTagHashCode != 0 && !adventureActor.CheckTag(_checkTagHashCode)))
		{
			return;
		}
		List<int> list = shieldIdList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (int shieldId in shieldIdList)
		{
			if (shieldId > 0)
			{
				adventureActor.actorShield?.RemoveShieldByShieldID(shieldId);
			}
		}
	}
}
