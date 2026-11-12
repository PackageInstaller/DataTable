using System;
using AdventureBehaviour;

namespace AIScript.Character._11601;

public class SkillScript_Death_Summoned : SkillAdvancedBase
{
	private PlayFX _playFX;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PlayDeathAnim();
	}

	public void OnStart()
	{
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		else
		{
			_playFX.Clear();
		}
		_playFX.Play(_actor, null, "fx_11601_base_PeaShooter_Die", default, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("116_PeaShooter_Die", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_playFX?.Stop();
		_playFX?.Clear();
	}
}
