#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._10701;

public class SkillScript_Zhukong_Skill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys_Loop = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1768322159,
		(ComboInputBuffer.ActionKey)1918131320,
		(ComboInputBuffer.ActionKey)1701275497
	};

	private readonly ComboInputBuffer.ActionKey[] actionKeys_Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	private const string atkTag_01 = "107_Main_P01_StrengthenAttack";

	private const string actionKeys_Loop_03 = "107_Main_P03_StrengthenLoop";

	private const int holdShield_AddInvincible = 10793012;

	private const int holdShield_AddWeightBuffId = 10793013;

	private const int holdShield_ReduceDamageBuffId = 10793011;

	private readonly FP skillTime = 8;

	private const int reduceCDPercent = 100;

	protected int _curReduceDamageBuffId;

	protected int _beginSecondStage;

	protected AimTarget _aimTarget;

	protected PlayerSkillCd _skillManager;

	protected FP _originRunAnimationSpd;

	protected bool _searchUseInputDirection;

	protected FP leftTime;

	private PlayFX fxP;

	private PlayFX playFX = new PlayFX();

	private long areaId_04;

	private bool beInviceHit;

	private bool hasPlayArea;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Parallel.mainSkill = true;
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		leftTime = skillTime;
		_skillManager = _actor.GetLogicComponent<PlayerSkillCd>();
		_curReduceDamageBuffId = 0;
		_beginSecondStage = 0;
		beInviceHit = false;
		_searchUseInputDirection = true;
		hasPlayArea = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnDeathHit);
	}

	public virtual void OnStart()
	{
		SearchTargetAndAim();
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", _skill.skillId, skillTime.AsFloat(), 1);
		if (GetPerk(510703))
		{
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack("107_Main_P03_StrengthenLoop", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			ComboInputBuffer.ActionKey[] keys = actionKeys_Loop;
			System.Action onInterrupt = OnFinish;
			System.Action onComboFinish = OnInterrupt;
			BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish);
		}
		_curReduceDamageBuffId = 10793011;
		_actor.buffComponent.AddBuff(10793012, _actor);
		_actor.buffComponent.AddBuff(10793013, _actor);
		_actor.buffComponent.AddBuff(_curReduceDamageBuffId, _actor);
		if (GetPerk(510704))
		{
			areaId_04 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_107_Main_Skill_P04_LightDefenseDown", _actor.tsTransform.Position, _actor.tsTransform.PositionY);
		}
		if (GetPerk(510707))
		{
			Parallel.current_cout_07 = 12;
		}
	}

	public void OnUpdate()
	{
		leftTime -= _actor.LogicDeltaTime;
		if (leftTime < 0)
		{
			CounterAttack();
			_beginSecondStage = 3;
			if (_actor.logicVariable.GetLogicTagToggle("HoldingKeyB"))
			{
				_skillManager.ModifyResumeTimePercent(100, ActionKey.B);
			}
		}
		else if (_beginSecondStage == 0)
		{
			SearchTargetAndAim();
			if (!_actor.logicVariable.GetLogicTagToggle("HoldingKeyB"))
			{
				CounterAttack(beInviceHit);
			}
		}
	}

	protected void SearchTargetAndAim()
	{
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(_searchUseInputDirection);
		if (_actor.attackTarget != null)
		{
			_actor.currentAttackTarget = _actor.attackTarget;
			_aimTarget.Aim(_actor, (AdventureActor)_actor.aimLockedTarget);
			_searchUseInputDirection = false;
			return;
		}
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward;
		}
		_aimTarget.Aim(_actor, null, tSVector);
		_actor.tsTransform.Forward = tSVector;
		_searchUseInputDirection = true;
	}

	protected virtual void CounterAttack(bool iPlus = false)
	{
		_beginSecondStage = 1;
		_aimTarget?.Cancel();
		_actor.buffComponent.RemoveBuffByBuffId(10793013);
		_actor.buffComponent.RemoveBuffByBuffId(_curReduceDamageBuffId);
		bool flag = false;
		bool flag2 = GetPerk(510701) & iPlus;
		if (GetPerk(510703))
		{
			flag = true;
			if (!flag2)
			{
				comboAttack.CancelAttack();
			}
		}
		if (GetPerk(510704))
		{
			ILRuntimeAPI.StopAreaEffect(areaId_04);
		}
		playFX?.Stop();
		leftTime += (FP)10;
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _skill.skillId);
		if (flag2)
		{
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack("107_Main_P01_StrengthenAttack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			ComboInputBuffer.ActionKey[] keys = actionKeys_Attack;
			bool flushInputedKeys = flag;
			System.Action onInterrupt = OnFinish;
			System.Action onComboFinish = OnInterrupt;
			BeginAttack(keys, flushInputedKeys, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish);
		}
	}

	protected virtual void AfterCounterAttack()
	{
	}

	protected override void OnReceiveAttack(IEvent evt)
	{
		if ((evt as AdventureActorReceiveAttackEvent).to != _actor || !_actor.buffComponent.CheckBuffByBuffID(10793012))
		{
			return;
		}
		beInviceHit = true;
		if (GetPerk(510701))
		{
			playFX?.Stop();
			playFX.Play(_actor, "fx_10701_loop_main_skill_p01_shield_strengthen", 1f, _actor.transform.position, _actor.transform.rotation);
		}
		if (GetPerk(510705))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (!playerAdventureActor.isDead)
				{
					playerAdventureActor.buffComponent.AddBuff(10705011, _actor);
				}
			}
		}
		if (GetPerk(510706) && !hasPlayArea)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_107_Main_Skill_P06_Boom", _actor.tsTransform.Position, _actor.tsTransform.PositionY);
			hasPlayArea = true;
		}
	}

	protected void OnDeathHit(IEvent evt)
	{
		AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = evt as AdventureActorReceiveDamageCanCauseDeadEvent;
		if (adventureActorReceiveDamageCanCauseDeadEvent.to != null && adventureActorReceiveDamageCanCauseDeadEvent.to.Id == _actor.Id && GetPerk(510710) && !Parallel.iAdd_p10)
		{
			Parallel.iAdd_p10 = true;
			if (fxP == null)
			{
				fxP = new PlayFX();
			}
			Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
			fxP.Play(_actor, "fx_10701_base_Main_Skill_P10_Revive", 1f, _actor.transform.position, spawnRotation);
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("107 zhukong finish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Parallel.mainSkill = false;
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _skill.skillId);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnDeathHit);
		if (beInviceHit && GetPerk(510702))
		{
			SceneSingleton<AdventurePlayerController>.Instance?.AddTiliaShield(10702011, Parallel.tiliaShieldDuration, Parallel.tiliaShieldRotateSpeed);
		}
		if (_beginSecondStage == 3 && GetPerk(510709))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(10709011, _actor);
		}
		_aimTarget?.Cancel();
		_actor.buffComponent.RemoveBuffByBuffId(10793013);
		_actor.buffComponent.RemoveBuffByBuffId(_curReduceDamageBuffId);
		if (GetPerk(510704))
		{
			ILRuntimeAPI.StopAreaEffect(areaId_04);
		}
		_searchUseInputDirection = true;
		_curReduceDamageBuffId = 0;
		_beginSecondStage = 0;
		playFX?.Stop();
		playFX?.Clear();
		fxP?.Stop();
		fxP?.Clear();
	}
}
