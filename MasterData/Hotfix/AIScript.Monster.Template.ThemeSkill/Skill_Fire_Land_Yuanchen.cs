using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Fire_Land_Yuanchen : SkillSimpleBase
{
	private readonly FP waitTime = 2;

	private readonly string fx_Path = "";

	private readonly string bullet_f = "";

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
		LogicEntity logicEntity = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor;
		if (logicEntity != null)
		{
			string bulletAlias = bullet_f;
			AdventureActor actor = _actor;
			FP range = 0;
			LogicEntity target = logicEntity;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, default, default, default, target, AimType.Target);
		}
	}
}
