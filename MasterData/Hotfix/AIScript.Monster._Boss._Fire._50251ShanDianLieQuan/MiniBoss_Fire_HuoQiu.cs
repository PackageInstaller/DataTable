using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_HuoQiu : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01;

	private readonly ComboInputBuffer.ActionKey[] Attack02;

	private readonly ComboInputBuffer.ActionKey[] Attack03;

	private readonly ComboInputBuffer.ActionKey[] Move;

	private string BulletName;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity TargetPlayer = GetCurrentPlayer();
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -15 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 15)
		{
			BeginAttack(1, Attack01, flushInputedKeys: true);
			BeginLookAt_NotWait(TargetPlayer, 0.5, 240);
			yield return WaitFrame(45);
			if (GetBuffNum(_actor, 502510009) >= 1)
			{
				BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Turn1");
				BeginLookAt_NotWait(TargetPlayer, 1, 60);
				yield return WaitCustomEvent("Turn2");
				StopLookAt();
				CancelAttack();
			}
			else
			{
				BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Out");
				CancelAttack();
			}
			yield return WaitCustomEvent("T1");
			BeginLookAt_NotWait(TargetPlayer, 1, 360);
			yield return WaitCustomEvent("T2");
			StopLookAt();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield break;
		}
		BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt(TargetPlayer, 0.5, 360);
		BeginAttack(1, Attack01, flushInputedKeys: true);
		BeginLookAt_NotWait(TargetPlayer, 0.5, 240);
		yield return WaitFrame(45);
		if (GetBuffNum(_actor, 502510009) >= 1)
		{
			BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Turn1");
			BeginLookAt_NotWait(TargetPlayer, 1, 60);
			yield return WaitCustomEvent("Turn2");
			StopLookAt();
			CancelAttack();
		}
		else
		{
			BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Out");
			CancelAttack();
		}
		yield return WaitCustomEvent("T1");
		BeginLookAt_NotWait(TargetPlayer, 1, 360);
		yield return WaitCustomEvent("T2");
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public MiniBoss_Fire_HuoQiu()
	{
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._326BDEC1E9B2516102A309A80336E11AD1C2BE8731440B66CC06D58A2273DAE4));
		Attack01 = array;
		Attack02 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1600352851,
			(ComboInputBuffer.ActionKey)1718906696,
			(ComboInputBuffer.ActionKey)1415346281
		};
		Attack03 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1701668200,
			(ComboInputBuffer.ActionKey)1802659152,
			(ComboInputBuffer.ActionKey)1701336156
		};
		Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };
		base._002Ector();
	}
}
