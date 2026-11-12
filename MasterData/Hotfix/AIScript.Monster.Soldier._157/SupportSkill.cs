using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._157;

public class SupportSkill : SkillAdvancedBase
{
	private const string comboTag = "SupportSkill";

	private const string eventName_Fire = "Fire";

	private const string bulletKey = "Bullet_SupSkill_Soldier";

	private static readonly TSVector2 shootOffset = new TSVector2(0, -2);

	private static readonly FP shootPositionY = 0;

	private static readonly Dictionary<string, string> playFxInfoDic_Skill = new Dictionary<string, string>
	{
		["BaseHuiWu11"] = "fx_15701_base_Skill_Sup_Line_1",
		["BaseHuiWu21"] = "fx_15701_base_Skill_Sup_Line_2",
		["BaseHuiWu31"] = "fx_15701_base_Skill_Sup_Line_3",
		["BaseHuiWu41"] = "fx_15701_base_Skill_Sup_Line_4"
	};

	private const string eventName_SearchAndLookAtTarget_Skill = "157SkillSupReSuoDi";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		string value;
		if (string.Equals(eventName, "Fire"))
		{
			ShootBehind();
		}
		else if (playFxInfoDic_Skill.TryGetValue(eventName, out value))
		{
			new PlayFX().PlayLinFx(_actor, value, 1f, useCustSource: true, _actor.gameObject, default, default, _actor.gameObject, default, default);
		}
		else if (string.Equals(eventName, "157SkillSupReSuoDi"))
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
			if (_actor.attackTarget != null)
			{
				_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
			}
		}
	}

	private void ShootBehind()
	{
		TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.y;
		ILRuntimeAPI.ShootByDirection(shootDir: (!(_actor.attackTarget != null) || _actor.attackTarget.IsDead()) ? _actor.tsTransform.Forward : (_actor.attackTarget.tsTransform.Position - tSVector).normalized, bulletAlias: "Bullet_SupSkill_Soldier", actor: _actor, range: default, position: tSVector, positionY: shootPositionY);
	}
}
