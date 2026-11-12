using System.Collections;
using AIScript.Monster.Trap;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Trap._10301XinYue;

public class SkillScript_ThrowTrap_City : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private string evt_1 = "Shoot";

	private ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private readonly string bulletPath = "Weapon_13031XinYue_Bomb_1-2";

	private readonly TSVector2 startOffset = new TSVector2(0f, 0.9f);

	private readonly FP startOffsetY = 1.8f;

	private TSVector2 targetOffset = new TSVector2(0f, 6f);

	private FP radio = 2.7f;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitCustomEvent(evt_1);
		Shoot();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Shoot()
	{
		TSVector2 position = ILRuntimeAPI.TransLocalPosToWorldPosByPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, startOffset);
		FP positionY = startOffsetY;
		_ = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		TSVector2 targetPosition = TrueSyncExtensions.RandomPointInsideRing(_actor.tsTransform.TransformLocalPointToWorldSpace(targetOffset), 0, radio);
		ILRuntimeAPI.Shoot(bulletPath, _actor, 0, position, positionY, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}
}
