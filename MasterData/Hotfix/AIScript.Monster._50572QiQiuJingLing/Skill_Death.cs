using System.Collections;
using TrueSync;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Skill_Death : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Death_Common_Combo_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Death_Common_Combo_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Death_Common_Combo_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Death_Blast_Combo_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] Death_Blast_Combo_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] Death_Blast_Combo_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly int BulletAmount_Lv1 = 6;

	private static readonly int BulletAmount_Lv2 = 8;

	private FP SkillMode;

	private ComboInputBuffer.ActionKey[] DeathCombo;

	private FP VolumeLevel;

	private LogicEntity Master;

	private TSVector2 MasterPosition;

	private FP Difficulty;

	private int BulletAmount;

	private TSVector2 ShootDirection;

	protected override void OnSkillEnable()
	{
		VolumeLevel = GetLogicTagFpValue(_actor, "VolumeLevel");
		SkillMode = GetLogicTagFpValue(_actor, "SkillMode");
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		if (SkillMode == 1)
		{
			if (VolumeLevel == 1)
			{
				DeathCombo = Death_Blast_Combo_1;
			}
			else if (VolumeLevel == 2)
			{
				DeathCombo = Death_Blast_Combo_2;
			}
			else if (VolumeLevel == 3)
			{
				DeathCombo = Death_Blast_Combo_3;
			}
		}
		else if (VolumeLevel == 1)
		{
			DeathCombo = Death_Common_Combo_1;
		}
		else if (VolumeLevel == 2)
		{
			DeathCombo = Death_Common_Combo_2;
		}
		else if (VolumeLevel == 3)
		{
			DeathCombo = Death_Common_Combo_3;
		}
		if (Difficulty == 1)
		{
			BulletAmount = BulletAmount_Lv1;
			ShootDirection = GetTSVector2(GetRandomValue(0, 1), GetRandomValue(0, 1));
		}
		else
		{
			BulletAmount = BulletAmount_Lv2;
			ShootDirection = RotateTo(GetPosition() - GetEntityPositionObsoleted(GetCurrentPlayer()), 360 / (2 * BulletAmount));
		}
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (SkillMode == 1)
		{
			BeginAttack(1, DeathCombo, flushInputedKeys: true);
			AddBuffToTarget(_actor, 505729902);
			if (GetTargetByTeammateIndex(0).Count > 0)
			{
				Master = GetTargetByTeammateIndex(0).get_Item(0);
				MasterPosition = GetEntityPositionObsoleted(Master);
			}
			if (!GetLogicTagToggleValue(_actor, "LifeEnd"))
			{
				PlayEffect("HitFX", 1f, position: GetPosition(), fxPositionY: 1.5);
				yield return CrossJump(TransLocalPosToWorldPos(GetPosition(), GetPosition() - MasterPosition, new TSVector2(0, 5)), 50, 0);
			}
			yield return WaitCustomEvent("Blast");
			PlayWwiseSound("mon_50572_charge_splitbullet");
			CircleMultipleShoot("Weapon_Shoot", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, BulletAmount, 0, GetPosition(), 1.5, ShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			SetHideModelEnable();
			SendDeclareDeadEvent();
			yield return WaitTime(6);
		}
		else
		{
			SetCloseBlockEnable();
			BeginAttack(1, DeathCombo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(1.5);
			SetHideModelEnable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			SendDeclareDeadEvent();
		}
	}
}
