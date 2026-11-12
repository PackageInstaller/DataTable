using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Activity.Duona;

public class Skill_Spawn : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_switch_monster_actor";

	private FP intervaltime = 0.1f;

	private int checkid = 308030201;

	private int dropitemid = 107;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
		yield return WaitTime(0.1f);
		yield return WaitTime(1);
	}
}
