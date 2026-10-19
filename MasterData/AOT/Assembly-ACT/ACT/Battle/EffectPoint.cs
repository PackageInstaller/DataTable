using System;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public struct EffectPoint
{
	public enum EffectPointType
	{
		Character,
		AttachPoint,
		HitPoint,
		RayHitPoint,
		ConstPoint,
		curCamera,
		CustomTrans,
		TargetGroundPos,
		hookPoint,
		HitLocationPoint
	}

	public enum RayHitPointType
	{
		Start,
		End
	}

	public ConfigFunction<Vector3> constPointPos;

	[Tooltip("为true代表跟随， 为false反之")]
	public bool continueouslyFollow;

	public bool rotateFollowLogicDir;

	public bool rotateNotFollow;

	public bool rotatationRandom;

	public Vector3 rotatationRandomMin;

	public Vector3 rotatationandomMax;

	public Vector3 offset;

	public Vector3 rotateOffset;

	public bool useInitRotation;

	[HideInInspector]
	public bool useOwnerRot;

	[Range(-180f, 180f)]
	public float oriRotX;

	[Range(-180f, 180f)]
	public float oriRotY;

	[Range(-180f, 180f)]
	public float oriRotZ;

	public EffectPointType type;

	public string attachPoint;

	public bool activeWithAttachPoint;

	public string rayHitName;

	public string customName;

	public float lerpWeight;

	public float groundPosCheckLength;

	public bool aimTarget;

	public RayHitPointType rayHitPointType;

	private const float DefaultGroundPosCheckLength = 20f;

	private Transform m_CacheTrans;

	private EffectTran m_EffectTran;

	private Transform CacheTrans
	{
		get
		{
			return m_CacheTrans;
		}
		set
		{
			m_CacheTrans = value;
		}
	}

	public Quaternion initRotation { get; set; }

	public Vector3 pos { get; private set; }

	public Quaternion rot { get; private set; }

	public float randomRot { get; private set; }

	public Vector3 RandomRotOffset { get; private set; }

	private void EnsureGroundPosCheckLengthDefault()
	{
		if (type == EffectPointType.TargetGroundPos && groundPosCheckLength <= 0f)
		{
			groundPosCheckLength = 20f;
		}
	}

	public bool SyncTrans(bool init)
	{
		bool flag = init || continueouslyFollow;
		if (flag && m_CacheTrans != null)
		{
			pos = m_CacheTrans.position;
			rot = m_CacheTrans.rotation;
		}
		else if (flag && m_EffectTran != null)
		{
			if (init || lerpWeight < 0f)
			{
				pos = m_EffectTran.pos;
				rot = m_EffectTran.rot;
			}
			else
			{
				pos = Vector3.Lerp(pos, m_EffectTran.pos, lerpWeight * Time.deltaTime);
				rot = Quaternion.Slerp(rot, m_EffectTran.rot, lerpWeight * Time.deltaTime);
			}
		}
		return flag;
	}

	public void SetConstTrans(Vector3 pos)
	{
		m_CacheTrans = null;
		this.pos = pos;
		rot = Quaternion.identity;
	}

	public void SetConstTrans(Vector3 pos, Quaternion rot)
	{
		m_CacheTrans = null;
		this.pos = pos;
		this.rot = rot;
	}

	public void SetStartTrans(FindTargetResult target, Vector3 effectPos = default(Vector3), bool refreshRandom = true)
	{
		try
		{
			if (refreshRandom)
			{
				RandomRotOffset = new Vector3(UnityEngine.Random.Range(rotatationRandomMin.x, rotatationandomMax.x), UnityEngine.Random.Range(rotatationRandomMin.y, rotatationandomMax.y), UnityEngine.Random.Range(rotatationRandomMin.z, rotatationandomMax.z));
			}
			CompBehave? compBehave = target.entity.GetCompBehave();
			Transform transform = compBehave?.Model?.transform;
			Transform transform2 = compBehave?.Root?.transform;
			MonoEntity monoEntity = compBehave?.MonoEntity;
			switch (type)
			{
			case EffectPointType.Character:
				CacheTrans = ((transform != null) ? transform : transform2);
				break;
			case EffectPointType.HitPoint:
			{
				m_CacheTrans = null;
				float z = transform2.position.z;
				if (target.bodyIndex > 0)
				{
					z = monoEntity.bodyParts[target.bodyIndex - 1].transform.position.z;
				}
				pos = new Vector3(target.TouchPos.x, target.TouchPos.y, z);
				randomRot = UnityEngine.Random.Range(0f - GameLoader.meta.EffectRandomAngle, GameLoader.meta.EffectRandomAngle);
				if (!target.TouchForward.isZero())
				{
					rot = Quaternion.LookRotation(target.TouchForward);
				}
				break;
			}
			case EffectPointType.AttachPoint:
			{
				AttachPoint attachPointAll = monoEntity.GetAttachPointAll(attachPoint);
				if (attachPointAll.forward != null)
				{
					attachPointAll.forward.position = attachPointAll.GetPos();
				}
				CacheTrans = ((attachPointAll.forward != null) ? attachPointAll.forward : attachPointAll.transform);
				break;
			}
			case EffectPointType.RayHitPoint:
			{
				if (!string.IsNullOrEmpty(rayHitName) && target.entity.GetCompEffect().rayEffectInfos.TryGetValue(rayHitName, out var value2))
				{
					Vector3 vector = rayHitPointType switch
					{
						RayHitPointType.Start => value2.startPos, 
						RayHitPointType.End => value2.endPos, 
						_ => throw new NotImplementedException(), 
					};
					vector = new Vector3(vector.x, vector.y, transform2.position.z);
					SetConstTrans(vector);
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"未设置过rayHitName为'{rayHitName}'的射线信息却尝试在{target.entity}的技能中获取!");
				}
				break;
			}
			case EffectPointType.curCamera:
				CacheTrans = MonoECS.instance.entityLocal.compCamera.mainCamera.transform;
				break;
			case EffectPointType.ConstPoint:
				pos = effectPos;
				break;
			case EffectPointType.CustomTrans:
			{
				if (!string.IsNullOrEmpty(customName) && target.entity.GetCompEffect().customEffectTran.TryGetValue(customName, out var value))
				{
					m_EffectTran = value;
				}
				break;
			}
			case EffectPointType.TargetGroundPos:
				CacheTrans = transform2;
				break;
			case EffectPointType.hookPoint:
				pos = target.entity.GetCompPhysics().HookPoint;
				break;
			case EffectPointType.HitLocationPoint:
				pos = target.entity.GetCompPhysics().HitLocationPoint;
				break;
			}
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Fire effect Failed！ FindTargetResult is {target} \n Entity is {target.entity} \n Damageable is  {target.damageable}");
			}
			throw;
		}
	}

	internal void RefreshFollowOwner(FindTargetResult target)
	{
		EffectPointType effectPointType = type;
		if ((uint)effectPointType <= 1u || (uint)(effectPointType - 6) <= 3u)
		{
			SetStartTrans(target, default, refreshRandom: false);
		}
	}

	public Vector3 SetTrans(Entity entity)
	{
		Vector3 vector = Vector3.zero;
		MonoEntity mono = entity.GetMono();
		Transform transform = entity.GetRoot().transform;
		Transform transform2 = entity.GetModel().transform;
		switch (type)
		{
		case EffectPointType.Character:
			vector = ((transform2 != null) ? transform2.position : transform.position);
			vector += offset;
			break;
		case EffectPointType.HitPoint:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("后处理设置位置用不了HitPoint");
			}
			vector = ((transform2 != null) ? transform2.position : transform.position);
			vector += offset;
			break;
		case EffectPointType.AttachPoint:
		{
			AttachPoint attachPointAll = mono.GetAttachPointAll(attachPoint);
			if (attachPointAll.forward != null)
			{
				attachPointAll.forward.position = attachPointAll.GetPos();
			}
			vector = ((attachPointAll.forward != null) ? attachPointAll.forward.position : attachPointAll.transform.position);
			vector += offset;
			break;
		}
		case EffectPointType.RayHitPoint:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"未设置过rayHitName为'{rayHitName}'的射线信息却尝试在{entity}的技能中获取!");
			}
			vector = ((transform2 != null) ? transform2.position : transform.position);
			vector += offset;
			break;
		case EffectPointType.curCamera:
			vector = MonoECS.instance.entityLocal.compCamera.mainCamera.transform.position;
			vector += offset;
			break;
		case EffectPointType.ConstPoint:
			vector = ((transform2 != null) ? transform2.position : transform.position);
			vector += offset;
			break;
		case EffectPointType.CustomTrans:
		{
			if (!string.IsNullOrEmpty(customName) && entity.GetCompEffect().customEffectTran.TryGetValue(customName, out var value))
			{
				vector = value.pos;
				vector += offset;
			}
			break;
		}
		case EffectPointType.TargetGroundPos:
		{
			vector = ((transform2 != null) ? transform2.position : transform.position);
			Vector3 down = Vector3.down;
			if (Physics.Raycast(new Ray(vector, down), out var hitInfo, 20f, BattleConsts.enviromentMask))
			{
				vector = hitInfo.point;
			}
			vector += offset;
			break;
		}
		}
		return vector;
	}

	public bool ShouldShowWithAttachPoint(Entity entity)
	{
		if (!entity.IsValid)
		{
			return true;
		}
		Transform transform = entity.GetModel().transform;
		if (transform != null && !transform.gameObject.activeInHierarchy)
		{
			return false;
		}
		AttachPoint attachPointAll = entity.GetMono().GetAttachPointAll(attachPoint);
		if (attachPointAll.transform != null && !attachPointAll.transform.gameObject.activeInHierarchy)
		{
			return false;
		}
		return true;
	}
}
