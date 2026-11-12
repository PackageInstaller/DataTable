using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101.Summoned.JuDian;

public class Skill_NormalAttack_JuDian : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Main_Attack";

	private string key_P04 = "Main_Attack_P04";

	private string evt_shoot = "Shoot";

	private const string bullet_JuDian = "Bullet_16101_JuDian";

	private const string bullet_JuDian_Strong = "Bullet_16101_JuDian_Strong";

	private static readonly FP bulletHeight = 2;

	private const int perkId_4 = 516104;

	protected override IEnumerator DoMainLogic()
	{
		bool p4 = GetPerk(516104);
		string actionKey = (p4 ? key_P04 : key);
		BeginAttack(keyIndex, actionKey, flushInputedKeys: true);
		yield return WaitCustomEvent(evt_shoot);
		ShootBullet(p4);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void ShootBullet(bool p4)
	{
		LogicEntity logicEntity = _actor.attackTarget ?? _actor.monsterTarget;
		if (!(logicEntity == null))
		{
			string bulletAlias = (p4 ? "Bullet_16101_JuDian_Strong" : "Bullet_16101_JuDian");
			AdventureActor actor = _actor;
			TSVector2 position = _actor.tsTransform.Position;
			FP positionY = bulletHeight;
			LogicEntity target = logicEntity;
			ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
