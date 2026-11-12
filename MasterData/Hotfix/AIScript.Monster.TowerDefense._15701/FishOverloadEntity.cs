using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15701;

public class FishOverloadEntity : CustomHotFixEntityBase
{
	private enum State
	{
		None,
		Follow,
		Attack,
		ComeBack
	}

	private readonly FP followRotateSpeed_FishOverload = 180;

	private readonly FP followRadius_FishOverload = 4;

	private const string followFxKey_FishOverload_1 = "157SkillMainP2FishSwing";

	private const string followFxKey_FishOverload_2 = "157SkillMainP2FishSwing3";

	private readonly int count_Attack = 2;

	private const string attackFxKey_FishOverload = "157SkillMainP2FishAtk";

	private readonly FP attackDuration_FishOverload = 0.4;

	private const string attackAreaEffecyKey_FishOverload = "AreaEffect_157_P2_FishAtk";

	private readonly FP stayTimeAfterAttack_FishOverload = 0.2;

	private const string firstAttackAreaEffectKey_Delay_FishOverload = "AreaEffect_157_P2_FishAtk_Act1";

	private readonly FP delayTime_FirstDelayAreaEffect_FishOverload = 0.01;

	private const string secondAttackAreaEffectKey_Delay_FishOverload = "AreaEffect_157_P2_FishAtk_Act2";

	private readonly FP delayTime_SecondDelayAreaEffect_FishOverload = 0.45;

	private readonly FP attackInterval_FishOverload = 1;

	private readonly FP comeBackSpeed_FishOverload = 20;

	private State _state;

	private PlayFX _playFX_1;

	private PlayFX _playFX_2;

	private TSVector2 _followOffsetVector;

	private FP _attackInterval;

	private FP _attackSpeed;

	private bool _hasAttacked;

	private FP _attackDuration;

	private FP _attackStayDuration;

	private int _attackCount;

	protected override void OnEntityEnable()
	{
		base.OnEntityEnable();
		_attackCount = 0;
		EnterFollowState(firstEnter: true);
	}

	public void OnUpdate()
	{
		if (!_actor.actorHealthInfo.isAlive)
		{
			Finish();
			return;
		}
		if (!_actor.buffComponent.CheckBuffByBuffID(801570030) && _state != State.Attack)
		{
			Finish();
			return;
		}
		FP logicDeltaTime = _entity.LogicDeltaTime;
		switch (_state)
		{
		case State.Follow:
			_followOffsetVector = TSVector2.Rotate(_followOffsetVector, followRotateSpeed_FishOverload * logicDeltaTime);
			_entity.tsTransform.Forward = TSVector2.Rotate(_followOffsetVector, 90).normalized;
			_entity.tsTransform.Position = _actor.tsTransform.Position + _followOffsetVector;
			break;
		case State.Attack:
			if (!_hasAttacked)
			{
				_entity.tsTransform.Position += _entity.tsTransform.Forward * _attackSpeed * logicDeltaTime;
				_attackDuration += logicDeltaTime;
				if (_attackDuration > attackDuration_FishOverload)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_157_P2_FishAtk", _entity.tsTransform.Position, _entity.tsTransform.Rotation);
					_hasAttacked = true;
					_attackCount++;
				}
				break;
			}
			_attackStayDuration += logicDeltaTime;
			if (_attackStayDuration > stayTimeAfterAttack_FishOverload)
			{
				if (_attackCount >= count_Attack)
				{
					Finish();
					return;
				}
				if (!_actor.buffComponent.CheckBuffByBuffID(801570030))
				{
					Finish();
					return;
				}
				EnterComboBackState();
			}
			break;
		case State.ComeBack:
		{
			TSVector2 tSVector = _actor.tsTransform.Position + _followOffsetVector;
			_entity.tsTransform.Forward = (tSVector - _entity.tsTransform.Position).normalized;
			_entity.tsTransform.Position += _entity.tsTransform.Forward * comeBackSpeed_FishOverload * logicDeltaTime;
			if (TSVector2.Distance(tSVector, _entity.tsTransform.Position) < comeBackSpeed_FishOverload * logicDeltaTime)
			{
				EnterFollowState(firstEnter: false);
			}
			break;
		}
		}
		_entity.tsTransform.PositionY = _actor.tsTransform.PositionY;
		if (_state != State.Attack)
		{
			if (_attackInterval > 0)
			{
				_attackInterval -= logicDeltaTime;
			}
			else
			{
				EnterAttackState();
			}
		}
	}

	private void EnterFollowState(bool firstEnter)
	{
		if (_state != State.Follow)
		{
			_state = State.Follow;
			if (firstEnter)
			{
				_followOffsetVector = _actor.tsTransform.Forward * followRadius_FishOverload;
				_entity.tsTransform.Position = _actor.tsTransform.Position + _followOffsetVector;
				_entity.tsTransform.Forward = TSVector2.Rotate(_followOffsetVector, 90).normalized;
				_entity.tsTransform.PositionY = _actor.tsTransform.PositionY;
				PlayFx("157SkillMainP2FishSwing", ref _playFX_1);
				PlayFx("157SkillMainP2FishSwing3", ref _playFX_2);
				_attackInterval = attackInterval_FishOverload;
			}
			else
			{
				_followOffsetVector = (_entity.tsTransform.Position - _actor.tsTransform.Position).normalized * followRadius_FishOverload;
			}
		}
	}

	private bool EnterAttackState()
	{
		if (_state == State.Attack)
		{
			return false;
		}
		if (_actor.attackTarget != null)
		{
			_state = State.Attack;
			TSVector2 position = _actor.attackTarget.tsTransform.Position;
			_entity.tsTransform.Forward = (position - _entity.tsTransform.Position).normalized;
			PlayFx("157SkillMainP2FishAtk", ref _playFX_1);
			StopFx(ref _playFX_2);
			_actor.StartLogicCoroutine(GenerateAreaEffect("AreaEffect_157_P2_FishAtk_Act1", delayTime_FirstDelayAreaEffect_FishOverload), runImmediately: true);
			_actor.StartLogicCoroutine(GenerateAreaEffect("AreaEffect_157_P2_FishAtk_Act2", delayTime_SecondDelayAreaEffect_FishOverload), runImmediately: true);
			_attackSpeed = TSVector2.Distance(position, _entity.tsTransform.Position) / attackDuration_FishOverload;
			_hasAttacked = false;
			_attackDuration = 0;
			_attackStayDuration = 0;
			_attackInterval = attackInterval_FishOverload;
			return true;
		}
		return false;
	}

	private void EnterComboBackState()
	{
		if (_state != State.ComeBack)
		{
			_state = State.ComeBack;
			_followOffsetVector = TSVector2.Rotate(_followOffsetVector, TSRandom.Range(0, 360));
			TSVector2 tSVector = _actor.tsTransform.Position + _followOffsetVector;
			_entity.tsTransform.Forward = (tSVector - _entity.tsTransform.Position).normalized;
			PlayFx("157SkillMainP2FishSwing", ref _playFX_1);
			PlayFx("157SkillMainP2FishSwing3", ref _playFX_2);
		}
	}

	private void PlayFx(string fxKey, ref PlayFX playFX)
	{
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		playFX.Stop();
		playFX.Clear();
		playFX.Play(_actor, null, fxKey, default, _actor.tsTransform.Position, default);
		playFX.fxInstance.syncSlot = AnimationSlotConfigComponent.SlotType.Base;
		playFX.fxInstance.Bind(_entity.gameObject, _entity.gameObject);
	}

	private void StopFx(ref PlayFX playFX)
	{
		playFX?.Stop();
		playFX?.Clear();
	}

	private IEnumerator GenerateAreaEffect(string areaEffectKey, FP delay, System.Action onGenerateCallBack = null)
	{
		if (delay > 0)
		{
			yield return _actor.WaitTime(delay);
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, _entity.tsTransform.Position, _entity.tsTransform.Rotation);
		onGenerateCallBack?.Invoke();
	}

	protected override void OnEntityDisable()
	{
		base.OnEntityDisable();
		_state = State.None;
		StopFx(ref _playFX_1);
		StopFx(ref _playFX_2);
	}
}
