using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Template.ThemeSkill;

public class Skill_Wind_Light : SkillSimpleBase
{
	private readonly string fx_Path = "FX/MonsterDrop/fx_common_Cristal_Charge_Light";

	private static readonly string AreaEffectAlias = "Actor/Monster/RogueMonsterTheme/Weapon/Theme_Boom_Light_1m";

	private static readonly int totalFrame = 150;

	private static FP playAreaEffectCD = 1f;

	private static FP playAreaEffectDistance = 6;

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
					PlayAreaEffect(AreaEffectAlias, entityPositionObsoleted);
					lastPlayAreaEffectTime = _actor.LogicTime;
				}
			}
		}
		_playFx.Stop();
	}
}
