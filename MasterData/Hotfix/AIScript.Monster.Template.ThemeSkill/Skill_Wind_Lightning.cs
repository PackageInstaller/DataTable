using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Wind_Lightning : SkillSimpleBase
{
	private readonly string fx_Path = "FX/MonsterDrop/fx_common_Cristal_Charge_Light";

	private readonly string fx_Path_Shoot = "FX/MonsterDrop/fx_monster_drop_base_light_shoot_1";

	private static readonly string AreaEffectAlias = "Actor/Monster/RogueMonsterTheme/Weapon/Theme_Boom_Light_1m";

	private static readonly int totalFrame = 150;

	private static FP playAreaEffectCD = 1f;

	private static FP playAreaEffectDistance = 6;

	private PlayFX _playFxA;

	private PlayFX _playFxB;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_playFxA?.Clear();
		_playFxB?.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		_playFxA = new PlayFX();
		_playFxB = new PlayFX();
		Quaternion rotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		_playFxA.Play(_actor, fx_Path, 1f, _actor.transform.position, rotation);
		yield return WaitTime(1);
		int currentFrame = 0;
		FP lastPlayAreaEffectTime = 0;
		while (currentFrame <= totalFrame)
		{
			yield return WaitFrame(1);
			currentFrame++;
			if (lastPlayAreaEffectTime > 0 && _actor.LogicTime - lastPlayAreaEffectTime < playAreaEffectCD)
			{
				continue;
			}
			LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
			if (!(attackTarget == null))
			{
				TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(attackTarget);
				if (!(Distance(entityPositionObsoleted, GetPosition()) > playAreaEffectDistance))
				{
					_playFxB.Play(_actor, fx_Path_Shoot, 1f, _actor.transform.position, rotation);
					PlayAreaEffect(AreaEffectAlias, entityPositionObsoleted);
					lastPlayAreaEffectTime = _actor.LogicTime;
				}
			}
		}
		_playFxA.Stop();
		_playFxB.Stop();
	}
}
