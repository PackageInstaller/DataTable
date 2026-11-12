using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Water_Dark : SkillSimpleBase
{
	private readonly FP waitTime = 0.5f;

	private readonly string fx_Path = "FX/Perk/fx_perk_base_water_shark_normal";

	private readonly string bullet_Boom = "Actor/Monster/RogueMonsterTheme/Weapon/Theme_SummonBullet_Water_Shilaimu";

	private readonly List<TSVector2> posList = new List<TSVector2>
	{
		new TSVector2(2, 2),
		new TSVector2(-2, 2),
		new TSVector2(2, -2),
		new TSVector2(-2, -2)
	};

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
		for (int i = 0; i < posList.Count; i++)
		{
			TSVector2 tSVector = _actor.tsTransform.Position + posList.get_Item(i);
			string bulletAlias = bullet_Boom;
			AdventureActor actor = _actor;
			FP range = 1.2f;
			TSVector2 position = _actor.tsTransform.Position;
			TSVector2 targetPosition = tSVector;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		}
	}
}
