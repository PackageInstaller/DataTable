using ACT.Battle.Configs;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinDodge : BaseAbilityMixin
{
	public ConfigMixinDodge config;

	public bool trigger;

	public float timer;

	private float activeElapsed;

	private NumberPropertyProvider m_PP;

	private Entity m_Dummy;

	private Vector3 bornPos;

	public AbilityMixinDodge(ConfigMixinDodge config, Ability ab, byte index)
		: base(ab, index)
	{
		this.config = config;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinDodge)configMixin;
	}

	internal override void ResetForPool()
	{
		ReleaseExternalState();
		config = null;
		trigger = false;
		timer = 0f;
		activeElapsed = 0f;
		m_PP = null;
		bornPos = default;
		base.ResetForPool();
	}

	private void EnsureDummyEntity()
	{
		if (!m_Dummy.IsValid && owner.IsValid)
		{
			m_Dummy = GameManager.entities.factory.CreateDummyEntity();
		}
	}

	internal override void TriggerAbility()
	{
		EnsureDummyEntity();
		if (!m_Dummy.IsValid)
		{
			return;
		}
		CompTransform compTransform = owner.GetCompTransform();
		bornPos = compTransform.physicsPosition;
		activeElapsed = 0f;
		if (config.configMixinDodgeType == ConfigMixinDodge.ConfigMixinDodgeType.dummyUseSeparateDuration)
		{
			timer = config.ghostRemainDuration;
		}
		else
		{
			timer = GameLoader.meta.roleDummyDuration;
		}
		timer *= 1f + owner.GetCompAbility().GetProperty(203u).value;
		if (!trigger)
		{
			trigger = true;
		}
		if (!m_Dummy.IsLogicAvailable())
		{
			MonoECS.instance.SpawnDummy(owner, m_Dummy);
			CompTransform compTransform2 = m_Dummy.GetCompTransform();
			GameObject root = m_Dummy.GetRoot();
			if ((bool)root)
			{
				Transform transform = root.transform;
				Vector3 pos = (transform.position = compTransform.physicsPosition);
				compTransform2.UpdatePosition(pos);
				compTransform2.size = compTransform.size;
				compTransform2.center = compTransform.center;
				CapsuleCollider capsuleCollider = (root.TryGetComponent<CapsuleCollider>(out var component) ? component : root.AddComponent<CapsuleCollider>());
				capsuleCollider.center = compTransform2.center;
				capsuleCollider.radius = Mathf.Max(GameLoader.meta.roleDummyRadius, compTransform2.size.x);
				capsuleCollider.height = Mathf.Max(GameLoader.meta.roleDummyHeight, compTransform2.size.y);
			}
		}
		else
		{
			CompTransform? compTransform3 = m_Dummy.GetCompTransform();
			Vector3 pos = (m_Dummy.GetRootTransform().position = bornPos);
			compTransform3.UpdatePosition(pos);
		}
		UpdateDummySweepRange();
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtDummyCreate evt = abilitySystem.GetEvt<EvtDummyCreate>(owner, ability);
		evt.mainEntity = ability.owner;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	internal override void FixedUpdate()
	{
		if (!trigger)
		{
			return;
		}
		float fixedDeltaTime = owner.GetCompTime().fixedDeltaTime;
		activeElapsed += fixedDeltaTime;
		timer -= fixedDeltaTime;
		UpdateDummySweepRange();
		if (timer < 0f)
		{
			trigger = false;
			if (m_Dummy.IsValid)
			{
				DodgeEndEvt evt = EventTrackSolver.Instance.GetEvt<DodgeEndEvt>();
				evt.isSuccess = false;
				EventTrackSolver.Instance.Dispatch(evt);
			}
			KillDummy();
		}
	}

	internal override void Update()
	{
	}

	private void KillDummy()
	{
		if (m_Dummy.IsValid)
		{
			Entity dummy = m_Dummy;
			m_Dummy = default;
			MonoECS.instance.TryRemoveBehave(dummy);
		}
	}

	private void UpdateDummySweepRange()
	{
		if (!m_Dummy.IsLogicAvailable() || !owner.IsValid)
		{
			return;
		}
		CompTransform compTransform = owner.GetCompTransform();
		GameObject root = m_Dummy.GetRoot();
		if ((bool)root)
		{
			Vector3 vector = compTransform.physicsPosition - bornPos;
			float dodgeRangeRadius = GetDodgeRangeRadius(compTransform);
			float num = Mathf.Max(GameLoader.meta.roleDummyHeight, compTransform.size.y);
			Transform transform = root.transform;
			transform.position = bornPos;
			CompTransform? compTransform2 = m_Dummy.GetCompTransform();
			compTransform2.UpdatePosition(transform.position);
			compTransform2.size = compTransform.size;
			compTransform2.center = compTransform.center;
			CapsuleCollider capsuleCollider = (root.TryGetComponent<CapsuleCollider>(out var component) ? component : root.AddComponent<CapsuleCollider>());
			capsuleCollider.center = compTransform.center;
			capsuleCollider.radius = dodgeRangeRadius;
			capsuleCollider.height = num;
			capsuleCollider.direction = 1;
			BoxCollider component3;
			if (config.createDummyBoxCollider)
			{
				BoxCollider boxCollider = (root.TryGetComponent<BoxCollider>(out var component2) ? component2 : root.AddComponent<BoxCollider>());
				boxCollider.enabled = true;
				boxCollider.center = compTransform.center + vector * 0.5f;
				boxCollider.size = new Vector3(Mathf.Abs(vector.x) + dodgeRangeRadius * 2f, Mathf.Abs(vector.y) + num, Mathf.Abs(vector.z) + dodgeRangeRadius * 2f);
			}
			else if (root.TryGetComponent<BoxCollider>(out component3))
			{
				component3.enabled = false;
			}
		}
	}

	private static float GetDodgeRangeRadius(CompTransform compTransform)
	{
		return Mathf.Max(GameLoader.meta.roleDummyRadius, compTransform.size.x);
	}

	private static Bounds GetSegmentBounds(Vector3 start, Vector3 end, float radius)
	{
		Vector3 vector = Vector3.Min(start, end);
		Vector3 vector2 = Vector3.Max(start, end);
		Bounds result = new Bounds((vector + vector2) * 0.5f, vector2 - vector);
		result.Expand(radius * 2f);
		return result;
	}

	private static float SqrDistancePointSegment(Vector3 point, Vector3 start, Vector3 end)
	{
		Vector3 vector = end - start;
		float sqrMagnitude = vector.sqrMagnitude;
		if (sqrMagnitude < 0.0001f)
		{
			return (point - start).sqrMagnitude;
		}
		float num = Mathf.Clamp01(Vector3.Dot(point - start, vector) / sqrMagnitude);
		Vector3 vector2 = start + vector * num;
		return (point - vector2).sqrMagnitude;
	}

	private bool IsAttackInDodgeRange(EvtAttack attack)
	{
		if (attack.target == m_Dummy || attack.target == owner)
		{
			return true;
		}
		if (attack.mainEntity == owner)
		{
			return false;
		}
		if (attack.mainEntity.GetCompAlliance()?.alliance == owner.GetCompAlliance()?.alliance)
		{
			return false;
		}
		CompTransform compTransform = owner.GetCompTransform();
		Vector3 start = bornPos + compTransform.center;
		Vector3 end = compTransform.physicsPosition + compTransform.center;
		float dodgeRangeRadius = GetDodgeRangeRadius(compTransform);
		float num = dodgeRangeRadius * dodgeRangeRadius;
		FindTargetResult targetResult = attack.targetResult;
		if (targetResult.Collider != null && targetResult.Collider.bounds.Intersects(GetSegmentBounds(start, end, dodgeRangeRadius)))
		{
			return true;
		}
		if (targetResult.IsValid && targetResult.targetSourceType != FindTargetResult.TargetSourceType.Script && SqrDistancePointSegment(targetResult.TouchPos, start, end) <= num)
		{
			return true;
		}
		if (attack.target.IsValid)
		{
			return SqrDistancePointSegment(attack.target.GetCompTransform().colliderPosition, start, end) <= num;
		}
		return false;
	}

	internal override void OnAdd()
	{
		EnsureDummyEntity();
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddListener(typeof(EvtAttack), this);
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddListener(typeof(EvtTriggerDummy), this);
	}

	internal override void OnRemove()
	{
		ReleaseExternalState();
	}

	private void ReleaseExternalState()
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance?.ecsManager?.systemAbility;
		systemAbility?.RemoveListener(typeof(EvtAttack), this);
		systemAbility?.RemoveListener(typeof(EvtTriggerDummy), this);
		KillDummy();
	}

	internal override void ListenEvt(BaseEvt evt)
	{
		Entity dummy = m_Dummy;
		if (!dummy.IsLogicAvailable())
		{
			return;
		}
		if (dummy.IsValid && evt is EvtAttack evtAttack)
		{
			if (evtAttack.mainEntity.HasCompNeutral() || (evtAttack.hitTag & HitTag.NoPerfectDodge) > HitTag.None)
			{
				return;
			}
			if (IsAttackInDodgeRange(evtAttack))
			{
				SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
				EvtPerfectDodge evt2 = systemAbility.GetEvt<EvtPerfectDodge>(owner, ability);
				evt2.mainEntity = owner;
				evt2.attacker = evtAttack.mainEntity;
				systemAbility.FireEvt(evt2);
				systemAbility.ReleaseEvt(evt2);
				SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, config.onDodgeActions);
				bool flag = ability.cooldownTimestamp == 0f || ability.time - ability.cooldownTimestamp > 10f;
				bool flag2 = (evtAttack.hitTag & HitTag.NoWitchDodge) > HitTag.None;
				bool flag3 = activeElapsed < GameLoader.meta.canDoWitchTime && !flag2;
				if (flag3)
				{
					SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, config.onDodgeActionByQuick);
				}
				else
				{
					SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, config.onDodgeActionByNoQuick);
				}
				trigger = false;
				KillDummy();
				DodgeEndEvt evt3 = EventTrackSolver.Instance.GetEvt<DodgeEndEvt>();
				evt3.isSuccess = true;
				EventTrackSolver.Instance.Dispatch(evt3);
				if (Model<CharacterTutorialModel>.Interface.InCharacterTutorial && evt2.ownerEntity.IsCharacter())
				{
					CharacterTutorialPerfectDodgeEvt evt4 = Singleton<EventManager>.instance.GetEvt<CharacterTutorialPerfectDodgeEvt>();
					evt4.characterId = evt2.ownerEntity.GetCompCharacter().characterSource.Id();
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterTutorial_PerfectDodge, evt4);
					Singleton<EventManager>.instance.ReleaseEvt(evt4);
				}
				Singleton<AchievementSyncBattleTypeManager>.instance.DispatchSyncFightType(3, 1);
				PerfectDodgeEvent evt5 = Singleton<EventManager>.instance.GetEvt<PerfectDodgeEvent>();
				evt5.entity = owner;
				evt5.isWitch = flag3 & flag;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnPerfectDodge, evt5);
				Singleton<EventManager>.instance.ReleaseEvt(evt5);
				if (evtAttack.mainEntity.IsMonster())
				{
					PrefectDodgeFromMonster evt6 = EventTrackSolver.Instance.GetEvt<PrefectDodgeFromMonster>();
					evt6.monsterId = evtAttack.mainEntity.GetCompMonster().id;
					evt6.monsterSwid = (evtAttack.mainEntity.GetCompStateObject()?.StateWorldAssetData)?.stateWorldAssetUid ?? (-1);
					if (evtAttack.ability != null)
					{
						evt6.skillId = evtAttack.ability.skillLevelInfo.id;
					}
					evt6.isWitch = flag3 & flag;
					EventTrackSolver.Instance.Dispatch(evt6);
				}
			}
		}
		if (dummy.IsValid && evt is EvtTriggerDummy evtTriggerDummy)
		{
			SystemAbility systemAbility2 = Singleton<GameManager>.instance.ecsManager.systemAbility;
			EvtPerfectDodge evt7 = systemAbility2.GetEvt<EvtPerfectDodge>(owner, ability);
			evt7.mainEntity = owner;
			evt7.attacker = evtTriggerDummy.mainEntity;
			systemAbility2.FireEvt(evt7);
			systemAbility2.ReleaseEvt(evt7);
			SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, config.onDodgeActions);
			if (activeElapsed < GameLoader.meta.canDoWitchTime && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.WitchTime))
			{
				SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, config.onDodgeActionByQuick);
			}
			else
			{
				SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, config.onDodgeActionByNoQuick);
			}
			trigger = false;
			KillDummy();
			DodgeEndEvt evt8 = EventTrackSolver.Instance.GetEvt<DodgeEndEvt>();
			evt8.isSuccess = true;
			EventTrackSolver.Instance.Dispatch(evt8);
		}
	}
}
