using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill1_SummonBoomGhost : SkillSimpleBase
{
	private struct SummonPoint
	{
		public TSVector2 position;

		public TSVector2 direction;
	}

	private const string ComboKey = "Skill1_SummonBoomGhost";

	private const string BulletName = "Weapon_70061WuYu_Skill1_Bullet";

	private static readonly TSVector2 BulletOffset = new TSVector2(0, 1.6);

	private static readonly FP FanAngleP1 = 120;

	private const int PointCountP1 = 3;

	private static readonly FP FanAngleP2 = 150;

	private const int PointCountP2 = 5;

	private static readonly FP Radius = 6;

	private static readonly FP SummonInterval = 0.2;

	private static readonly FP BulletShootHeight = 2.6;

	public static readonly FP SummonDelay = 0.7;

	public static readonly FP SummonProcessInterval = 2;

	public static readonly FP SummonTotalDuration = 1.3;

	public static readonly FP Entry_FanAngleP1 = 160;

	private const int Entry_PointCountP1 = 4;

	public static readonly FP Entry_FanAngleP2 = 180;

	private const int Entry_PointCountP2 = 6;

	public const string Skill1BulletTag = "Weapon_70061WuYu_Skill1_SummonBoomGhostBulletTag";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Skill1_SummonBoomGhost", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(SkillSimpleBase.ShootEvent);
		int num = GetLogicTagFpValue(_actor, "Phase").AsInt();
		bool logicTagToggleValue = GetLogicTagToggleValue(_actor, "LoyalServantTagId");
		FP fanAngle;
		int pointCount;
		if (num >= 2)
		{
			fanAngle = (logicTagToggleValue ? Entry_FanAngleP2 : FanAngleP2);
			pointCount = (logicTagToggleValue ? 6 : 5);
		}
		else
		{
			fanAngle = (logicTagToggleValue ? Entry_FanAngleP1 : FanAngleP1);
			pointCount = (logicTagToggleValue ? 4 : 3);
		}
		List<SummonPoint> summonList = CalcSummonPoints(fanAngle, pointCount);
		TSVector2 shootPos = _actor.tsTransform.TransformLocalPointToWorldSpace(BulletOffset);
		for (int i = 0; i < summonList.Count; i++)
		{
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Weapon_70061WuYu_Skill1_Bullet", _actor, default, shootPos, BulletShootHeight, summonList.get_Item(i).position, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (adventureBulletBase != null)
			{
				adventureBulletBase.ModifyBulletTag("Weapon_70061WuYu_Skill1_SummonBoomGhostBulletTag");
			}
			if (i < summonList.Count - 1)
			{
				yield return WaitTime(SummonInterval);
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private List<SummonPoint> CalcSummonPoints(FP fanAngle, int pointCount)
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 tSVector = ((currentPlayer != null) ? currentPlayer.tsTransform.Position : GetPosition());
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("CenterPoint");
		TSVector2 tSVector2 = placeHolderPosition - tSVector;
		TSVector2 v = ((tSVector2.magnitude > FP.Zero) ? tSVector2.normalized : GetForward());
		TSVector2 b = tSVector - placeHolderPosition;
		bool flag = TSVector2.SignedAngle(TSVector2.Rotate(TSVector2.up, Config.AxisAngle), b) > FP.Zero;
		FP fP = fanAngle / pointCount;
		List<SummonPoint> list = new List<SummonPoint>(pointCount);
		for (int i = 0; i < pointCount; i++)
		{
			FP degrees = ((flag ? (pointCount - 1 - i) : i) + FP.Half) * fP - fanAngle / 2;
			TSVector2 normalized = TSVector2.Rotate(v, degrees).normalized;
			TSVector2 tSVector3 = tSVector + normalized * Radius;
			TSVector2 tSVector4 = tSVector - tSVector3;
			TSVector2 direction = ((tSVector4.magnitude > FP.Zero) ? tSVector4.normalized : normalized);
			SummonPoint item = new SummonPoint
			{
				position = tSVector3,
				direction = direction
			};
			list.Add(item);
		}
		return list;
	}
}
