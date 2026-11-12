using System.Collections;
using AIScript.Monster.Trap;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Trap._10301XinYue;

public class SkillScript_NormalAttack : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private string evt_1 = "Shoot";

	private ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private readonly string bulletPath = "Weapon_13031XinYue_Bomb";

	private readonly TSVector2 startPositionOffset = new TSVector2(-0.2f, 0.6f);

	private readonly FP startPositionOffsetY = 1.4f;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitCustomEvent(evt_1);
		Shoot();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Shoot()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		TSVector2 position = ILRuntimeAPI.TransLocalPosToWorldPosByPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, startPositionOffset);
		FP positionY = _actor.tsTransform.PositionY + startPositionOffsetY;
		ILRuntimeAPI.Shoot(bulletPath, _actor, 0, position, positionY, activedPlayerActor.tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}
}
