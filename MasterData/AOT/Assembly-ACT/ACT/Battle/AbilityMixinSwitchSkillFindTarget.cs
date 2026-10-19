using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinSwitchSkillFindTarget : BaseAbilityMixin
{
	private ConfigMixinSwitchSkillFindTarget _config;

	private Vector3 _foundPos;

	private FindTargetResult _foundTarget;

	public AbilityMixinSwitchSkillFindTarget(ConfigMixinSwitchSkillFindTarget config, Ability ab, byte index)
		: base(ab, index)
	{
		_config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		_config = (ConfigMixinSwitchSkillFindTarget)config;
	}

	internal override void ResetForPool()
	{
		_config = null;
		_foundPos = default;
		_foundTarget = default;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtFindSwitchPos), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtFindSwitchPos), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtFindSwitchPos evtFindSwitchPos))
		{
			return;
		}
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		List<FindTargetResult> list2 = ListPool<FindTargetResult>.Get();
		TargetBounds forwardBounds = evtFindSwitchPos.forwardBounds;
		TargetBounds backBounds = evtFindSwitchPos.backBounds;
		BaseFindTargetsByArea.FindBoundsTargets(evtFindSwitchPos.beforeEntity, forwardBounds, BattleConsts.hitMask | BattleConsts.entityMask, list);
		_config.Where.FindTargets(list, ability.owner);
		RemoveDamageable(list);
		if (list.Count > 0)
		{
			DistanceComparer distanceComparer = new DistanceComparer();
			list.Sort(distanceComparer.Compare);
			_foundTarget = list[0];
			evtFindSwitchPos.data.target = _foundTarget.entity;
			_foundPos = _foundTarget.entity.GetCompTransform().physicsPosition;
			CompTransform compTransform = owner.GetCompTransform();
			MonoEntity mono = _foundTarget.entity.GetMono();
			float num = (_foundPos - compTransform.physicsPosition).sqrMagnitude;
			if (mono.switchSkillPoints != null)
			{
				Transform[] switchSkillPoints = mono.switchSkillPoints;
				for (int i = 0; i < mono.switchSkillPoints.Length; i++)
				{
					float sqrMagnitude = (switchSkillPoints[i].position - compTransform.physicsPosition).sqrMagnitude;
					if (sqrMagnitude < num)
					{
						_foundPos = switchSkillPoints[i].position;
						num = sqrMagnitude;
					}
				}
			}
			CompPhysics compPhysics = _foundTarget.entity.GetCompPhysics();
			if ((compPhysics != null && compPhysics.overlapEntityMode == OverlapEntityMode.Uncrossable) || _foundTarget.entity.InTag(MotionTag_backUp.Uncrossable))
			{
				evtFindSwitchPos.data.uncrossableOffsetX = (mono.bodyParts[0]?.myCollider.bounds.size.x ?? 0f) / 2f;
			}
		}
		else
		{
			BaseFindTargetsByArea.FindBoundsTargets(evtFindSwitchPos.beforeEntity, backBounds, BattleConsts.entityMask, list2);
			_config.Where.FindTargets(list2, ability.owner);
			RemoveDamageable(list2);
			if (list2.Count > 0)
			{
				DistanceComparer distanceComparer2 = new DistanceComparer();
				list2.Sort(distanceComparer2.Compare);
				_foundTarget = list2[0];
				_foundPos = _foundTarget.entity.GetCompTransform().physicsPosition;
				evtFindSwitchPos.data.target = _foundTarget.entity;
			}
		}
		evtFindSwitchPos.data.foundPos = _foundPos;
		ListPool<FindTargetResult>.Release(list);
		ListPool<FindTargetResult>.Release(list2);
	}

	private void RemoveDamageable(List<FindTargetResult> results)
	{
		for (int num = results.Count - 1; num >= 0; num--)
		{
			if (results[num].targetSourceType == FindTargetResult.TargetSourceType.Damageable)
			{
				results.RemoveAt(num);
			}
		}
	}
}
