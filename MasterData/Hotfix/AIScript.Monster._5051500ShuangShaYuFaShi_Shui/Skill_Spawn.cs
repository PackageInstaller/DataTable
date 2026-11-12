using System.Collections;
using AdventureBehaviour;
using UnityEngine;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_Shui;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

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
		while (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) > 15)
		{
			yield return WaitTime(0.5);
		}
	}
}
