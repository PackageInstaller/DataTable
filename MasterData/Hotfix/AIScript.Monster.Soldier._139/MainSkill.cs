using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._139;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag_Start = "MainSkill_Start";

	private readonly string comboTag_Atk = "MainSkill_Atk";

	private readonly string comboTag_End = "MainSkill_End";

	private readonly string eventName_Hide = "139_Hide";

	private readonly string eventName_Move = "139_Move";

	private readonly string eventName_Show = "139_Show";

	private readonly string eventName_EnableInvincible = "139_EnableInvincible";

	private readonly string eventName_DisableInvincible = "139_DisableInvincible";

	private static readonly int damageTag_GetSoul = CommonHelper.StringToHash("139_Soul");

	public const int buffId_Soul = 250105102;

	private static readonly FP distance_Move_NoTarget = 8;

	private static readonly FP duration_Move = 0.08;

	public const string comboTag_Final1 = "Ultra_First";

	public const string comboTag_Final2_P1 = "Ultra_Second_P1";

	public const string comboTag_Final2_P2 = "Ultra_Second_P2";

	public const string eventName_Ultra1_Area = "Event_139_Ultra1_Area";

	public const string areaEffectKey = "AreaEffect_Soldier_139_Ultra_PreExplosion";

	public const string eventName_UltraMove = "139_Ultra_Move";

	public const int soulCount_TriggerUltra = 3;

	public static readonly FP duration_UltraMove = 0.08;

	public static readonly string[] removeSoulFxList = new string[3] { "fx_13901_loop_Skill_Main_buff_1_trail", "fx_13901_loop_Skill_Main_buff_2_trail", "fx_13901_loop_Skill_Main_buff_3_trail" };

	public const int buffId_UltraState = 250105101;

	private bool _isHide;

	private bool _isInvincible;

	private TSVector2 _startTeleportPosition;

	private bool _hasGetSoul;

	private Dash _dash;

	private bool _inUltra;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_startTeleportPosition = _actor.tsTransform.Position;
		_hasGetSoul = false;
		_inUltra = false;
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		if (UltraSkillHelper.ShouldTrigger(_actor))
		{
			UltraSkillHelper.TriggerPerformance(_actor);
			BeginUltra();
			return;
		}
		string actionTag = comboTag_Start;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnStartActivation;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Move))
		{
			if (_actor.isJump)
			{
				_actor.StandBy();
			}
			TSVector2 linecastHitPoint = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * distance_Move_NoTarget));
			if (!_actor.QueryPositionReachable(linecastHitPoint))
			{
				_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
			}
			FP speed = TSVector2.Distance(_actor.tsTransform.Position, linecastHitPoint) / duration_Move;
			_actor.ToJump(linecastHitPoint, speed, duration_Move, null, comboWithAttack: true, forbiddenHeight: true);
		}
		else if (string.Equals(eventName, eventName_Hide))
		{
			HideModel();
		}
		else if (string.Equals(eventName, eventName_Show))
		{
			ShowModel();
		}
		else if (string.Equals(eventName, eventName_EnableInvincible))
		{
			EnableInvincible();
		}
		else if (string.Equals(eventName, eventName_DisableInvincible))
		{
			DisableInvincible();
		}
	}

	private void OnStartActivation()
	{
		if (_actor.isJump)
		{
			_actor.StandBy();
		}
		string actionTag = comboTag_Atk;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnAttackActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnAttackActivationEnd()
	{
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = (_startTeleportPosition - position).normalized;
		}
		_actor.LookAtDir(tSVector, 0);
		string actionTag = comboTag_End;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void HideModel()
	{
		if (!_isHide)
		{
			_isHide = true;
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
		}
	}

	private void ShowModel()
	{
		if (_isHide)
		{
			_isHide = false;
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
	}

	private void EnableInvincible()
	{
		if (!_isInvincible)
		{
			_isInvincible = true;
			_actor.EnableInvincible();
		}
	}

	private void DisableInvincible()
	{
		if (_isInvincible)
		{
			_isInvincible = false;
			_actor.DisableInvincible();
		}
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		if (!_hasGetSoul && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_GetSoul))
		{
			_hasGetSoul = true;
			_actor.buffComponent?.AddBuff(250105102, _actor);
		}
	}

	private void BeginUltra()
	{
		_inUltra = true;
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		Action<string> onCustomEvent = OnUltraCustomEvent;
		Action onActivationEnd = OnUltraActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_First", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnUltraCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Event_139_Ultra1_Area"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_139_Ultra_PreExplosion", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		}
		if (string.Equals(eventName, "139_Ultra_Move"))
		{
			UltraDashToTarget();
		}
	}

	private void UltraDashToTarget()
	{
		if (_actor.attackTarget == null)
		{
			return;
		}
		TSVector2 linecastHitPoint = _actor.attackTarget.tsTransform.Position;
		if (!_actor.QueryPositionReachable(linecastHitPoint))
		{
			_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
		}
		FP fP = TSVector2.Distance(linecastHitPoint, _actor.tsTransform.Position);
		if (!(fP <= 0))
		{
			TSVector2 normalized = (linecastHitPoint - _actor.tsTransform.Position).normalized;
			FP speed = fP / duration_UltraMove;
			if (_dash == null)
			{
				_dash = new Dash();
			}
			_dash.BeginDash(_actor, normalized, speed, fP, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private void OnUltraActivationEnd()
	{
		_dash?.Interrupte();
		Action<string> onCustomEvent = OnUltraCustomEvent;
		Action onActivationEnd = OnUltraSecondP1ActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_Second_P1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnUltraSecondP1ActivationEnd()
	{
		_dash?.Interrupte();
		Action onComboFinish = OnUltraFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_Second_P2", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnUltraFinish()
	{
		if (((SoldierActor)_actor).GetPotentialLv() >= 3)
		{
			_actor.buffComponent?.AddBuff(250105101, _actor);
		}
		OnFinish();
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_actor.isJump)
		{
			_actor.StandBy();
		}
		_hasGetSoul = false;
		if (_inUltra)
		{
			_dash?.Interrupte();
			_dash?.Clear();
			_actor.DisableInvincible();
			_actor.DisableSuperArmor();
			_actor.DisableImmuneControl();
			_inUltra = false;
		}
		ShowModel();
		DisableInvincible();
	}
}
