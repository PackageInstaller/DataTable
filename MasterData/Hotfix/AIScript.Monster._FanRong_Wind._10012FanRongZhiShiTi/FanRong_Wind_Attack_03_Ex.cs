using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Attack_03_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1952805747,
		(ComboInputBuffer.ActionKey)1918065779,
		(ComboInputBuffer.ActionKey)1867013987
	};

	private readonly string Combo1 = "C1";

	private readonly string Combo2 = "C2";

	private readonly string Combo3 = "C3";

	private readonly string Turn1 = "T1";

	private readonly string Turn2 = "T2";

	private long AreaEffectID01;

	private long AreaEffectID02;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID01);
		StopAreaEffect(AreaEffectID02);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Wave");
		DoWave();
		yield return WaitCustomEvent(Combo1);
		CancelAttack();
		yield return WaitCustomEvent("Shoot");
		DoShoot();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == Turn1)
		{
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			BeginLookAt_NotWait(logicEntity, 1, 200, 0);
		}
		else if (eventName == Turn2)
		{
			StopWaitLookAt();
		}
	}

	protected void DoWave()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			AreaEffectID01 = PlayAreaEffect("AreaEffect_Wind_Skill03_Wave01", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), GetTSVectToAngle(GetForward(), 30));
			AreaEffectID02 = PlayAreaEffect("AreaEffect_Wind_Skill03_Wave01", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), GetTSVectToAngle(GetForward(), -30));
		}
	}

	protected void DoShoot()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			FanMultipleShoot("Weapon_Wind_Skill03_02", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 60, 0, 0);
		}
	}
}
