using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Fire_3m_Explode : SkillSimpleBase
{
	private readonly FP waitTime = 2f;

	private readonly string bullet_Boom = "Actor/Monster/RogueMonsterTheme/Weapon/Theme_Boom_Fire_3m";

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
		Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		string bulletAlias = bullet_Boom;
		AdventureActor actor = _actor;
		FP range = 0;
		TSVector2 position = _actor.tsTransform.Position;
		ILRuntimeAPI.Shoot(bulletAlias, actor, range, default, default, position, null, AimType.Position);
		yield return WaitTime(2.2);
	}
}
