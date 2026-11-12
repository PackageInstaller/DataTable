using System.Collections;
using AIScript.Utils;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_BurrowingAttack : SkillSimpleBase
{
	private static readonly string combo_Burrow_Down = "Burrow_Down";

	private static readonly string combo_Burrow_Up_Attack = "Burrow_Up_Attack";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private long WarningFX;

	private long WarningFX1;

	private long WarningFX2;

	private long BuffArea;

	private bool isHidden;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isHidden = false;
	}

	protected override void OnSkillDisable()
	{
		StopAreaEffect(BuffArea);
		StopWaitLookAt();
		StopEffect(WarningFX);
		StopEffect(WarningFX1);
		StopEffect(WarningFX2);
		if (isHidden)
		{
			ExitBurrow();
		}
		SetLogicTagToggleValue(_actor, Config.Skill_BurrowAttack_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(2, combo_Burrow_Down, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.15);
		EnterBurrow();
		yield return WaitTime(0.18);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 playerPos3 = GetEntityPosition(logicEntity);
		TSVector2 position = GetPosition();
		Vector3 startPosition = new Vector3((float)position.x, 0f, (float)position.y);
		Vector3 targetPosition = new Vector3((float)playerPos3.x, 0f, (float)playerPos3.y);
		float speed = (float)(Distance(position, playerPos3) / 0.5);
		PlayMovableFx("fx_m31301_loop_skill4_loop_move_root", startPosition, targetPosition, speed);
		yield return WaitTime(0.5);
		Teleport(playerPos3);
		StopTrace();
		StopEffect(WarningFX);
		WarningFX1 = PlayEffect("fx_m31301_base_skill4_endatk_move_warning", 1f, 1, GetPosition(), 0);
		BuffArea = PlayAreaEffect("Area_31301JiJuXie_Buff_circular_4_4_Damge", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)));
		LogicEntity logicEntity2 = GetAttackTarget();
		if (logicEntity2 == null)
		{
			logicEntity2 = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity2);
		BeginLookAtByPos(entityPosition, 0.6, 7200);
		yield return WaitTime(0.6);
		StopWaitLookAt();
		yield return WaitTime(0.1);
		BeginAttack(3, combo_Burrow_Up_Attack, flushInputedKeys: true, forceInterruptAttack: true);
		ExitBurrow();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void EnterBurrow()
	{
		if (!isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
			SetHideModelEnable();
			SetCloseBlockEnable();
			_actor.PauseMovementBlock();
			isHidden = true;
		}
	}

	private void ExitBurrow()
	{
		if (isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledDisable(_actor);
			SetHideModelDisable();
			SetCloseBlockDisable();
			_actor.ResumeMovementBlock();
			isHidden = false;
		}
	}
}
