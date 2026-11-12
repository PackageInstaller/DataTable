using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Dark_4_JianDun : SkillSimpleBase
{
	private readonly FP waitTime = 1.5f;

	private readonly string fx_Path = "FX/MonsterDrop/fx_common_Cristal_Charge_Dark";

	private readonly string Chargefx_Path = "FX/MonsterDrop/fx_common_Cristal_Charge_Dark_end";

	private readonly string bullet_Boom = "Actor/Monster/RogueMonsterTheme/Weapon/Theme_SummonBullet_Dark_JianDun";

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
		Quaternion rotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		_playFx.Play(_actor, fx_Path, 1f, _actor.transform.position, rotation);
		yield return WaitTime(waitTime);
		_playFx.Stop();
		_playFx.Play(_actor, Chargefx_Path, 1f, _actor.transform.position, rotation);
		for (int i = 0; i < posList.Count; i++)
		{
			TSVector2 tSVector = _actor.tsTransform.Position + posList.get_Item(i);
			string bulletAlias = bullet_Boom;
			AdventureActor actor = _actor;
			FP range = 0.6f;
			TSVector2 position = _actor.tsTransform.Position;
			TSVector2 targetPosition = tSVector;
			ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		}
	}
}
