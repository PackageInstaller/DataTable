using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._70021MaoYan;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private readonly string fx_Path = "FX/ActorCommon/fx_switch_monster_actor";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		while (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 15)
		{
			yield return WaitTime(0.1);
		}
		ShowCenterHpBar();
	}
}
