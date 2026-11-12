using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk01_1;

	private readonly ComboInputBuffer.ActionKey[] Atk01_2;

	private readonly ComboInputBuffer.ActionKey[] Atk01_3;

	private readonly ComboInputBuffer.ActionKey[] Atk01_4;

	private readonly ComboInputBuffer.ActionKey[] Atk02_1;

	private readonly ComboInputBuffer.ActionKey[] Atk02_2;

	private readonly ComboInputBuffer.ActionKey[] Atk02_3;

	private readonly ComboInputBuffer.ActionKey[] Atk02_4;

	private long AreaEffectID;

	private LogicEntity Targetenemy;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(_actor, 503010004) >= 1)
		{
			BeginAttack(1, Atk02_1, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.5);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.1, 150);
			yield return WaitCustomEvent("Atk01End");
			BeginAttack(2, Atk02_3, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 220);
			yield return WaitCustomEvent("Atk02End");
			BeginAttack(3, Atk02_4, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 360);
			yield return WaitCustomEvent("Shoot");
			UseMonsterCloneActorCastSkill(5030110);
		}
		else if (GetBuffNum(_actor, 503010003) >= 1)
		{
			BeginAttack(1, Atk02_1, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.5);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.1, 150);
			yield return WaitCustomEvent("Atk01End");
			BeginAttack(2, Atk02_3, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 220);
			yield return WaitCustomEvent("Atk02End");
			BeginAttack(3, Atk02_4, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 360);
			yield return WaitCustomEvent("Shoot");
			UseMonsterCloneActorCastSkill(5030110);
		}
		else
		{
			BeginAttack(1, Atk01_1, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.2);
			yield return WaitTime(0.8);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.1, 150);
			yield return WaitCustomEvent("Atk01End");
			BeginAttack(2, Atk01_2, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 160);
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

	public Wind_Attack04()
	{
		//IL_0097: Field data (rva=0x770) could not be found in any section!
		//IL_0097: Field data (rva=0x770) could not be found in any section!
		//IL_000d: Field data (rva=0x688) could not be found in any section!
		//IL_000d: Field data (rva=0x688) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2A68422C71953191DE4EFD8C57619F106339EE731FF082C270BE3018FC01B5D7));
		Atk01_1 = array;
		Atk01_2 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1818848083,
			(ComboInputBuffer.ActionKey)1919112044,
			(ComboInputBuffer.ActionKey)1601466473
		};
		Atk01_3 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1701668200,
			(ComboInputBuffer.ActionKey)1919501919,
			(ComboInputBuffer.ActionKey)1818313317
		};
		Atk01_4 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1684957527,
			(ComboInputBuffer.ActionKey)1684106306,
			(ComboInputBuffer.ActionKey)1935879781
		};
		Atk02_1 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1701668200,
			(ComboInputBuffer.ActionKey)1802659152,
			(ComboInputBuffer.ActionKey)1701336156
		};
		Atk02_2 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)778530409,
			(ComboInputBuffer.ActionKey)29539,
			(ComboInputBuffer.ActionKey)256
		};
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._380DBAF0173736023F27E87EE939CF51F122CE35F5AFC9FBCF71467D8D27B525));
		Atk02_3 = array2;
		Atk02_4 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1096561408,
			(ComboInputBuffer.ActionKey)1952805747,
			(ComboInputBuffer.ActionKey)1918065779
		};
		base._002Ector();
	}
}
