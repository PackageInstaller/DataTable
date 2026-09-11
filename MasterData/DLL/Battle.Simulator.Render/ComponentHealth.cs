using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using UnityEngine;

public class ComponentHealth : CMonoBehaviour
{
	public class HitTipEventData : IFramePooledObject
	{
		public int DefensorID;

		public int AttackerID;

		public long DamageAmount;

		public DamageType DamageType;

		public int AbilityID;

		public Vector3 Position;

		public void OnEnterPool()
		{
			DefensorID = 0;
			AttackerID = 0;
			DamageAmount = 0L;
			DamageType = DamageType.None;
			AbilityID = 0;
			Position = Vector3.zero;
		}
	}

	[Tooltip("Current health of the character.")]
	public long Health = 100L;

	[Tooltip("Max health to regenerate to.")]
	public long MaxHealth = -2147483648L;

	public float FAST_BLOOD_SPEED = 1200f;

	public float SLOW_BLOOD_SPEED = 100f;

	public int HpStripCount = 1;

	public long HealthChangeSlowly;

	public int PowerValue;

	public int MaxPowerValue;

	public int PowerValueChangeSlowly;

	public int UniqueValue;

	public int UniqueMaxValue;

	public int MaxEnduranceValue;

	public int EnduranceValue;

	public bool ResistanceState;

	public int ResistanceMaxValue;

	public int ResistanceCurValue;

	public uint ResistanceMaxTime;

	public uint ResistanceCurTime;

	public float HealthChangeSlowlyAccelerationAspect = 0.5f;

	public float HealthChangeSlowlyStartDelayTime = 0.1f;

	private bool _isDelaying = true;

	private bool _isPowerDelaying = true;

	private float _delayingTime;

	private float _powerDelayingTime;

	private bool _isChanging;

	private bool _isPowerChanging;

	public float _HealthChangeSlowlySpeed = 0.1f;

	public float _PowerChangeSlowlySpeed = 1f;

	private float disappearDistance;

	public float maxShowHpTime = 12f;

	public int uishake;

	private List<HitTipEventData> _TipEventDataList = new List<HitTipEventData>(50);

	private Transform _HitPoint;

	public override void Initialize()
	{
		base.Initialize();
		if ((bool)mAgent)
		{
			BBCommom blackboard = mAgent.Blackboard;
			blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new BBCommom.AgentActionHandler(handleAction));
			Health = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.HP;
			MaxHealth = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.HP;
			HealthChangeSlowly = Health;
			PowerValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mPowerValue;
			MaxPowerValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mMaxPowerValue;
			PowerValueChangeSlowly = PowerValue;
			UniqueValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mUniqueValue;
			UniqueMaxValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mUniqueMaxValue;
			EnduranceValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mEnduranceValue;
			MaxEnduranceValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mMaxEnduranceValue;
		}
	}

	private void handleAction(AgentAction action)
	{
		if (action is AgentActionHurt)
		{
			OnHurt(action as AgentActionHurt);
		}
	}

	private void OnValidate()
	{
		Health = Math.Max(0L, Health);
		MaxHealth = Math.Max(0L, MaxHealth);
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		if (mAgent != null && mAgent.Blackboard != null)
		{
			BBCommom blackboard = mAgent.Blackboard;
			blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(blackboard.ActionHandler, new BBCommom.AgentActionHandler(handleAction));
		}
		_TipEventDataList.Clear();
	}

	public override void LateUpdateBehavior()
	{
		base.LateUpdateBehavior();
		if (_TipEventDataList.Count <= 0)
		{
			return;
		}
		if (_HitPoint == null)
		{
			AttachPointSetup component = base.transform.GetComponent<AttachPointSetup>();
			if (component != null)
			{
				_HitPoint = component.GetAttachPoint(En_BaseAttachPointType.HitPoint);
			}
			else
			{
				_HitPoint = base.transform;
			}
		}
		for (int num = _TipEventDataList.Count - 1; num >= 0; num--)
		{
			HitTipEventData hitTipEventData = _TipEventDataList[num];
			PostCreateHPTipsEvent(hitTipEventData.AbilityID, hitTipEventData.DefensorID, hitTipEventData.DamageAmount, hitTipEventData.DamageType, hitTipEventData.AttackerID, _HitPoint.position);
			_TipEventDataList.RemoveAt(num);
			FrameObjectPool<HitTipEventData>.Release(hitTipEventData);
		}
		_TipEventDataList.Clear();
	}

	public override void DestroyBehavior()
	{
		base.DestroyBehavior();
	}

	public override void UpdateBehavior()
	{
		uishake--;
		if (HealthChangeSlowly < Health)
		{
			HealthChangeSlowly = Health;
		}
		else if (HealthChangeSlowly > Health)
		{
			BBHumanoid bBHumanoid = mAgent.Blackboard as BBHumanoid;
			if (HpStripCount <= 0 || MaxHealth <= 0)
			{
				return;
			}
			long num = MaxHealth / HpStripCount;
			if (_isDelaying)
			{
				_delayingTime += Time.deltaTime;
				if (_delayingTime > HealthChangeSlowlyStartDelayTime)
				{
					_isDelaying = false;
					_isChanging = true;
					_delayingTime = 0f;
				}
			}
			if (_isChanging)
			{
				long num2 = (Health * HpStripCount - 1) / MaxHealth;
				long num3 = (HealthChangeSlowly * HpStripCount - 1) / MaxHealth;
				if (num2 != num3)
				{
					_HealthChangeSlowlySpeed = FAST_BLOOD_SPEED * (float)num / 10000f;
				}
				else
				{
					_HealthChangeSlowlySpeed = SLOW_BLOOD_SPEED * (float)num / 10000f;
				}
				HealthChangeSlowly -= Mathf.FloorToInt(_HealthChangeSlowlySpeed);
				if (HealthChangeSlowly <= Health)
				{
					_isChanging = false;
					_isDelaying = true;
					_HealthChangeSlowlySpeed = 1f;
					HealthChangeSlowly = Health;
				}
				if (num != 0L && HealthChangeSlowly % num == 0L)
				{
					HealthChangeSlowly = Mathf.CeilToInt((float)bBHumanoid.m_NextSimFrameData.HP * 1f / (float)num) * num;
				}
			}
		}
		if (PowerValue > PowerValueChangeSlowly)
		{
			PowerValueChangeSlowly = PowerValue;
		}
		else
		{
			if (_isPowerDelaying)
			{
				_powerDelayingTime += Time.deltaTime;
				if (_powerDelayingTime > HealthChangeSlowlyStartDelayTime)
				{
					_isPowerDelaying = false;
					_isPowerChanging = true;
					_powerDelayingTime = 0f;
				}
			}
			if (_isPowerChanging)
			{
				_PowerChangeSlowlySpeed += HealthChangeSlowlyAccelerationAspect;
				if (_PowerChangeSlowlySpeed > (float)(PowerValueChangeSlowly - PowerValue))
				{
					_PowerChangeSlowlySpeed = PowerValueChangeSlowly - PowerValue;
				}
				PowerValueChangeSlowly -= Mathf.FloorToInt(_PowerChangeSlowlySpeed);
				if (PowerValue == PowerValueChangeSlowly)
				{
					_isPowerChanging = false;
					_PowerChangeSlowlySpeed = 1f;
				}
			}
		}
		if (mAgent.Blackboard is BBHumanoid)
		{
			MaxPowerValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mMaxPowerValue;
			int mPowerValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mPowerValue;
			if (PowerValue != mPowerValue)
			{
				if (!_isPowerChanging && !_isPowerDelaying)
				{
					_isPowerDelaying = true;
				}
				PowerValue = mPowerValue;
			}
		}
		Health = (mAgent.Blackboard as BBHumanoid).HP;
		MaxHealth = (mAgent.Blackboard as BBHumanoid).MaxHP;
		MaxPowerValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mMaxPowerValue;
		EnduranceValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mEnduranceValue;
		MaxEnduranceValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mMaxEnduranceValue;
		UniqueValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mUniqueValue;
		UniqueMaxValue = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mUniqueMaxValue;
		SimFrameData nextSimFrameData = (mAgent.Blackboard as BBHumanoid).m_NextSimFrameData;
		ResistanceState = nextSimFrameData.mResistanceState;
		ResistanceMaxValue = nextSimFrameData.mResistanceMaxValue;
		ResistanceCurValue = nextSimFrameData.mResistanceCurValue;
		ResistanceMaxTime = nextSimFrameData.mResistanceMaxTime;
		ResistanceCurTime = nextSimFrameData.mResistanceCurTime;
	}

	private void OnHurt(AgentActionHurt hurt)
	{
		if (mAgent.Blackboard is BBHumanoid)
		{
			if (!_isChanging && !_isDelaying)
			{
				_isDelaying = true;
			}
			BBHumanoid bBHumanoid = mAgent.Blackboard as BBHumanoid;
			Health = bBHumanoid.HP;
			MaxHealth = bBHumanoid.MaxHP;
		}
		hurt.SetSuccess();
		Health = ((Health <= 0) ? 0 : Health);
		if (hurt.DamageAmount < 0)
		{
			uishake = 2;
		}
		if (hurt.DamageAmount != 0L || hurt.damageType != DamageType.Recover)
		{
			AddHitTipEventData(mAgent.AgentID, hurt.SourceID, hurt.DamageAmount, hurt.damageType, hurt.ActionID);
		}
	}

	public void PostCreateHPTipsEvent(int causeDamageAbilityID, int injuredEntityID, long value, DamageType type, int causeDamageEntityID, Vector3 position)
	{
		List<Graph> runningGraphs = Graph.GetRunningGraphs();
		if (runningGraphs != null)
		{
			for (int i = 0; i < runningGraphs.Count; i++)
			{
				runningGraphs[i].CreateHPTipsGraph(causeDamageAbilityID, injuredEntityID, value, type, causeDamageEntityID, position);
			}
		}
	}

	public void AddHitTipEventData(int defensor, int attacker, long damageValue, DamageType damageType, int abilityID)
	{
		for (int i = 0; i < _TipEventDataList.Count; i++)
		{
			HitTipEventData hitTipEventData = _TipEventDataList[i];
			if (hitTipEventData.AbilityID == abilityID && hitTipEventData.Position != Vector3.zero)
			{
				PostCreateHPTipsEvent(abilityID, defensor, damageValue, damageType, attacker, hitTipEventData.Position);
				_TipEventDataList.RemoveAt(i);
				FrameObjectPool<HitTipEventData>.Release(hitTipEventData);
				return;
			}
		}
		HitTipEventData hitTipEventData2 = FrameObjectPool<HitTipEventData>.Claim();
		hitTipEventData2.DefensorID = defensor;
		hitTipEventData2.AttackerID = attacker;
		hitTipEventData2.DamageAmount = damageValue;
		hitTipEventData2.DamageType = damageType;
		hitTipEventData2.AbilityID = abilityID;
		_TipEventDataList.Add(hitTipEventData2);
	}

	public void AddHitTipPosition(int abilityID, Vector3 pos)
	{
		for (int i = 0; i < _TipEventDataList.Count; i++)
		{
			HitTipEventData hitTipEventData = _TipEventDataList[i];
			if (hitTipEventData.AbilityID == abilityID && hitTipEventData.Position == Vector3.zero)
			{
				PostCreateHPTipsEvent(abilityID, hitTipEventData.DefensorID, hitTipEventData.DamageAmount, hitTipEventData.DamageType, hitTipEventData.AttackerID, pos);
				_TipEventDataList.RemoveAt(i);
				FrameObjectPool<HitTipEventData>.Release(hitTipEventData);
				return;
			}
		}
		HitTipEventData hitTipEventData2 = FrameObjectPool<HitTipEventData>.Claim();
		hitTipEventData2.AbilityID = abilityID;
		hitTipEventData2.Position = pos;
		_TipEventDataList.Add(hitTipEventData2);
	}
}
