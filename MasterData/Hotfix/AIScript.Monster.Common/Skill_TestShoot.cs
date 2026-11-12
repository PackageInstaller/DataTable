using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster.Common;

public class Skill_TestShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.5);
		ILRuntimeAPI.ShootRotateWepon("Weapon_16510_HuanRao_BossRush", _actor, null, _actor.tsTransform.Forward);
		yield return WaitTime(10);
	}
}
