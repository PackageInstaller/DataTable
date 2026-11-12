using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13901;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private const string comboTag_Skill = "139_Skill_Sup";

	private const int loopTimes_Skill = 1;

	private const int loopTimes_Skill_P4 = 3;

	private const string eventName_GenerateAreaEffect_Skill = "139_Sup_Area";

	private const string areaEffectKey_Skill = "AreaEffect_13901_Sup";

	private static readonly TSVector2 offset_AreaEffect_Skill = new TSVector2(0, 3);

	private const int perkId_2 = 1390102;

	private static readonly Dictionary<string, (string bulletKey, FP offsetAngle)> shootInfoDic_P2 = new Dictionary<string, (string, FP)>
	{
		["Event_139_Sup"] = ("Bullet_13901_Sup_P21", 0),
		["Event_139_Sup_l30"] = ("Bullet_13901_Sup_P21_l30", 0),
		["Event_139_Sup_l90"] = ("Bullet_13901_Sup_P21_l90", 0),
		["Event_139_Sup_r30"] = ("Bullet_13901_Sup_P21_r30", 0)
	};

	private static readonly FP shootRadius_P2 = 3;

	private static readonly FP shootPositionY_P2 = 1.5;

	private int _totalLoopTimes;

	private int _loopTims;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopTims = 0;
		_totalLoopTimes = 1;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		if (!_actor.buffComponent.CheckBuffByBuffID(801390040))
		{
			_actor.buffComponent.AddBuff(801390050, _actor);
		}
		DoMainLogic();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void DoMainLogic()
	{
		string text = "139_Skill_Sup";
		if (GetPerk(1390104))
		{
			text = "139_Skill_Sup_P22";
			_totalLoopTimes = 3;
		}
		string actionTag = text;
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnAnticipationEnd()
	{
		_loopTims = 0;
	}

	private void OnComboLoop()
	{
		_loopTims++;
		if (_loopTims >= _totalLoopTimes)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnCustomEvent(string evt)
	{
		if (string.Equals(evt, "139_Sup_Area"))
		{
			string fxAlias = "AreaEffect_13901_Sup";
			TSVector2 tSVector = offset_AreaEffect_Skill;
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, _actor.tsTransform.Rotation);
		}
		if (GetPerk(1390102) && shootInfoDic_P2.TryGetValue(evt, out (string, FP) value))
		{
			TSVector2 normalized = TSVector2.Rotate(_actor.tsTransform.Forward, value.Item2).normalized;
			TSVector2 position2 = _actor.tsTransform.Position + normalized * shootRadius_P2;
			ILRuntimeAPI.ShootByDirection(value.Item1, _actor, default, normalized, position2, shootPositionY_P2);
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}
}
