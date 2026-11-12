using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack03 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Start_1 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1952805747,
		(ComboInputBuffer.ActionKey)1918065779,
		(ComboInputBuffer.ActionKey)1867013987
	};

	private readonly ComboInputBuffer.ActionKey[] Start_2;

	private readonly ComboInputBuffer.ActionKey[] Start_3;

	private readonly ComboInputBuffer.ActionKey[] Start_4;

	private readonly ComboInputBuffer.ActionKey[] End_1;

	private readonly ComboInputBuffer.ActionKey[] End_2;

	private readonly ComboInputBuffer.ActionKey[] End_3;

	private readonly ComboInputBuffer.ActionKey[] End_4;

	private readonly ComboInputBuffer.ActionKey[] Atk_1;

	private readonly ComboInputBuffer.ActionKey[] Atk_2;

	private readonly ComboInputBuffer.ActionKey[] Atk_3;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) >= 5)
		{
			TSVector2 tSVector = new TSVector2(0, 0);
			TSVector2 normalized = _actor.tsTransform.Forward.normalized;
			TSVector2 normalized2 = (tSVector - _actor.tsTransform.Position).normalized;
			if (TSVector2.SignedAngle(normalized, normalized2) > -45 && TSVector2.SignedAngle(normalized, normalized2) < 45)
			{
				BeginAttack(1, Start_1, flushInputedKeys: true, forceInterruptAttack: true);
				SetCloseBlockEnable();
			}
			else if (TSVector2.SignedAngle(normalized, normalized2) >= 45 && TSVector2.SignedAngle(normalized, normalized2) <= 135)
			{
				BeginAttack(1, Start_3, flushInputedKeys: true, forceInterruptAttack: true);
				SetCloseBlockEnable();
			}
			else if (TSVector2.SignedAngle(normalized, normalized2) >= -135 && TSVector2.SignedAngle(normalized, normalized2) <= -45)
			{
				BeginAttack(1, Start_4, flushInputedKeys: true, forceInterruptAttack: true);
				SetCloseBlockEnable();
			}
			else
			{
				BeginAttack(1, Start_2, flushInputedKeys: true, forceInterruptAttack: true);
				SetCloseBlockEnable();
			}
		}
		if (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) < 5)
		{
			if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -45 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 45)
			{
				if (Distance(GetPosition(), new TSVector2(0, 0)) < 10)
				{
					BeginAttack(1, Start_2, flushInputedKeys: true, forceInterruptAttack: true);
					SetCloseBlockEnable();
				}
				else
				{
					BeginAttack(1, Start_1, flushInputedKeys: true, forceInterruptAttack: true);
					SetCloseBlockEnable();
				}
			}
			else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 45 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 135)
			{
				TSVector2 tSVector2 = new TSVector2(0, 0);
				TSVector2 normalized3 = _actor.tsTransform.Forward.normalized;
				TSVector2 normalized4 = (tSVector2 - _actor.tsTransform.Position).normalized;
				if (TSVector2.SignedAngle(normalized3, normalized4) >= 0 && TSVector2.SignedAngle(normalized3, normalized4) <= 180)
				{
					BeginAttack(1, Start_3, flushInputedKeys: true, forceInterruptAttack: true);
					SetCloseBlockEnable();
				}
				else if (TSVector2.SignedAngle(normalized3, normalized4) >= -180 && TSVector2.SignedAngle(normalized3, normalized4) < 0)
				{
					BeginAttack(1, Start_4, flushInputedKeys: true, forceInterruptAttack: true);
					SetCloseBlockEnable();
				}
			}
			else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -135 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= -45)
			{
				TSVector2 tSVector3 = new TSVector2(0, 0);
				TSVector2 normalized5 = _actor.tsTransform.Forward.normalized;
				TSVector2 normalized6 = (tSVector3 - _actor.tsTransform.Position).normalized;
				if (TSVector2.SignedAngle(normalized5, normalized6) >= 0 && TSVector2.SignedAngle(normalized5, normalized6) <= 180)
				{
					BeginAttack(1, Start_3, flushInputedKeys: true, forceInterruptAttack: true);
					SetCloseBlockEnable();
				}
				else if (TSVector2.SignedAngle(normalized5, normalized6) >= -180 && TSVector2.SignedAngle(normalized5, normalized6) < 0)
				{
					BeginAttack(1, Start_4, flushInputedKeys: true, forceInterruptAttack: true);
					SetCloseBlockEnable();
				}
			}
			else
			{
				BeginAttack(1, Start_1, flushInputedKeys: true, forceInterruptAttack: true);
				SetCloseBlockEnable();
			}
		}
		yield return WaitCustomEvent("DodgeEnd");
		SetCloseBlockDisable();
		BeginTrace(GetCurrentPlayer(), 0, 30, 0.5);
		yield return WaitTraceFinish();
		CancelAttack();
		if (GetBuffNum(_actor, 503010004) >= 1)
		{
			if (GetBuffNum(_actor, 503010003) >= 1)
			{
				BeginAttack(2, End_3, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitFrame(10);
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 0.1, 180);
				yield return WaitCustomEvent("Combo");
				BeginAttack(3, Atk_2, flushInputedKeys: true, forceInterruptAttack: true);
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 0.3, 150);
				yield return WaitTime(0.67);
				CancelAttack();
			}
			else
			{
				BeginAttack(2, End_2, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitFrame(10);
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 0.1, 180);
				yield return WaitCustomEvent("Combo");
				BeginAttack(3, Atk_1, flushInputedKeys: true, forceInterruptAttack: true);
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 0.1, 180);
			}
		}
		else
		{
			BeginAttack(2, End_2, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.1, 180);
			yield return WaitCustomEvent("Combo");
			BeginAttack(3, Atk_1, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.1, 180);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	protected void DoDashMove()
	{
		BeginLookAt_NotWait(GetCurrentPlayer(), 1, 240);
		BeginDash(1, GetForward(), 3, 3, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false, 0.5);
	}

	protected void DoShoot01()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2));
		FanMultipleShoot("Bullet_50301_MaoDa_Skill01_Small_01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, shootPosition, 1.85, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
	}

	public Wind_Attack03()
	{
		//IL_00f3: Field data (rva=0x5d8) could not be found in any section!
		//IL_00f3: Field data (rva=0x5d8) could not be found in any section!
		//IL_00c5: Field data (rva=0x6d0) could not be found in any section!
		//IL_00c5: Field data (rva=0x6d0) could not be found in any section!
		//IL_0024: Field data (rva=0x720) could not be found in any section!
		//IL_0024: Field data (rva=0x720) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._3183AD5CC447DEE86C6E6F85AD237EB12473784D2859CE96DAB80E4FFBEEEDD8));
		Start_2 = array;
		Start_3 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1951623022,
			(ComboInputBuffer.ActionKey)778399343,
			(ComboInputBuffer.ActionKey)29539
		};
		Start_4 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1953450079,
			(ComboInputBuffer.ActionKey)1551395174,
			(ComboInputBuffer.ActionKey)1835362388
		};
		End_1 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1852397617,
			(ComboInputBuffer.ActionKey)1550153049,
			(ComboInputBuffer.ActionKey)1818848083
		};
		End_2 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1400262254,
			(ComboInputBuffer.ActionKey)1967681121,
			(ComboInputBuffer.ActionKey)1935879777
		};
		End_3 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1936933212,
			(ComboInputBuffer.ActionKey)1551070309,
			(ComboInputBuffer.ActionKey)1600352851
		};
		End_4 = new ComboInputBuffer.ActionKey[3]
		{
			ComboInputBuffer.ActionKey.B,
			(ComboInputBuffer.ActionKey)1933663285,
			(ComboInputBuffer.ActionKey)1937007987
		};
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._2DC4D150E146E2CC568A4FB7F8DD9A22F5E13EB0BE2461605A631E4988400F1C));
		Atk_1 = array2;
		Atk_2 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1768641372,
			(ComboInputBuffer.ActionKey)1666411628,
			(ComboInputBuffer.ActionKey)1953524082
		};
		ComboInputBuffer.ActionKey[] array3 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array3, __ldtoken(_003CPrivateImplementationDetails_003E._137345927A59FE2F1EDCF4729DC3DA1513AE2D79ACF18B524399FA277B76A84A));
		Atk_3 = array3;
		base._002Ector();
	}
}
