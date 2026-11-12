using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11501;

public class SkillScript_Dodge_MainControl : SkillScript_Dodge
{
	private Dodge _dodge;

	private SpecialDodge _specialDodge;

	private PlayFX _playFX;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public override void OnStart()
	{
		SetSkillPhaseConfig(SkillPhaseFeatureFlag.Normal | SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Skill2, null, SkillPhaseFeatureFlag.None, null);
		if ((_actor as PlayerAdventureActor).status == ActorStatus.Special)
		{
			TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (tSVector == TSVector2.zero)
			{
				tSVector = _actor.tsTransform.Forward.normalized;
			}
			if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal | SkillPhaseFeatureFlag.Skill1))
			{
				if (_specialDodge == null)
				{
					_specialDodge = new SpecialDodge();
				}
				_specialDodge.Begin(_actor, tSVector, Config_MainControl.dodge_Duration_Special_TransformState, Config_MainControl.dodge_Distance_Special_TransformState, null, OnDodgeFinish);
			}
			else
			{
				if (_dodge == null)
				{
					_dodge = new Dodge();
				}
				_dodge.Begin(_actor, tSVector, Config_MainControl.dodge_Duration_TransformState, Config_MainControl.dodge_Distance_TransformState, null, comboWithAttack: true, notChangeForward: false, OnDodgeFinish);
			}
			PlayDodgeFx();
		}
		else
		{
			base.OnStart();
		}
	}

	private void OnDodgeFinish()
	{
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.forbiddenRush)
		{
			int num = 11571000;
			if (num != 0)
			{
				ILRuntimeAPI.CreateSkill(num, _actor, SkillPhaseFeatureFlag.Skill2);
				OnFinish();
			}
		}
		else
		{
			OnFinish();
		}
	}

	private void PlayDodgeFx()
	{
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		else
		{
			_playFX.Clear();
		}
		_playFX.Play(_actor, null, "fx_11501_base_Dodge_B1B2_Tail", 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_playFX?.Stop();
		_specialDodge?.Clear();
	}
}
