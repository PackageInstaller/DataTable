using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinSafeAreaEffect : BaseAbilityMixin
{
	private ConfigMixinSafeAreaEffect m_Config;

	private EffectRuntimeItem m_Effect;

	private bool m_Start;

	private ActionMemory m_Memory;

	public AbilityMixinSafeAreaEffect(ConfigMixinSafeAreaEffect config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinSafeAreaEffect)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Effect = null;
		m_Start = false;
		m_Memory = default;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		EffectPoint point = default;
		EffectPoint point2 = default;
		point.continueouslyFollow = true;
		point.rotateFollowLogicDir = false;
		point.offset = Vector3.zero;
		point.useOwnerRot = false;
		point.oriRotX = 0f;
		point.oriRotY = 0f;
		point.oriRotZ = 0f;
		point.aimTarget = false;
		point.type = EffectPoint.EffectPointType.Character;
		SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
		{
			target = FindTargetResult.EntityOnly(owner),
			patternAssetID = m_Config.effectAssetID,
			removeWhenMotionExit = false,
			timescale = TimeScale.NoScale,
			type = EffectDataType.Point,
			point1 = point,
			point2 = point2,
			removeWhenStop = true,
			changeScale = false,
			effectRangeEnum = EffectRangeEnum.none,
			transformScaleMulBase = Vector3.zero,
			modelType = EffectModelType.Small,
			isChangeWithEntity = true,
			initRotation = default,
			isAttach = true
		};
		m_Effect = GameManager.effectSystem.FireEffect(effectParams);
		m_Effect.attachAbility = ability;
		ability.attachEffects.Add(m_Effect);
		m_Start = true;
		m_Memory = new ActionMemory(owner, owner, owner);
	}

	internal override void FixedUpdate()
	{
		if (!m_Start || !(m_Effect.go != null))
		{
			return;
		}
		bool value = m_Config.checkConfig.Check(m_Memory);
		MonoEffect[] scripts = m_Effect.scripts;
		for (int i = 0; i < scripts.Length; i++)
		{
			if (scripts[i] is MonoAnimatorEffect monoAnimatorEffect)
			{
				monoAnimatorEffect.ani.SetBool(m_Config.name, value);
			}
		}
	}
}
