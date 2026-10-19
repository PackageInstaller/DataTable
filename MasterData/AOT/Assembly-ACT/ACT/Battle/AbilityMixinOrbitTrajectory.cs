using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Sound;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinOrbitTrajectory : BaseAbilityMixin
{
	private enum FlowState
	{
		None,
		Aiming,
		Warning,
		Attacking,
		AttackCD,
		TriggerExit
	}

	private readonly ConfigMixinOrbitTrajectory _config;

	private OrbitTrapAreaData _data;

	private List<Collider> m_Colliders = new List<Collider>();

	private Entity _triggerEntity;

	private uint _aimSoundEvent;

	private FlowState m_State;

	private float m_Timer;

	private GameObject m_AimEffect;

	private GameObject m_WarningEffect;

	private const string m_BoxName = "attackField";

	private FlowState State
	{
		get
		{
			return m_State;
		}
		set
		{
			switch (value)
			{
			case FlowState.Aiming:
				if (m_AimEffect != null)
				{
					m_AimEffect.SetActive(_triggerEntity != null);
				}
				if (m_WarningEffect != null)
				{
					m_WarningEffect.SetActive(value: false);
				}
				_aimSoundEvent = Singleton<GameManager>.instance.audioManager.PlaySound(_config.audioAimSoundEvt, new AudioPlayOptions
				{
					attachTarget = MonoECS.instance.mainEntity.GetRootTransform()
				});
				m_Timer = _data.AimTime;
				break;
			case FlowState.Warning:
				if (m_WarningEffect != null)
				{
					m_WarningEffect.transform.position = GetGroundPoint(MonoECS.instance.mainEntity.GetRootTransform().position);
					m_WarningEffect.SetActive(value: true);
				}
				if (m_AimEffect != null)
				{
					m_AimEffect.SetActive(value: false);
				}
				Singleton<GameManager>.instance.audioManager.PlaySound(_config.audioWarningSoundEvt, new AudioPlayOptions
				{
					attachTarget = m_WarningEffect.transform
				});
				m_Timer = _data.WarningTime;
				break;
			case FlowState.Attacking:
				if (m_AimEffect != null)
				{
					m_AimEffect.SetActive(value: false);
				}
				SpawnBullet();
				break;
			case FlowState.TriggerExit:
				if (m_State == FlowState.Aiming)
				{
					m_State = FlowState.None;
					m_Timer = 0f;
					Singleton<GameManager>.instance.audioManager.Stop(_aimSoundEvent);
				}
				if (m_AimEffect != null)
				{
					m_AimEffect.SetActive(value: false);
				}
				return;
			case FlowState.AttackCD:
				m_Timer = _data.AttackTime;
				break;
			default:
				m_Timer = 0f;
				if (m_AimEffect != null)
				{
					m_AimEffect.SetActive(value: false);
				}
				break;
			}
			m_State = value;
		}
	}

	public AbilityMixinOrbitTrajectory(ConfigMixinOrbitTrajectory config, Ability ab, byte index)
		: base(ab, index)
	{
		_config = config;
	}

	internal override void OnAdd()
	{
		_data = owner.GetCompStateObject()?.StateWorldAssetData as OrbitTrapAreaData;
		foreach (MonoTrigger monoTrigger in owner.GetMono().GetMixedPart("attackField").monoAttackPart.MonoTriggers)
		{
			monoTrigger.triggerEnter = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerEnter, new Action<Collider, ITrigger>(TriggerEnter));
			monoTrigger.triggerExit = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerExit, new Action<Collider, ITrigger>(TriggerExit));
			monoTrigger.triggerExitEvt = (Action)Delegate.Combine(monoTrigger.triggerExitEvt, new Action(TriggerExitEvt));
		}
		AssetStationManager.BattleStation.InstantiateAsync(_config.aimEffectAssetID, (AssetLoadHandle result) =>
		{
			GameObject gameObject = result.AsGameObject();
			AimEffectCompleted(gameObject);
			m_AimEffect = gameObject;
		});
		AssetStationManager.BattleStation.InstantiateAsync(_config.warningEffectAssetID, (AssetLoadHandle result) =>
		{
			GameObject gameObject = result.AsGameObject();
			WarningEffectCompleted(gameObject);
			m_WarningEffect = gameObject;
		});
	}

	private void AimEffectCompleted(GameObject obj)
	{
		obj.gameObject.SetActive(State == FlowState.Aiming);
	}

	private void WarningEffectCompleted(GameObject obj)
	{
		obj.gameObject.SetActive(State == FlowState.Warning);
	}

	private void ReleaseEffect()
	{
		if (m_AimEffect != null)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_AimEffect);
			m_AimEffect = null;
		}
		if (m_WarningEffect != null)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_WarningEffect);
			m_WarningEffect = null;
		}
	}

	internal override void OnRemove()
	{
		ReleaseEffect();
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}

	private void SpawnBullet()
	{
		Vector3 aimPos = ((m_WarningEffect != null) ? (m_WarningEffect.transform.position + Vector3.up * _config.bulletSpawnHeight) : owner.GetRootTransform().position);
		MonoECS.FlexibleParams p = new MonoECS.FlexibleParams
		{
			shape = Shape.Box,
			size = Vector3.zero,
			boxSize = new Vector3(1f, 1f, 3f),
			offest = Vector3.zero,
			type = AbilityEntityType.Normal,
			tag = (TrajectoryTag)0,
			checkEnvAndResolve = false,
			hp = 0,
			showUI = false,
			cantBeAttack = false,
			beHitFilter = _config.beHitFilter,
			aimPos = aimPos,
			aimRotation = Quaternion.Euler(90f, 0f, 0f),
			configTrajectoryObject = _config.configTrajectoryObject,
			trajectory = null,
			movementPattern = null,
			OverlapThreshold = 0.05f,
			VelocityOverlapDistance = 0.5f,
			onCreate = null,
			onDie = OnBulletDie
		};
		MonoECS.instance.SpawnFlexibleEntity(p, owner, null);
	}

	private void OnBulletDie(Entity bullet)
	{
		if (m_WarningEffect != null)
		{
			m_WarningEffect.SetActive(value: false);
		}
		if (_triggerEntity.IsValid)
		{
			State = FlowState.AttackCD;
		}
		else
		{
			State = FlowState.None;
		}
	}

	internal override void FixedUpdate()
	{
		FlowState state = State;
		if (state == FlowState.None || state == FlowState.Attacking)
		{
			return;
		}
		m_Timer -= owner.GetCompTime().fixedDeltaTime;
		if (m_Timer < 0f)
		{
			switch (State)
			{
			case FlowState.Aiming:
				State = FlowState.Warning;
				break;
			case FlowState.Warning:
				State = FlowState.Attacking;
				break;
			case FlowState.AttackCD:
				State = (_triggerEntity.IsValid ? FlowState.Aiming : FlowState.None);
				break;
			case FlowState.Attacking:
				break;
			}
		}
	}

	internal override void Update()
	{
		if (State == FlowState.Aiming && _triggerEntity.IsValid && !(m_AimEffect == null))
		{
			m_AimEffect.transform.position = GetGroundPoint(MonoECS.instance.mainEntity.GetRootTransform().position);
		}
	}

	private Vector3 GetGroundPoint(Vector3 position)
	{
		CompTransform compTransform = MonoECS.instance.mainEntity.GetCompTransform();
		if (!PhysicsUtility.CapsuleCast(position + compTransform.center, compTransform.size, Vector3.down, _config.rayDistance, out var hit))
		{
			return position;
		}
		return hit.point;
	}

	private void TriggerEnter(Collider collider, ITrigger trigger)
	{
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if ((object)component != null && component.entity.IsCharacter() && MonoECS.instance.localPlayer.IndexOfTeamCharacter(component.entity) == MonoECS.instance.battleEntityIndex)
		{
			if (m_Colliders.Count == 0)
			{
				_triggerEntity = component.entity;
				State = FlowState.Aiming;
			}
			if (_triggerEntity != component.entity)
			{
				_triggerEntity = component.entity;
				m_Colliders.Clear();
			}
			m_Colliders.Add(collider);
			OnEnterEvt(component.entity, trigger);
		}
	}

	private void TriggerExit(Collider collider, ITrigger trigger)
	{
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if ((object)component != null && component.entity.IsCharacter() && m_Colliders.Contains(collider))
		{
			m_Colliders.Remove(collider);
			OnExitEvt(component.entity, trigger);
			if (m_Colliders.Count == 0)
			{
				_triggerEntity = default;
				State = FlowState.TriggerExit;
			}
		}
	}

	private void OnEnterEvt(Entity entity, ITrigger trigger)
	{
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = true;
		evt.trigger = trigger;
		evt.entity = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void OnExitEvt(Entity entity, ITrigger trigger)
	{
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = false;
		evt.trigger = trigger;
		evt.entity = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void TriggerExitEvt()
	{
		m_Colliders.Clear();
		_triggerEntity = default;
		State = FlowState.TriggerExit;
	}
}
