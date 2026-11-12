using System.Collections;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Spawn_TraceHunt : SkillSimpleBase
{
	private string ShowLong = "ShowLong";

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitTime(2);
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitTime(0.5);
	}
}
