using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10017XiChenQi;

public class Skill_Draw : SkillAdvancedBase
{
	protected const int buffId = 9900311;

	protected FP radius = 20;

	protected FP angle = 120;

	protected FP highDrawTime = 0.3;

	protected FP highDrawSpeed = 12;

	protected FP lowDrawTime = 3;

	protected FP lowDrawSpeed = 6;

	protected readonly int moveLevel = 99;

	protected FP strength = 9;

	protected FP attackDistance = 3;

	protected ComboAttack _comboAttack;

	protected CoroutineNode _drawCor;

	protected FP _drawInterval = 0.1f;

	protected List<DeterministicCollider> _result;

	protected List<LogicEntity> _player;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		StopCoroutine(ref _drawCor);
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1];
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, null, onComboFinish, onInterrupt);
	}

	protected void OnAnticipationEnd()
	{
		_actor.buffComponent?.AddBuff(9900311, _actor);
		StartCoroutine(ref _drawCor, BeginDraw());
	}

	protected IEnumerator BeginDraw()
	{
		FP totalTime = highDrawTime + lowDrawTime;
		FP lastTime = 0;
		bool attackPlayer = false;
		while (lastTime <= totalTime && !attackPlayer)
		{
			FP fP = ((lastTime <= highDrawTime) ? highDrawSpeed : lowDrawSpeed);
			if (_result == null)
			{
				_result = new List<DeterministicCollider>(10);
			}
			else
			{
				_result.Clear();
			}
			if (_player == null)
			{
				_player = new List<LogicEntity>(2);
			}
			else
			{
				_player.Clear();
			}
			if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckFanOverlap(angle, radius, _actor.tsTransform.Position, _actor.tsTransform.Rotation, _result, 256))
			{
				for (int i = 0; i < _result.Count; i++)
				{
					if (!_result.get_Item(i).TryGetComponent<LogicEntity>(out var component))
					{
						continue;
					}
					PlayerAdventureActor playerAdventureActor = component as PlayerAdventureActor;
					if (playerAdventureActor != null)
					{
						FP fP2 = TSVector2.Distance(_actor.tsTransform.Position, playerAdventureActor.tsTransform.Position);
						attackPlayer = fP2 <= attackDistance;
						if (attackPlayer)
						{
							break;
						}
						_player.Add(playerAdventureActor);
					}
				}
				if (attackPlayer)
				{
					continue;
				}
				if (_player != null && _player.Count > 0)
				{
					FP distance = fP * _drawInterval;
					ILRuntimeAPI.ForceMoveByDistance(_actor, _player, distance, fP, isCoExist: true, isChangeForward: true, moveLevel, strength, isPull: true);
				}
			}
			lastTime += _drawInterval;
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_drawInterval));
		}
		ComboInputBuffer.ActionKey[] actionKeys = ((!attackPlayer) ? new ComboInputBuffer.ActionKey[1] : new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B });
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
	}

	protected void OnFinish()
	{
		StopCoroutine(ref _drawCor);
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref _drawCor);
		_actor.buffComponent?.RemoveBuffByBuffId(9900311);
		_comboAttack?.Clear();
		_comboAttack = null;
	}
}
