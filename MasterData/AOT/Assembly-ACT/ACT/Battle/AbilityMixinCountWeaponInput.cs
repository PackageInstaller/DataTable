using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinCountWeaponInput : BaseAbilityMixin
{
	private ConfigMixinCountWeaponInput m_Config;

	private int m_Count;

	private float m_Window;

	private float m_Duration;

	private bool m_LastW1;

	private bool m_LastW2;

	private bool m_HasW1;

	private bool m_HasW2;

	public AbilityMixinCountWeaponInput(ConfigMixinCountWeaponInput config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_Count = 0;
		m_Window = 0f;
		m_Duration = 0f;
		m_LastW1 = false;
		m_LastW2 = false;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinCountWeaponInput)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Count = 0;
		m_Window = 0f;
		m_Duration = 0f;
		m_LastW1 = false;
		m_LastW2 = false;
		m_HasW1 = false;
		m_HasW2 = false;
		base.ResetForPool();
	}

	private static bool EnsurePressRecParam(CompMotion compMotion, string paramName)
	{
		if (compMotion.parameters.ContainsKey(paramName))
		{
			return true;
		}
		compMotion.parameters[paramName] = new ConfigAnimParameter
		{
			name = paramName,
			type = ConfigAnimParameterType.Bool,
			defaultBool = false,
			defaultFloat = 0f,
			defaultInt = 0
		};
		return true;
	}

	internal override void OnAdd()
	{
		CompMotion compMotion = owner.GetCompMotion();
		bool flag = (m_Config.weaponMask & EWeaponInputType.Weapon1) != 0;
		bool flag2 = (m_Config.weaponMask & EWeaponInputType.Weapon2) != 0;
		m_HasW1 = flag && EnsurePressRecParam(compMotion, "ButtonAPressRec");
		m_HasW2 = flag2 && EnsurePressRecParam(compMotion, "ButtonBPressRec");
		if (!m_HasW1 && !m_HasW2 && LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"[{ability}] 未注册 WEAPON1PRESS_REC/WEAPON2PRESS_REC 状态机参数，按键统计 Mixin 不生效。");
		}
		m_Count = 0;
		m_LastW1 = false;
		m_LastW2 = false;
		ActionMemory memory = new ActionMemory(ability.caster, owner, FindTargetResult.EntityOnly(owner), null, ability);
		m_Duration = m_Config.duration.Return(memory);
		m_Window = ((m_Duration > 0f) ? m_Duration : 0f);
	}

	internal override void OnRemove()
	{
	}

	internal override void OnSilentRemove()
	{
	}

	internal override void FixedUpdate()
	{
		if (m_Duration > 0f)
		{
			m_Window -= ability.timePast;
			if (m_Window <= 0f)
			{
				m_Window = m_Duration;
				m_Count = 0;
				m_LastW1 = false;
				m_LastW2 = false;
			}
		}
		bool flag = false;
		if (m_HasW1)
		{
			bool motionBool = owner.GetMotionBool("ButtonAPressRec");
			if (motionBool && !m_LastW1)
			{
				flag = true;
			}
			m_LastW1 = motionBool;
			if (motionBool)
			{
				owner.GetCompMotion().ResetBool("ButtonAPressRec");
			}
		}
		if (m_HasW2)
		{
			bool motionBool2 = owner.GetMotionBool("ButtonBPressRec");
			if (motionBool2 && !m_LastW2)
			{
				flag = true;
			}
			m_LastW2 = motionBool2;
			if (motionBool2)
			{
				owner.GetCompMotion().ResetBool("ButtonBPressRec");
			}
		}
		if (!flag)
		{
			return;
		}
		m_Count++;
		ActionMemory memory = new ActionMemory(ability.caster, owner, FindTargetResult.EntityOnly(owner), null, ability);
		int num = (int)m_Config.threshold.Return(memory);
		if (num > 0 && m_Count >= num)
		{
			DoActions(owner, null, m_Config.triggerActions);
			if (m_Config.resetOnTrigger)
			{
				m_Count = 0;
			}
		}
	}
}
