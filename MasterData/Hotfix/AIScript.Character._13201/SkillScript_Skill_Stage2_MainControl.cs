using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13201;

public class SkillScript_Skill_Stage2_MainControl : SkillScript_Skill_Base_MainControl
{
	private const string actionTag = "132_Main_Skill_S2";

	private static readonly FP speed_Dash = 15;

	private static readonly FP maxDistance_Dash = 8;

	private static readonly FP minDurationTime_Loop = 0.5;

	private static readonly FP maxDurationTime_Loop = 1.7;

	private const int buffId = 13293011;

	private const int perkId_2 = 513202;

	private const string actionTag_P2 = "132_Main_Skill_S2_P02";

	private const int perkId_4 = 513204;

	private static readonly FP useSkillInterval_P4 = 2;

	private static readonly int damageTag_P4 = CommonHelper.StringToHash("132_Main_S2_Burst_P04");

	private const string areaEffectKey_P4 = "AreaEffect_132_Main_S2_P04_AOE";

	private Dash _dash;

	private bool _canHolding;

	private FP _loopDurationTime;

	private bool _canTriggerAOE;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopDurationTime = 0;
		_canHolding = !HavePersonalPerk(513204);
		_canTriggerAOE = CanTriggerPerk_4();
		_actor.buffComponent.AddBuff(13293011, _actor);
	}

	private bool CanTriggerPerk_4()
	{
		bool flag = _actor.LogicTime - _actor.logicVariable.GetLogicTagValue("LastSkillFinishTime_MainControl") < useSkillInterval_P4;
		return HavePersonalPerk(513204) & flag;
	}

	protected override void OnComboBegin()
	{
		base.OnComboBegin();
		FP distance = maxDistance_Dash;
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
			distance = TSMath.Clamp(_actor.DistanceWithRadius(_actor.attackTarget), 0, maxDistance_Dash);
		}
		if (_dash == null)
		{
			_dash = new Dash();
		}
		else
		{
			_dash?.Clear();
		}
		_dash.BeginDash(_actor, _actor.tsTransform.Forward, speed_Dash, distance, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: true, triggerFriendStop: false);
	}

	protected override void OnAnticipationEnd()
	{
		base.OnAnticipationEnd();
		_dash?.Interrupte();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (_actor.attackComboPhase == Combo.Phase.Activation)
		{
			_loopDurationTime += _actor.LogicDeltaTime;
			if (_loopDurationTime > minDurationTime_Loop && (!_canHolding || !_actor.logicVariable.GetLogicTagToggle("HoldingKeyB") || _loopDurationTime > maxDurationTime_Loop))
			{
				comboAttack?.CancelAttack();
			}
		}
	}

	protected override string GetActionTag()
	{
		if (HavePersonalPerk(513202) && _actor.logicVariable.GetLogicTagToggle("CanTriggerPerk_2"))
		{
			return "132_Main_Skill_S2_P02";
		}
		return "132_Main_Skill_S2";
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor && _canTriggerAOE && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_P4))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_132_Main_S2_P04_AOE", monsterAdventureActor.tsTransform.Position);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.buffComponent.RemoveBuffByBuffId(13293011);
		_dash?.Interrupte();
		_dash?.Clear();
		_loopDurationTime = 0;
	}
}
