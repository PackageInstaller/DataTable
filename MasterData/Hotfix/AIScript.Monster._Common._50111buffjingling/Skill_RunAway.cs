using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._Common._50111buffjingling;

public class Skill_RunAway : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly string eventBlink = "Blink";

	protected readonly string fxPathBlink = "fx_50111buffjingling_base_skill1_02";

	protected readonly int buffId = 990011100;

	protected readonly string fxPathShow = "fx_50111buffjingling_base_skill1_03";

	protected FP waitTime = 0.2;

	protected FP fanAngle = 120;

	protected FP innerRange = 6;

	protected FP fanRange = 8;

	protected FP fanRotation = 180;

	protected ComboAttack _comboAttack;

	protected CoroutineNode _corWaitShow;

	protected PlayFX _playFXBlink;

	protected PlayFX _playFXShow;

	protected DeterministicShape _shape;

	public void OnStart()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_jingling", value: false);
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		_comboAttack.BeginAttack(_actor, _skill, actionKeys, flushInputedKeys: true, (_skill != null) ? _skill.skillId : 0, forceInterruptAttack: false, autoLookAtTarget: false, null, null, onCustomEvent: OnCustomEvent, onInterrupt: OnInterrupt, aimTargetPosition: default, onAnticipationEnd: null, onRecoveryBegin: null, onComboLoop: null, onComboFinish: () =>
		{
			OnFinish();
		});
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventBlink))
		{
			StopCoroutine(ref _corWaitShow);
			StartCoroutine(ref _corWaitShow, CorWaitShow());
		}
	}

	protected IEnumerator CorWaitShow()
	{
		_actor.buffComponent.AddBuff(buffId, _actor);
		Teleportation();
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitTime));
		_actor.buffComponent.RemoveBuffByBuffId(buffId);
	}

	protected void Teleportation()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		_shape.shapeType = DeterministicShape.ShapeType.Fan;
		_shape.angle = fanAngle;
		_shape.radius = fanRange;
		_shape.innerRadius = innerRange;
		_shape.position = _actor.tsTransform.Position;
		_shape.rotation = (activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position).GetAngle() + fanRotation;
		TSVector2 tSVector = _actor.RandomActorReachablePointInsideShape(_shape);
		if (tSVector != _shape.position)
		{
			_actor.Teleport(tSVector);
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

	protected override void OnSkillDisable()
	{
		_comboAttack?.Clear();
		_playFXBlink?.Clear();
		_playFXShow?.Clear();
		StopCoroutine(ref _corWaitShow);
		_actor.logicVariable.ToggleLogicTag("CheckSkill_jingling", value: true);
		_actor.buffComponent.RemoveBuffByBuffId(buffId);
	}
}
