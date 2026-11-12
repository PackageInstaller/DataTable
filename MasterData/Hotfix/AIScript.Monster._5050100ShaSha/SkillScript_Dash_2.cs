using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Dash_2 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Water = new ComboInputBuffer.ActionKey[1];

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	private string fxAlias = "AreaEffect_DarkFallenStone";

	protected Dash _dash;

	protected FP _currentSkillRotateSpeed;

	protected int _turnCount;

	protected bool _startTurn;

	protected PlayFX _playFX;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = actionKey_Dark;
		}
		else
		{
			_actionKey = actionKey_Water;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 200);
		yield return WaitTime(0.2);
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.1);
		AimAtTarget(target, 100);
		yield return WaitTime(2);
		CancelAim();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doAreaEffect1()
	{
		TSVector2 position = _actor.tsTransform.Position + TSVector2.Rotate(new TSVector2(3.5f, 0), _actor.tsTransform.Rotation);
		PlayAreaEffect(fxAlias, position);
	}

	private void doAreaEffect2()
	{
		TSVector2 position = _actor.tsTransform.Position + TSVector2.Rotate(new TSVector2(-3.5f, 0), _actor.tsTransform.Rotation);
		PlayAreaEffect(fxAlias, position);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_playFX != null)
		{
			_playFX.Stop(dontPlaySubFX: true);
			_playFX.Clear();
		}
	}
}
