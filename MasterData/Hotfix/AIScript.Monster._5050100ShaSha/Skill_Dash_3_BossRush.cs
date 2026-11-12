using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_Dash_3_BossRush : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Water = new ComboInputBuffer.ActionKey[1];

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Shadowball = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

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
			fxAlias = "AreaEffect_DarkFallenStone";
		}
		else
		{
			_actionKey = actionKey_Water;
			fxAlias = "AreaEffect_WaterFallenStone_Dash";
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget(isUpToDate: true);
		BeginLookAt_NotWait(target, 0.4, 200);
		yield return WaitTime(0.2);
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.1);
		target = GetAttackTarget(isUpToDate: true);
		AimAtTarget(target, 100);
		yield return WaitTime(1f);
		CancelAim();
		yield return WaitTime(0.2f);
		CancelAttack();
		SetCloseBlockEnable();
		StartCoroutine(AreaEffect());
		yield return WaitTime(0.4);
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		FP randomValue = GetRandomValue(0, 3);
		if (_actor.buffComponent.CheckBuffByBuffID(505010110) && randomValue >= 2)
		{
			BeginLookAt_NotWait(target, 0.2, 300);
			yield return WaitTime(0.2);
			BeginAttack(2, actionKey_Shadowball, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		yield return WaitTime(0.2f);
	}

	private IEnumerator AreaEffect()
	{
		for (FP time = 0.8; time > 0; time -= (FP)0.4)
		{
			yield return WaitTime(0.2);
			doAreaEffect1();
			yield return WaitTime(0.2);
			doAreaEffect2();
		}
		yield return WaitTime(0.3);
		doAreaEffect1();
	}

	private void doAreaEffect1()
	{
		TSVector2 position = GetPosition() + TSVector2.Rotate(new TSVector2(3.5f, 0), GetEntityAngle(_actor));
		PlayAreaEffect(fxAlias, position);
	}

	private void doAreaEffect2()
	{
		TSVector2 position = GetPosition() + TSVector2.Rotate(new TSVector2(-3.5f, 0), GetEntityAngle(_actor));
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
		SetCloseBlockDisable();
	}
}
