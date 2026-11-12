using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11001;

public class SkillScript_Death : SkillSimpleBase
{
	private int keyIndex1 = 1;

	private string key_dead = "Dead";

	private string evt_boom = "Boom";

	private int perkId_4 = 1100104;

	private string areaEffect_4 = "FenShen_DieBoom";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		SkillScript_Death skillScript_Death = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skillScript_Death.PlayEffect("fx_11001_base_FenShen_Die", 1f, default, position, rotation);
		if (GetPerk(perkId_4))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_4, _actor.tsTransform.Position);
		}
		yield return null;
	}
}
