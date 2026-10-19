using System;
using ACT.Battle;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.Chronos;
using Bamboo.ECS;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject.EntryProcessors;

public class AttackEntryProcessor : BaseEntryProcessor<IAttackEntrySetting>
{
	protected override void OnInit(IAttackEntrySetting entry)
	{
		StateWorldAssetData data = entry.Data;
		CoSpawnAttackInteractObject(entry, MonoECS.instance, data, entry.Alliance, entry.Size, entry.onSpawnAttackable).Forget();
	}

	protected async UniTaskVoid CoSpawnAttackInteractObject(IAttackEntrySetting entry, MonoECS ecs, StateWorldAssetData data, Alliance alliance, Vector3 size, Action<Entity> onSpawn)
	{
		StateObjectBase stateObjectBase = entry.EntityReference.GetCompStateObject().StateObjectBase;
		Entity onlyEntity = (entry.AttackableER = GameManager.entities.factory.CreateAttackEntity());
		Entity attackableEr = (stateObjectBase.onlyEntity = onlyEntity);
		if (entry.IsAttachCollider)
		{
			ecs.SpawnAttackInteractObject(attackableEr, entry.AttackableId, data.trapType, data.defenceTowerType, alliance, entry.AttachCollider);
		}
		else
		{
			ecs.SpawnAttackInteractObject(attackableEr, entry.AttackableId, data.trapType, data.defenceTowerType, data.initPos + entry.PosOffset, alliance, size, data.initRotate);
		}
		entry.EntityReference.GetCompStateObject().StateObjectBase.isAttackInit = true;
		attackableEr.GetCompStateObject().StateWorldAssetData = data;
		CompAbility compAbility = attackableEr.GetCompAbility();
		compAbility.onDie += (Action<Entity>)((Entity behave) =>
		{
			if (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.NeedDestructibleEvent)
			{
				Model<ChallengeTargetTrackerModel>.Interface.RecordDestructibleDestroyed(entry.EntityReference.GetCompStateObject().StateObjectBase.swid);
			}
			Interact(entry, behave, InteractAction.InteractSource.Player);
		});
		compAbility.onRelase += (Action<Entity>)((Entity x) =>
		{
			entry.SyncAttackablePositionDisposable?.Dispose();
		});
		if (entry.Abilities != null)
		{
			compAbility.AddAbilities(entry.Abilities, AbilitySource.Ability);
		}
		compAbility.onHPChange += (Action<int, int>)((int lastHp, int hp) =>
		{
			OnHpChange(entry, lastHp, hp);
		});
		compAbility.damageableHited = (Action<Entity>)Delegate.Combine(compAbility.damageableHited, (Action<Entity>)((Entity attacker) =>
		{
			OnHitted(entry, attacker);
		}));
		compAbility.comboDamageable = (Action<Entity, Entity>)Delegate.Combine(compAbility.comboDamageable, (Action<Entity, Entity>)((Entity attacker, Entity attackable) =>
		{
			OnCombo(entry, attacker, attackable);
		}));
		onSpawn?.Invoke(attackableEr);
		if (!entry.SyncAttackablePosition)
		{
			return;
		}
		entry.SyncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (attackableEr.IsValid)
			{
				attackableEr.GetRootTransform().position = entry.EntityReference.GetCompStateObject().StateObjectBase.transform.position;
			}
		});
	}

	private void OnCombo(IAttackEntrySetting entry, Entity attacker, Entity attackable)
	{
		OnHitted(entry, attacker);
		entry.ComboCount++;
		BigWordComboChallenge evt = Singleton<EventManager>.instance.GetEvt<BigWordComboChallenge>();
		evt.ComboCount = entry.ComboCount.FastToString();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ComboChallengeCount, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		if (entry.ComboCount < entry.ComboCountNeed)
		{
			entry.onComboChallengeInteract?.Invoke(entry.ComboCount);
		}
		if (entry.Timer.IsValid())
		{
			return;
		}
		entry.Timer = FixedUpdateTimer.Default.TweenMs(entry.TimeNeed * 1000, (int t) =>
		{
			if (entry.ComboCount >= entry.ComboCountNeed)
			{
				entry.AttackableER.KillEntity();
				entry.Timer.Cancel();
			}
		}, (bool _) =>
		{
			entry.ComboCount = 0;
		});
	}

	private void OnHitted(IAttackEntrySetting entry, Entity attacker)
	{
		entry.onHitInteract?.Invoke(attacker);
		_ = entry.EntityReference;
		CompStateObject compStateObject = entry.EntityReference.GetCompStateObject();
		TrackOnInteractEntryEvt evt = EventTrackSolver.Instance.GetEvt<TrackOnInteractEntryEvt>();
		evt.interactId = compStateObject.StateObjectBase.swid;
		evt.objectName = compStateObject.StateObjectBase.name;
		evt.stateCurrent = compStateObject.StateObjectBase.currentStateId;
		entry.OnHitedActionList.TryInteract(attacker, (attacker.GetEntityType() != EntityType.Character) ? InteractAction.InteractSource.Others : InteractAction.InteractSource.Player).Forget();
		evt.interactType = entry.Data.stateObjectType;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void OnHpChange(IAttackEntrySetting entry, int lastHP, int HP)
	{
		entry.onHPChangeInteract?.Invoke(lastHP, HP);
		if (entry.ChallengeInteractType == ChallangeType.ProtectionChallange)
		{
			BigWorldProtectionHpChange evt = Singleton<EventManager>.instance.GetEvt<BigWorldProtectionHpChange>();
			evt.hp = HP;
			evt.maxhp = entry.AttackableER.GetCompAbility().maxHP;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeProtectionHpChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	protected override void OnDeinit(IAttackEntrySetting entry)
	{
		if (entry.SyncAttackablePosition)
		{
			entry.SyncAttackablePositionDisposable?.Dispose();
		}
		Entity attackableER = entry.AttackableER;
		if (attackableER.IsAlive())
		{
			MonoECS.instance.TryRemoveBehave(attackableER);
		}
	}
}
