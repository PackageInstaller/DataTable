using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._Light._50281LeiSheZhu;

public class Attack_01 : SkillSimpleBase
{
	private Dictionary<string, string> bulletAliasDic = new Dictionary<string, string>
	{
		{ "Wind", "50281LeiSheZhu_Bullet_Wind" },
		{ "Dark", "50281LeiSheZhu_Bullet_Dark" },
		{ "Earth", "50281LeiSheZhu_Bullet_Earth" },
		{ "Fire", "50281LeiSheZhu_Bullet_Fire" },
		{ "Light", "50281LeiSheZhu_Bullet_Light" },
		{ "Common", "50281LeiSheZhu_Bullet_Common" },
		{ "Water", "50281LeiSheZhu_Bullet_Water" }
	};

	private static readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1];

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 5.5, 1800);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == 1 && eventName == "Shooting")
		{
			StartCor(ShootATK());
		}
	}

	private IEnumerator ShootATK()
	{
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2, GetPosition(), default, 2.5f);
		yield return WaitTime(0.3);
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (!bulletAliasDic.TryGetValue(monsterTagValue, out var value))
		{
			value = bulletAliasDic.get_Item("Light");
		}
		FanMultipleShoot(value, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 1.7, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 1, 0, 0);
	}
}
