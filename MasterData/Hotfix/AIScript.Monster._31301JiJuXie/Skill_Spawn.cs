using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] combo_Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private static FP Spawn_AnimEarlyExit = 1.8;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		AddBuffToTarget(_actor, 313010040);
		AddBuffToTarget(_actor, 313010050);
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
