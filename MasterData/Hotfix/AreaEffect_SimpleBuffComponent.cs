using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_Buff(简易)")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_SimpleBuffComponent : AreaEffect_Component
{
	public List<int> buffIdList;

	public TargetFilterCriteriaInfo criteriaInfo;

	public bool ignoreTargetSearchableState;

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if ((!ignoreTargetSearchableState && !_context.CheckEntitySearchable(entity)) || !(entity is AdventureActor adventureActor) || !_context.CheckTarget(adventureActor, criteriaInfo) || (checkTargetWithTag && _checkTagHashCode != 0 && !adventureActor.CheckTag(_checkTagHashCode)))
		{
			return;
		}
		List<int> list = buffIdList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (int buffId in buffIdList)
		{
			if (buffId > 0)
			{
				adventureActor.buffComponent?.AddBuff(buffId, _owner);
			}
		}
	}

	protected override void OnDeterministicCollisionExit(LogicEntity entity)
	{
		base.OnDeterministicCollisionExit(entity);
		if ((!ignoreTargetSearchableState && !_context.CheckEntitySearchable(entity)) || !(entity is AdventureActor adventureActor) || !_context.CheckTarget(adventureActor, criteriaInfo) || (checkTargetWithTag && _checkTagHashCode != 0 && !adventureActor.CheckTag(_checkTagHashCode)))
		{
			return;
		}
		List<int> list = buffIdList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (int buffId in buffIdList)
		{
			if (buffId > 0)
			{
				adventureActor.buffComponent?.RemoveBuffByBuffId(buffId, 1);
			}
		}
	}
}
