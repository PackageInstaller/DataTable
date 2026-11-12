using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_Circle : SkillAdvancedBase
{
	protected FP rotateSpeed = 150;

	protected readonly ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[1];

	protected readonly string eventShoot = "shoot";

	protected readonly string fxPath = "fx_50020_loop_warning_water";

	protected FP fxYPos = 0;

	protected readonly float fxScale = 1f;

	protected readonly float fxSpeed = 1f;

	protected FP waitTime = 0.5;

	protected readonly string areaName_1 = "AreaEffect_WaterTrap";

	protected readonly string areaName_2 = "";

	protected ComboAttack _comboAttack;

	protected CoroutineNode _waitCloseFx;

	protected PlayFX _playFX;

	protected LookAtTarget _lookAtTarget;

	protected Vector3 _tempPos;

	protected TSVector2 _tempDir;

	protected bool isFisishFirstArea;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isFisishFirstArea = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	public void OnStart()
	{
		BeginLookAtRotate();
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		StopCoroutine(ref _waitCloseFx);
		_comboAttack?.Clear();
		_playFX?.Clear();
		_lookAtTarget?.StopLookAt();
		_lookAtTarget?.Clear();
	}

	public void BeginLookAtRotate()
	{
		if (_lookAtTarget == null)
		{
			_lookAtTarget = new LookAtTarget();
		}
		FP fP = FP.Zero;
		LogicEntity monsterTarget = _actor.monsterTarget;
		if (monsterTarget != null)
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			TSVector2 b = monsterTarget.tsTransform.Position - _actor.tsTransform.Position;
			fP = TSVector2.Angle(forward, b);
		}
		FP duration = fP / rotateSpeed;
		_lookAtTarget.BeginLookAt(_actor, monsterTarget, duration, rotateSpeed, () =>
		{
			PlayerCombo();
		});
	}

	protected void PlayerCombo()
	{
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKeys = actionKey;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onInterrupt = OnInterrupt;
		Action onComboFinish = OnFinish;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventShoot))
		{
			playFx();
		}
	}

	protected void playFx()
	{
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		LogicEntity logicEntity = _actor.monsterTarget;
		if (logicEntity == null)
		{
			logicEntity = CommonUtils_MonsterAPI.GetCurrentPlayer();
		}
		_tempPos = logicEntity.transform.position;
		_tempDir = _actor.tsTransform.Forward;
		_playFX.Play(_actor, _skill, fxPath, fxYPos, logicEntity.tsTransform.Position, _tempDir, null, fxSpeed, fxScale);
		StopCoroutine(ref _waitCloseFx);
		StartCoroutine(ref _waitCloseFx, WaitCloseFx());
	}

	protected IEnumerator WaitCloseFx()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitTime));
		if (_playFX != null)
		{
			_playFX.Stop(dontPlaySubFX: true);
			_playFX.Clear();
		}
		useAreaEffectOne();
	}

	protected void useAreaEffectOne()
	{
		if (!string.IsNullOrEmpty(areaName_1))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaName_1, new TSVector2(_tempPos.x, _tempPos.z), _tempDir.GetAngle());
		}
	}

	protected void useAreaEffectTwo()
	{
		if (!string.IsNullOrEmpty(areaName_2))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaName_2, new TSVector2(_tempPos.x, _tempPos.z), _tempDir.GetAngle());
		}
	}

	protected void OnAreaEffectFinish(IEvent evt)
	{
		if (!isFisishFirstArea)
		{
			AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
			if (!(adventureAreaEffectFinishEvent.owner != _actor) && adventureAreaEffectFinishEvent.entityID > 0)
			{
				useAreaEffectTwo();
				isFisishFirstArea = true;
			}
		}
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
