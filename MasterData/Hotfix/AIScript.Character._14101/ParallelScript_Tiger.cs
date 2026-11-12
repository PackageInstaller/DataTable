using AdventureBehaviour;

namespace AIScript.Character._14101;

public class ParallelScript_Tiger : ParallelScript_Summoned
{
	private PlayFX _playFX_1;

	private PlayFX _playFX_2;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_playFX_1 == null)
		{
			_playFX_1 = new PlayFX();
		}
		else
		{
			_playFX_1.Clear();
		}
		_playFX_1.Play(_actor, null, "fx_14101_Pet_2_loop_Support_Skill_Summon_2_LHand", default, _actor.tsTransform.Position, default);
		if (_playFX_2 == null)
		{
			_playFX_2 = new PlayFX();
		}
		else
		{
			_playFX_2.Clear();
		}
		_playFX_2.Play(_actor, null, "fx_14101_Pet_2_loop_Support_Skill_Summon_2_RHand", default, _actor.tsTransform.Position, default);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_playFX_1?.Stop();
		_playFX_1?.Clear();
		_playFX_2?.Stop();
		_playFX_2?.Clear();
	}
}
