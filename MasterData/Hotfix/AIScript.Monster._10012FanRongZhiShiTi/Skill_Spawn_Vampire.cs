using System.Collections;
using AdventureBehaviour;
using UnityEngine;

namespace AIScript.Monster._10012FanRongZhiShiTi;

public class Skill_Spawn_Vampire : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private readonly string fx_Path = "FX/ActorCommon/fx_common_base_monster_in_ground";

	private readonly string fx_Path2 = "FX/ActorCommon/fx_common_base_monster_in";

	private readonly string fx_Path3 = "FX/Warning/Old/fx_common_base_Earth_YuJing_circular_10";

	private readonly string fx_Path4 = "FX/Warning/Old/fx_common_base_Earth_YuJing_circular_10_end";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideOutEnable();
		SetHideModelEnable();
		_playFx = new PlayFX();
		Quaternion rotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		_playFx.Play(_actor, fx_Path, 1f, _actor.transform.position, rotation);
		_playFx.Play(_actor, fx_Path3, 1f, _actor.transform.position, rotation);
		yield return WaitTime(0.15);
		_playFx.Play(_actor, fx_Path2, 1f, _actor.transform.position, rotation);
		yield return WaitTime(0.85);
		_playFx.Play(_actor, fx_Path4, 1f, _actor.transform.position, rotation);
		ShowCenterHpBar();
		SetHideOutDisable();
		SetHideModelDisable();
		yield return WaitTime(0.1);
	}
}
