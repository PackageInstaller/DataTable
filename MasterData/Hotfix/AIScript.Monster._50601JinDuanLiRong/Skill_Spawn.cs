using System.Collections;
using AdventureBehaviour;
using UnityEngine;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_Spawn : SkillSimpleBase
{
	private readonly string fx_Path = "FX/ActorCommon/fx_switch_monster_actor";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideOutEnable();
		SetHideModelEnable();
		_playFx = new PlayFX();
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		_playFx.Play(_actor, fx_Path, 1f, _actor.transform.position, spawnRotation);
		yield return WaitTime(1);
		SetHideOutDisable();
		SetHideModelDisable();
		SetLogicTagToggleValue(_actor, "appelIsDone", value: false);
		while (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) > 15)
		{
			yield return WaitTime(0.5);
		}
	}
}
