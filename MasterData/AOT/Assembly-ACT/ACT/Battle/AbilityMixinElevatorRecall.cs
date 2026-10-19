using ACT.Battle.Configs;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.Precache;
using EasyCharacterMovement;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinElevatorRecall : BaseAbilityMixin
{
	private ConfigMixinElevatorRecall m_Config;

	private Vector3 m_Pos;

	private Vector3 m_RecallPos;

	private Vector3 m_Offest;

	private bool m_IsStartTp;

	private EffectRuntimeItem m_Effect;

	public AbilityMixinElevatorRecall(ConfigMixinElevatorRecall config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinElevatorRecall)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Pos = default;
		m_RecallPos = default;
		m_Offest = default;
		m_IsStartTp = false;
		m_Effect = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetRoot().SetActive(value: false);
		m_RecallPos = ((DarkCoreStoneData)caster.GetCompStateObject().StateWorldAssetData).recallPoint.pos.value;
		MonoECS.instance.PushPauseInput();
		CharacterMovement characterMovement = owner.GetCompPhysics().characterMovement;
		Vector3 pos = characterMovement.position + characterMovement.rotation * (characterMovement.height / 2f * Vector3.up);
		m_Pos = pos;
		Vector3 normalized = (m_RecallPos - m_Pos).normalized;
		m_Offest = m_Config.vectory * normalized * Time.fixedDeltaTime;
		m_IsStartTp = true;
		m_Effect = GameManager.effectSystem.FireEffect(m_Config.effectReferenceAssetID, m_Pos, Quaternion.identity);
	}

	internal override void FixedUpdate()
	{
		if (m_IsStartTp)
		{
			m_Pos += m_Offest;
			if (m_Effect.go != null)
			{
				m_Effect.go.transform.localPosition += m_Offest;
			}
			owner.Teleport(m_Pos);
			if ((owner.GetCompTransform().physicsPosition - m_RecallPos).sqrMagnitude < 0.05f)
			{
				m_IsStartTp = false;
				GameManager.effectSystem.CleanEffect(m_Effect);
				PrecacheManager.Instance.ReleaseInstanceHandle(m_Effect.instanceHandle);
				owner.GetRoot().SetActive(value: true);
				MonoECS.instance.PopPauseInput();
				owner.GetCompAbility().RemoveAbility(m_Config.name);
			}
		}
	}
}
