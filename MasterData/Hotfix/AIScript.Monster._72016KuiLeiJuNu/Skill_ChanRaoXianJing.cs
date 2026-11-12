using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Skill_ChanRaoXianJing : SkillSimpleBase
{
	private const string combo_Skill1 = "Skill1_C";

	private int loopCount = 1;

	private const string warningAlias = "FX/Warning/fx_warning_circular_1";

	private FP windupTime = 1.633f;

	private FP warningFlightTime = 0.5f;

	private const string trapAreaAlias = "Actor/Monster/72016RenOu_JuNu/Weapon/AreaEffect_72016RenOu_JuNu_TangleTrap";

	private const string bulletAlias = "Actor/Monster/72016RenOu_JuNu/Weapon/Bullet_72016RenOu_JuNu_Entangle";

	private FP fireHeight = 1.5f;

	private TSVector2 fireOffset = new TSVector2(0, 1f);

	private const string chargeFxNamePart = "Entangle_xuli";

	private int loopIndex;

	private long warningFxId;

	private bool warningLocked;

	private TSVector2 trapPos;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget() ?? GetCurrentPlayer();
		if (!(target == null))
		{
			if (GetLogicTagFpValue(_actor, "NeedChase") == 1)
			{
				MoveToPosition(GetEntityPosition(target), 12, AdventureActor.MovementMode.Run, 5);
				yield return WaitMoveStatus();
				StopMove();
			}
			loopIndex = 0;
			warningLocked = false;
			BeginLookAt_NotWait(target, 999, GetRotSpdInSkill());
			BeginAttack(1, "Skill1_C", flushInputedKeys: true);
			CoroutineNode warningCor = StartCor(TargetedWarningCor(target));
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return warningCor;
		}
	}

	private TSVector2 GetChargeFxFirePos(out FP posY)
	{
		Transform transform = FindChildByNameContains(_actor.transform, "Entangle_xuli");
		if (transform != null)
		{
			Vector3 position = transform.position;
			posY = position.y;
			return new TSVector2(position.x, position.z);
		}
		posY = fireHeight;
		return TransLocalPosToWorldPos(GetPosition(), GetForward(), fireOffset);
	}

	private static Transform FindChildByNameContains(Transform root, string namePart)
	{
		for (int i = 0; i < root.childCount; i++)
		{
			Transform child = root.GetChild(i);
			if (child.name.Contains(namePart))
			{
				return child;
			}
			Transform transform = FindChildByNameContains(child, namePart);
			if (transform != null)
			{
				return transform;
			}
		}
		return null;
	}

	protected override void OnComboLoop(int comboIndex)
	{
		loopIndex++;
		if (loopIndex >= loopCount)
		{
			warningLocked = true;
			TSVector2 chargeFxFirePos = GetChargeFxFirePos(out var posY);
			FP positionY = posY;
			FP range = 0;
			TSVector2 targetPosition = trapPos;
			Shoot("Actor/Monster/72016RenOu_JuNu/Weapon/Bullet_72016RenOu_JuNu_Entangle", chargeFxFirePos, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
			StopLookAt();
			CancelAttack();
		}
	}

	private IEnumerator TargetedWarningCor(LogicEntity target)
	{
		Skill_ChanRaoXianJing skill_ChanRaoXianJing = this;
		Skill_ChanRaoXianJing skill_ChanRaoXianJing2 = this;
		float duration = (float)(windupTime + warningFlightTime);
		TSVector2 entityPosition = GetEntityPosition(target);
		skill_ChanRaoXianJing.warningFxId = skill_ChanRaoXianJing2.PlayEarlyWarningEffect("FX/Warning/fx_warning_circular_1", duration, default, entityPosition, default, 2f);
		while (!warningLocked)
		{
			trapPos = GetEntityPosition(target);
			ModifyEffectPosition(warningFxId, trapPos);
			yield return WaitTime(0.05);
		}
		yield return WaitTime(warningFlightTime);
		CompleteEarlyWarningEffect(warningFxId);
	}
}
