#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected FP _dodgeDuration = 0.32;

	protected FP _dodgeDistance = 0.01;

	protected readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private const string event_p13 = "P13FengBoom";

	private static readonly FP _realDodgeDistance = 4;

	private static readonly FP _crossDodgeAdditionDistance = 1.5f;

	private static readonly FP _crossDodgeKeepAwayNavmeshEdgeDistance = 0.1f;

	protected Dodge _dodge;

	private bool iCrossObstacle;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_12301 SkillScript_Dodge OnDisable");
		base.OnSkillDisable();
		_dodge?.Interrupte();
		_actor.DisableDodgeCrossObstacle();
		CommonUtils.ClearDodgeCrossObstacleMode(_actor);
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_12301 SkillScript_Dodge OnEnable");
		base.OnSkillEnable();
		iCrossObstacle = GetPerk(512312);
		if (iCrossObstacle)
		{
			_actor.EnableDodgeCrossObstacle();
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("_12301 SkillScript_Dodge OnStart");
		if (!(_skill != null))
		{
			return;
		}
		if (iCrossObstacle)
		{
			CommonUtils.CheckAndSetDodgeCrossObstacleMode(_actor, _realDodgeDistance, _crossDodgeAdditionDistance, _crossDodgeKeepAwayNavmeshEdgeDistance);
			TSVector2 origin = _actor.tsTransform.Position;
			TSVector2 direction = (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput() ? SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() : _actor.tsTransform.Forward);
			if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var _, _realDodgeDistance, 4096) && _actor.crossObstacleMode)
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(12312011, _actor);
			}
		}
		ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
		System.Action onActivationEnd = OnActivationEnd;
		System.Action onRecoveryBegin = OnRecoveryBegin;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		_dodge.Begin(_actor, tSVector, _dodgeDuration, _dodgeDistance, null, comboWithAttack: true);
		if (GetPerk(512311))
		{
			_actor.buffComponent.AddBuff(12311011, _actor);
		}
	}

	protected void OnActivationEnd()
	{
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.forbiddenRush)
		{
			NovaLogger.Debug("skillStage=-=-=");
			int specialSkillId = ((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId;
			if (specialSkillId != 0)
			{
				ILRuntimeAPI.CreateSkill(specialSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
				OnFinish();
			}
		}
	}

	protected void OnCustomEvent(string evt)
	{
		if (!string.Equals(evt, "P13FengBoom") || !GetPerk(512313))
		{
			return;
		}
		string fxAlias = "AreaEffect_123_FengBoom";
		if (GetPerk(512302))
		{
			fxAlias = "AreaEffect_123_FengBoom_P2";
		}
		long num = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position);
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.dataID != _actor.dataID)
			{
				playerAdventureActor.buffComponent.AddBuff(12313011, _actor);
			}
		}
		if (num > 0)
		{
			if (GetPerk(512301))
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(12301011, _actor);
			}
			if (GetPerk(512305))
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(12305011, _actor);
			}
		}
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnRecoveryBegin()
	{
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_12301SkillScript_Dodge onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_12301SkillScript_Dodge onInterrupt");
		OnFinish();
	}
}
