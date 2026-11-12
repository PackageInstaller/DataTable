using System.Collections;
using TrueSync;

namespace AIScript.Monster._Light._50041XiaoFa;

public class Skill_Light_Attack02 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string custom_Turn = "Turn";

	private static readonly string custom_StopTurn = "StopTurn";

	private readonly string Area_Effect01 = "Area_XiaoFa_Light_Wave";

	private readonly string Area_Effect02 = "Area_XiaoFa_Light_GroundLighting";

	private readonly string BulletName = "Weapon_XiaoFa_Light_Bullet";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true);
		yield return WaitCustomEvent("Spawn");
		StartCor(AttackCombo());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == custom_Turn && CheckTargetIsValid(GetAttackTarget()))
		{
			WaitLookAt_NoWait(GetAttackTarget(), 5, GetRotSpdInSkill() * 1);
		}
		else if (eventName == custom_StopTurn)
		{
			StopWaitLookAt();
		}
	}

	private IEnumerator AttackCombo()
	{
		LogicEntity AttackActor = GetAttackTarget();
		TSVector2 PlayerPos = GetEntityPositionObsoleted(GetAttackTarget());
		int num = 1;
		float spawnSize = 1f;
		PlayEffect(Area_Effect01, num, 0, PlayerPos, 0, spawnSize);
		yield return WaitFrame(30);
		PlayAreaEffect(Area_Effect02, PlayerPos, 0);
		Shoot(BulletName, PlayerPos, 0.5, 0, default, AimType.Forward, BulletDirectionType.ActorToBullet, PlayerPos, AttackActor);
	}
}
