using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_CrargeBreath_3 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.T };

	protected readonly string playEffect = "PlayEffect";

	protected readonly string stopEffect = "StopEffect";

	protected readonly string fx_water_1 = "fx_50501_loop_skill5_loop_01";

	protected readonly string fx_water_2 = "fx_50501_loop_skill5_loop_02";

	protected readonly string fx_dark_1 = "fx_50501_loop_skill5_loop_01_an";

	protected readonly string fx_dark_2 = "fx_50501_loop_skill5_loop_02_an";

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected int _receiveDamage;

	protected string _fx_1_path;

	protected string _fx_2_path;

	protected PlayFX _playFX_1;

	protected PlayFX _playFX_2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = _actionKey_Dark;
			_fx_1_path = fx_dark_1;
			_fx_2_path = fx_dark_2;
		}
		else
		{
			_actionKey = _actionKey_Water;
			_fx_1_path = fx_water_1;
			_fx_2_path = fx_water_2;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.3);
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(playEffect);
		if (_playFX_1 == null)
		{
			_playFX_1 = new PlayFX();
		}
		_playFX_1.Play(_actor, _skill, _fx_1_path, 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		if (_playFX_2 == null)
		{
			_playFX_2 = new PlayFX();
		}
		_playFX_2.Play(_actor, _skill, _fx_2_path, 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		yield return WaitCustomEvent(stopEffect);
		if (_playFX_1 != null)
		{
			_playFX_1.Stop(dontPlaySubFX: true);
			_playFX_1.Clear();
		}
		if (_playFX_2 != null)
		{
			_playFX_2.Stop(dontPlaySubFX: true);
			_playFX_2.Clear();
		}
		yield return WaitTime(0.1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
		base.OnSkillDisable();
		_playFX_1?.Clear();
		_playFX_2?.Clear();
	}
}
