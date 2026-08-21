using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class HeroIndicatorRingComponent : BaseComponent
{
	private BaseEntity indicatorRingEffect;

	private AnimatorComponent effectAniComp;

	private Dictionary<IndicatorDisPlayEnum, string> animationNameMap;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		LoadIndicatorRingEffect();
	}

	private void InitializeAnimationMap()
	{
		animationNameMap = new Dictionary<IndicatorDisPlayEnum, string>
		{
			{
				IndicatorDisPlayEnum.EnterBattleState,
				"InCombat"
			},
			{
				IndicatorDisPlayEnum.ExitBattleState,
				"OutCombat"
			},
			{
				IndicatorDisPlayEnum.KillMonster,
				"Kill"
			},
			{
				IndicatorDisPlayEnum.XpSkillCanRelease,
				"Skill4On"
			},
			{
				IndicatorDisPlayEnum.XpSkillNoRelease,
				"Skill4Off"
			},
			{
				IndicatorDisPlayEnum.Weapon,
				"ClassResource"
			}
		};
	}

	public void PlayIndicatorRing(IndicatorDisPlayEnum disPlayEnum)
	{
	}

	private void PlayEffectAnimation(string animationName)
	{
		if (effectAniComp == null)
		{
			effectAniComp = indicatorRingEffect.GetComponent<AnimatorComponent>();
		}
		effectAniComp.PlayAnimation(animationName, 0);
	}

	private void LoadIndicatorRingEffect()
	{
		if (mBaseEntity.IsActorEntity && mBaseEntity.EntityViewModel is BattleHeroData { IndicatorRingId: var indicatorRingId })
		{
			DRIndicatorRing dataRow = GameEntry.DataTable.GetDataRow<DRIndicatorRing>(indicatorRingId);
			if (dataRow != null)
			{
				int resPath = dataRow.ResPath;
				EffectSystem system = mBaseEntity.GetSystem<EffectSystem>();
				indicatorRingEffect = system.PlayEffect(mBaseEntity, mBaseEntity, EffectType.FOLLOW_BONE, resPath, "IndicatorRing", Vector3.zero, Vector3.zero, Quaternion.identity.eulerAngles, Vector3.zero, followParentDispose: true);
			}
		}
	}

	public void SetIndicateRingShow(bool isShow)
	{
		if (!mBaseEntity.IsActorEntity || indicatorRingEffect == null)
		{
			return;
		}
		EntityViewComponent component = indicatorRingEffect.GetComponent<EntityViewComponent>();
		if (component != null)
		{
			if (!isShow)
			{
				component.HideEntityView();
			}
			else
			{
				component.ShowEntityView();
			}
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (indicatorRingEffect != null)
		{
			indicatorRingEffect.DoEntityRelease();
			indicatorRingEffect = null;
		}
	}
}
