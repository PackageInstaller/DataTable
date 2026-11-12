using System.Collections;
using AdventureBehaviour;
using UnityEngine;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_Spawn : SkillSimpleBase
{
	private string evt_play = "PlayHintFx";

	private long pointerFxIndex;

	private string pointerFx = "fx_m50271_loop_pointer_fixed";

	private readonly string fx_Path = "FX/ActorCommon/fx_switch_monster_actor";

	private PlayFX _playFx;

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideOutEnable();
		SetHideModelEnable();
		SetImmuneControlEnable();
		_playFx = new PlayFX();
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		_playFx.Play(_actor, fx_Path, 1f, _actor.transform.position, spawnRotation);
		yield return WaitTime(1);
		SetImmuneControlDisable();
		SetHideModelDisable();
		SetHideOutDisable();
		DispatchCustomEvent(evt_play);
	}
}
