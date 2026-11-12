using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Earth_3_Shoot : SkillSimpleBase
{
	private readonly FP waitTime = 2f;

	private readonly string fx_Path = "FX/MonsterDrop/fx_common_Cristal_Charge_Earth_2";

	private readonly string Chargefx_Path = "FX/MonsterDrop/fx_common_Cristal_Charge_Earth_2_end";

	private readonly string bullet_Path = "Actor/Monster/RogueMonsterTheme/Weapon/Theme_Bullet_Earth";

	private readonly List<TSVector2> posList = new List<TSVector2>
	{
		new TSVector2(-2, 0),
		new TSVector2(2, 0)
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
		LogicEntity currentPlayer = GetCurrentPlayer();
		FP y = _actor.DistanceWithRadius(currentPlayer);
		FP degrees = (currentPlayer.tsTransform.Position - _actor.tsTransform.Position).GetAngle() + 70f;
		FP degrees2 = (currentPlayer.tsTransform.Position - _actor.tsTransform.Position).GetAngle() - 70f;
		TSVector2 position = currentPlayer.tsTransform.Position;
		TSVector2 tSVector = currentPlayer.tsTransform.Position + TSVector2.Rotate(new TSVector2(0, y), degrees);
		TSVector2 tSVector2 = currentPlayer.tsTransform.Position + TSVector2.Rotate(new TSVector2(0, y), degrees2);
		GetEntityForward(_actor);
		TSVector2 position2 = _actor.tsTransform.Position;
		string bulletAlias = bullet_Path;
		AdventureActor actor = _actor;
		FP range = 0.6f;
		TSVector2 targetPosition = position;
		ILRuntimeAPI.Shoot(bulletAlias, actor, range, position2, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		string bulletAlias2 = bullet_Path;
		AdventureActor actor2 = _actor;
		FP range2 = 0.6f;
		targetPosition = tSVector;
		ILRuntimeAPI.Shoot(bulletAlias2, actor2, range2, position2, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		string bulletAlias3 = bullet_Path;
		AdventureActor actor3 = _actor;
		FP range3 = 0.6f;
		targetPosition = tSVector2;
		ILRuntimeAPI.Shoot(bulletAlias3, actor3, range3, position2, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}
}
