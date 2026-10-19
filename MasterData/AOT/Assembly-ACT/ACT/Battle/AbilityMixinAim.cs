using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinAim : BaseAbilityMixin
{
	private ConfigMixinAim m_Config;

	private ActionMemory memory;

	private Entity m_AimTarget;

	private Vector3 m_AimTargetPos;

	private Vector3 m_AimPosOffset;

	private Transform m_StartAimTrans;

	private Vector3 m_StartAimPos;

	private float m_SqrMin;

	private float m_SqrMax;

	private bool m_CheckOutOfRangeRes;

	private bool m_IsAimed;

	private bool m_IsFirstAim = true;

	public AbilityMixinAim(ConfigMixinAim config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_SqrMin = m_Config.lenRange.x * m_Config.lenRange.x;
		m_SqrMax = m_Config.lenRange.y * m_Config.lenRange.y;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinAim)config;
		m_SqrMin = m_Config.lenRange.x * m_Config.lenRange.x;
		m_SqrMax = m_Config.lenRange.y * m_Config.lenRange.y;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		memory = default;
		m_AimTarget = default;
		m_AimTargetPos = default;
		m_AimPosOffset = default;
		m_StartAimTrans = null;
		m_StartAimPos = default;
		m_SqrMin = 0f;
		m_SqrMax = 0f;
		m_CheckOutOfRangeRes = false;
		m_IsAimed = false;
		m_IsFirstAim = true;
		base.ResetForPool();
	}

	public bool CheckOutOfRange(Entity target, out float sqr)
	{
		sqr = 0f;
		if (!target.IsActive() || !target.IsAlive())
		{
			return false;
		}
		Vector3 vector = GetAimPos(target) - m_StartAimPos;
		Vector3 vector2 = owner.GetCompTransform().FaceRotation * Vector3.forward;
		Vector3 vector3 = Vector3.Cross(vector2, Vector3.up);
		if (vector3.sqrMagnitude <= Mathf.Epsilon)
		{
			return false;
		}
		vector = Vector3.ProjectOnPlane(vector, vector3);
		sqr = vector.sqrMagnitude;
		if (sqr <= Mathf.Epsilon)
		{
			return false;
		}
		float num = Vector3.SignedAngle(vector2, vector, vector3);
		if (m_Config.angleRange.x <= num && num <= m_Config.angleRange.y)
		{
			if (m_SqrMin <= sqr)
			{
				return sqr <= m_SqrMax;
			}
			return false;
		}
		return false;
	}

	private void UpdateStartAim()
	{
		if (owner.IsTrajectory())
		{
			m_StartAimPos = (m_StartAimTrans = owner.GetRootTransform()).position;
			return;
		}
		if (m_Config.aimType == AimType.useIk)
		{
			m_StartAimTrans = owner.GetCompAim().ikOriginTrans;
		}
		else
		{
			owner.GetMono().TryGetAttachPoint(m_Config.aimPos, out m_StartAimTrans);
		}
		m_StartAimPos = ((m_StartAimTrans == null) ? owner.GetCompTransform().physicsPosition : m_StartAimTrans.position);
	}

	internal override void OnAdd()
	{
		memory = new ActionMemory(caster, owner, owner);
		if (m_Config.configFunction != null)
		{
			m_AimPosOffset = m_Config.configFunction.Return(memory);
		}
		else
		{
			m_AimPosOffset = Vector3.zero;
		}
		CompAim compAim = owner.GetCompAim();
		compAim.rotateSpeed = m_Config.rotateSpeed;
		if (m_Config.aimType == AimType.useIk)
		{
			if (compAim.aimIK == null)
			{
				compAim.useIK = false;
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"角色[{owner}]的技能[{ability}]配置了AimIK，但模型上没有AimIK组件。");
				}
			}
			else
			{
				compAim.ikOriginTrans = compAim.aimIK.solver.transform;
				compAim.useIK = true;
			}
		}
		else if (m_Config.defaultAimPos != null)
		{
			compAim.aimTargetPosition = m_Config.defaultAimPos.Return(memory);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"角色[{owner}]的技能[{ability}]没有默认的瞄准方向");
		}
		UpdateStartAim();
		compAim.ClearAimEntity();
		Entity hatred = owner.GetCompHatred().GetHatred();
		if (hatred.IsValid)
		{
			m_CheckOutOfRangeRes = CheckOutOfRange(hatred, out var _);
			if (m_CheckOutOfRangeRes)
			{
				StartAim(hatred);
			}
		}
	}

	internal override void OnRemove()
	{
		CompAim compAim = owner.GetCompAim();
		compAim.aiming = false;
		if (m_Config.aimType == AimType.useIk)
		{
			compAim.useIK = false;
			if (compAim.aimIK != null)
			{
				compAim.aimIK.solver.IKPositionWeight = 0f;
			}
		}
	}

	internal override void FixedUpdate()
	{
		UpdateStartAim();
		Entity hatred = owner.GetCompHatred().GetHatred();
		if (hatred.IsValid)
		{
			m_CheckOutOfRangeRes = CheckOutOfRange(hatred, out var _);
			if (m_CheckOutOfRangeRes)
			{
				if (m_IsAimed)
				{
					SetAimPos(GetAimPos(m_AimTarget));
				}
				else
				{
					StartAim(hatred);
				}
			}
			else if (m_IsAimed)
			{
				LoseAim();
			}
		}
		else if (m_IsAimed)
		{
			LoseAim();
		}
	}

	internal override void Update()
	{
		if (!m_IsAimed)
		{
			return;
		}
		if (m_Config.aimType == AimType.useLookAt)
		{
			if (m_StartAimTrans != null)
			{
				m_StartAimTrans.rotation = Quaternion.LookRotation(owner.GetCompAim().aimTargetPosition - m_StartAimPos);
			}
		}
		else if (m_Config.aimType == AimType.useIk)
		{
			owner.GetCompAim().UpdateIKPosition();
		}
	}

	private void StartAim(Entity entityBehave)
	{
		if (!m_IsFirstAim && !m_Config.canReAim)
		{
			return;
		}
		m_IsAimed = true;
		CompAim compAim = owner.GetCompAim();
		compAim.aiming = true;
		compAim.aimEntity = (m_AimTarget = entityBehave);
		Vector3 aimPos = GetAimPos(m_AimTarget);
		if (m_IsFirstAim)
		{
			switch (m_Config.aimInitialDirType)
			{
			case AimInitialDirType.AimTargetDir:
				compAim.aimTargetPosition = aimPos;
				break;
			case AimInitialDirType.FixedDir:
				compAim.aimTargetPosition = m_Config.fixAimInitialPos.Return(memory);
				break;
			default:
				throw new ArgumentOutOfRangeException();
			}
		}
		SetAimPos(aimPos);
	}

	private void LoseAim()
	{
		m_IsAimed = false;
		m_IsFirstAim = false;
		CompAim? compAim = owner.GetCompAim();
		compAim.aiming = false;
		compAim.ClearAimEntity();
		SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, m_Config.onLosingAim);
	}

	private void SetAimPos(Vector3 pos)
	{
		CompAim compAim = owner.GetCompAim();
		Vector3 vector = pos - m_StartAimPos;
		Vector3 vector2 = compAim.aimTargetPosition - m_StartAimPos;
		float num = Vector3.Angle(vector2, vector);
		float num2 = compAim.rotateSpeed * owner.GetCompTime().motionFixedDeltaTime;
		Vector3 vector3 = Vector3.Slerp(t: (num == 0f) ? 1f : Mathf.Min(1f, num2 / num), a: vector2, b: vector);
		Vector3 aimPosition = m_StartAimPos + vector3.normalized * vector.magnitude;
		compAim.SetAimPosition(aimPosition);
		if (m_Config.aimType == AimType.useIk)
		{
			compAim.UpdateIKPosition();
		}
	}

	private Vector3 GetAimPos(Entity entity)
	{
		Vector3 vector = Vector3.zero;
		switch (m_Config.aimTargetPosType)
		{
		case AimTargetPosType.waist:
		{
			vector = ((entity.IsTrajectory() || !entity.GetMono().TryGetAttachPoint(BattleConsts.AIM_ATTACH_POINT, out var attackPoint)) ? (entity.GetCompTransform().physicsPosition + m_AimPosOffset) : (attackPoint.position + (owner.IsFaceLeft() ? (-m_AimPosOffset) : m_AimPosOffset)));
			break;
		}
		case AimTargetPosType.footPos:
			vector = entity.GetCompTransform().physicsPosition + m_AimPosOffset;
			break;
		case AimTargetPosType.groundPos:
		{
			vector = entity.GetCompTransform().physicsPosition;
			Vector3 down = Vector3.down;
			if (Physics.Raycast(new Ray(vector, down), out var hitInfo, 20f, BattleConsts.enviromentMask))
			{
				vector = hitInfo.point;
			}
			vector += m_AimPosOffset;
			break;
		}
		}
		return vector;
	}
}
