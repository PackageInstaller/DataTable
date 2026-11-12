using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using UnityEngine;

namespace AIScript.Monster._50041XiaoFa;

public class Skill_NormalAttack_TWJ : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private readonly string fx_Path = "FX/ActorCommon/fx_switch_monster_actor_easy";

	private PlayFX _playFx;

	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "SummonATK", value: false);
		SetUnparalleledEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		_playFx = new PlayFX();
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)_actor.tsTransform.Rotation, 0f);
		_playFx.Play(_actor, fx_Path, 1f, _actor.transform.position, spawnRotation);
		yield return WaitTime(1);
		SetHideModelDisable();
		yield return WaitTime(1);
		for (int i = 0; i < 40; i++)
		{
			if (GetLogicTagToggleValue(_actor, "SummonATK"))
			{
				yield return StartCor(normalATK());
				break;
			}
			yield return WaitTime(0.2);
		}
		List<LogicEntity> entities = new List<LogicEntity> { _actor };
		KillActors(entities);
	}

	protected IEnumerator normalATK()
	{
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Turn && CheckTargetIsValid(GetAttackTarget()))
		{
			WaitLookAt_NoWait(GetAttackTarget(), 5, GetRotSpdInSkill() * 1);
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
	}
}
