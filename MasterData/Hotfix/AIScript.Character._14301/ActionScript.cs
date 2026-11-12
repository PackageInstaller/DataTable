using AdventureBehaviour;

namespace AIScript.Character._14301;

public class ActionScript : ActorActionBase
{
	private PlayFX _playFX1;

	private PlayFX _playFX2;

	private PlayFX _playFX3;

	private bool _playSkillMoveFx;

	private bool PlaySkillMoveFx
	{
		set
		{
			if (value != _playSkillMoveFx)
			{
				_playSkillMoveFx = value;
				if (_playFX1 == null)
				{
					_playFX1 = new PlayFX();
				}
				if (_playFX2 == null)
				{
					_playFX2 = new PlayFX();
				}
				if (_playFX3 == null)
				{
					_playFX3 = new PlayFX();
				}
				if (_playSkillMoveFx)
				{
					_playFX1.Play(_actor, null, "fx_14301_loop_foot_l", _actor.tsTransform.PositionY, _actor.tsTransform.Position, default, null, 1f, 1f, actorScale: true);
					_playFX2.Play(_actor, null, "fx_14301_loop_foot_r", _actor.tsTransform.PositionY, _actor.tsTransform.Position, default, null, 1f, 1f, actorScale: true);
					_playFX3.Play(_actor, null, "fx_14301_loop_foot_root", _actor.tsTransform.PositionY, _actor.tsTransform.Position, default, null, 1f, 1f, actorScale: true);
					return;
				}
				_playFX1.Stop();
				_playFX1.Clear();
				_playFX2.Stop();
				_playFX2.Clear();
				_playFX3.Stop();
				_playFX3.Clear();
			}
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		PlaySkillMoveFx = false;
	}

	public virtual void OnUpdate()
	{
		PlaySkillMoveFx = _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal | SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Ultimate);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		PlaySkillMoveFx = false;
	}
}
