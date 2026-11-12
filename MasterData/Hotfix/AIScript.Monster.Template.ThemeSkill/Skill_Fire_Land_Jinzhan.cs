using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Fire_Land_Jinzhan : SkillSimpleBase
{
	private readonly FP waitTime = 0.1f;

	private readonly string fx_Path = "Actor/Monster/13031XinYue/FX/fx_m13031_base_Die";

	private readonly string bullet_Boom = "Actor/Monster/13031XinYue/Weapon/Weapon_13031XinYue_Bomb";

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_playFx?.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		_playFx = new PlayFX();
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		_playFx.Play(_actor, fx_Path, 1f, _actor.transform.position, spawnRotation);
		yield return WaitTime(waitTime);
		string bulletAlias = bullet_Boom;
		AdventureActor actor = _actor;
		FP range = 0;
		TSVector2 position = _actor.tsTransform.Position;
		ILRuntimeAPI.Shoot(bulletAlias, actor, range, default, default, position, null, AimType.Position);
	}
}
