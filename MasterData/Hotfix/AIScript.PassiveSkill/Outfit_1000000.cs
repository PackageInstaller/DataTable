using AdventureBehaviour;
using TrueSync;

namespace AIScript.PassiveSkill;

public class Outfit_1000000 : SkillAdvancedBase
{
	private readonly int _buffId1 = 230000232;

	private readonly int _buffId2 = 230000233;

	private readonly int _buffId3 = 230000234;

	private readonly int _buffId4 = 230000235;

	private readonly string _fxPath = "Actor/Character/Troubadour/FX/fx_troubadour_base_dodge_1";

	protected PlayFX _playFX;

	protected override void OnSkillEnable()
	{
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		_playFX.Play(_actor, _skill, _fxPath, 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		int num = TSRandom.Range(0, 100);
		int buffID = _buffId1;
		if (num <= 70 && num > 50)
		{
			buffID = _buffId2;
		}
		else if (num <= 50 && num > 30)
		{
			buffID = _buffId3;
		}
		else if (num <= 30)
		{
			buffID = _buffId4;
		}
		_actor?.buffComponent.AddBuff(buffID, _actor);
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		_playFX?.Stop();
		_playFX?.Clear();
	}
}
