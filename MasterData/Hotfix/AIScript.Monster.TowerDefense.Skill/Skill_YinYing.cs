using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_YinYing : TowerMonsterSkillBase
{
	private const string chargeEffectKey = "Weapon_50101YinYing_TD";

	private const string bulletKey = "Bullet_50101YinYing_TD";

	public const string BULLET_TAG_DARK = "YinYing_Dark";

	private FP shootPositionY = 0.2;

	private FP bulletRange = 30;

	protected override IEnumerator DoMainLogic()
	{
		MonsterRecGridInfo nextGridInfo = null;
		Dispatch_GetNextNGridInfo(1, (MonsterRecGridInfo info) =>
		{
			nextGridInfo = info;
		});
		MonsterRecGridInfo nextNextGridInfo = null;
		Dispatch_GetNextNGridInfo(2, (MonsterRecGridInfo info) =>
		{
			nextNextGridInfo = info;
		});
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 shootPos = ((nextGridInfo != null && nextGridInfo.ccIndex != -1) ? nextGridInfo.ccPosition : position);
		TSVector2 dir = _actor.tsTransform.Forward.normalized;
		if (nextGridInfo != null && nextGridInfo.ccIndex != -1 && nextNextGridInfo != null && nextNextGridInfo.ccIndex != -1)
		{
			TSVector2 normalized = (nextNextGridInfo.ccPosition - nextGridInfo.ccPosition).normalized;
			if (normalized != TSVector2.zero)
			{
				dir = normalized;
			}
		}
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Shoot");
		PlayAreaEffect("Weapon_50101YinYing_TD", shootPos, 90);
		yield return WaitCustomEvent("ShootFire");
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.ShootByDirection("Bullet_50101YinYing_TD", _actor, bulletRange, dir, shootPos, shootPositionY);
		if (adventureBulletBase != null)
		{
			adventureBulletBase.bulletTag = "YinYing_Dark";
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
