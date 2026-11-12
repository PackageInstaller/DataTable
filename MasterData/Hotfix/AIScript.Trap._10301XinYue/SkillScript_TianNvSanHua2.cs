using System.Collections;
using AIScript.Monster.Trap;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Trap._10301XinYue;

public class SkillScript_TianNvSanHua2 : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	private readonly FP waitDuration = 0.5;

	private readonly string bulletPath = "Weapon_13031XinYue_Bomb";

	public TSVector[] originOffsets = new TSVector[4]
	{
		new TSVector(0, 2, 0),
		new TSVector(0, 2, 0),
		new TSVector(0, 2, 0),
		new TSVector(0, 2, 0)
	};

	public TSVector2[] targetOffsets = new TSVector2[4]
	{
		new TSVector2(5, 8),
		new TSVector2(-5, 8),
		new TSVector2(0, 13),
		new TSVector2(0, 3)
	};

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitDuration));
		for (int i = 0; i < 4; i++)
		{
			TSVector tSVector = originOffsets[i];
			TSVector2 tSVector2 = targetOffsets[i];
			TSVector2 targetPosition = ILRuntimeAPI.TransLocalPosToWorldPosByPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, new TSVector2(tSVector2.x, tSVector2.y));
			TSVector2 position = ILRuntimeAPI.TransLocalPosToWorldPosByPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, new TSVector2(tSVector.x, tSVector.z));
			FP positionY = _actor.tsTransform.PositionY + tSVector.y;
			ILRuntimeAPI.Shoot(bulletPath, _actor, 0, position, positionY, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		}
	}
}
