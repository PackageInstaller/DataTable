using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12001;

public class SkillScript_Dodge_Ultra : SkillAdvancedBase
{
	protected readonly FP _dodgeDuration = 0.3;

	protected readonly FP _dodgeDistance = 3;

	private readonly string self_fx = "fx_12001_base_Ultra_H6_dodge";

	private Dodge _dodge;

	private PlayFX playFx;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_dodge?.Interrupte();
		playFx?.Stop();
		playFx?.Clear();
	}

	public void OnStart()
	{
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		if (playFx == null)
		{
			playFx = new PlayFX();
		}
		playFx.Play(_actor, self_fx, 1f, _actor.tsTransform.PositionY, _actor.tsTransform.Position, _actor.transform.rotation);
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		_dodge.Begin(_actor, tSVector, _dodgeDuration, _dodgeDistance, onFinishOrInterrupt, comboWithAttack: true, notChangeForward: true, onFinishOrInterrupt);
	}

	protected void onFinishOrInterrupt()
	{
		_skill?.Clear();
	}
}
