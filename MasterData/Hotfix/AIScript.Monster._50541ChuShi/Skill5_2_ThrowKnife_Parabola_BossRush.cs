using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill5_2_ThrowKnife_Parabola_BossRush : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Throw_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private static readonly int BulletAmount_Stage1 = 4;

	private static readonly int BulletAmount_Stage2 = 6;

	private static readonly int BulletAmount_Stage3 = 8;

	private static readonly FP ShootRadius = 4;

	private static readonly FP ShootHeight = 4;

	private int BulletAmount;

	private int BulletCount;

	private int BattleStage;

	private string BulletKnifeName;

	private string BulletForkName;

	private string BulletName;

	private string BulletBornFXName;

	private string BulletKnifeReadyName;

	private string BulletForkReadyName;

	private string BulletReadyName;

	private List<long> BulletReadyFXList;

	protected override void OnSkillEnable()
	{
		BattleStage = (int)(long)GetLogicTagFpValue(_actor, "BattleStage");
		if (BattleStage == 1)
		{
			BulletAmount = BulletAmount_Stage1;
			BulletKnifeName = "Knife_Parabola";
			BulletForkName = "Fork_Parabola";
			BulletBornFXName = "BulletBorn_NoFire";
			BulletKnifeReadyName = "BulletReady_Knife";
			BulletForkReadyName = "BulletReady_Fork";
		}
		else if (BattleStage == 2)
		{
			BulletAmount = BulletAmount_Stage2;
			BulletKnifeName = "Knife_Parabola_Fire";
			BulletForkName = "Fork_Parabola_Fire";
			BulletBornFXName = "BulletBorn";
			BulletKnifeReadyName = "BulletReady_Knife_Fire";
			BulletForkReadyName = "BulletReady_Fork_Fire";
		}
		else if (BattleStage == 3)
		{
			BulletAmount = BulletAmount_Stage3;
			BulletKnifeName = "Knife_Parabola_Fire";
			BulletForkName = "Fork_Parabola_Fire";
			BulletBornFXName = "BulletBorn";
			BulletKnifeReadyName = "BulletReady_Knife_Fire";
			BulletForkReadyName = "BulletReady_Fork_Fire";
		}
		BulletCount = 0;
		BulletReadyFXList = new List<long>();
	}

	protected override void OnSkillDisable()
	{
		BulletReadyFXList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Throw_Combo);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		while (BulletCount < BulletAmount)
		{
			if (BulletCount % 2 == 0)
			{
				BulletReadyName = BulletKnifeReadyName;
			}
			else
			{
				BulletReadyName = BulletForkReadyName;
			}
			TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), RotateTo(new TSVector2(0, ShootRadius), BulletCount * (360 / BulletAmount)));
			PlayEffect(BulletBornFXName, 1f, ShootHeight, tSVector, GetTSVectToAngle(tSVector - GetPosition(), 0), 1.5f);
			BulletReadyFXList.Add(PlayEffect(BulletReadyName, 1f, ShootHeight, tSVector, GetTSVectToAngle(tSVector - GetPosition(), 0)));
			yield return WaitTime(1.5f / (float)BulletAmount);
			BulletCount++;
		}
		for (BulletCount = 0; BulletCount < BulletAmount; BulletCount++)
		{
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), RotateTo(new TSVector2(0, ShootRadius), BulletCount * (360 / BulletAmount)));
			Skill5_2_ThrowKnife_Parabola_BossRush skill5_2_ThrowKnife_Parabola_BossRush = this;
			FP radius = 2;
			DeterministicShape shapeData = skill5_2_ThrowKnife_Parabola_BossRush.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			if (BulletCount % 2 == 0)
			{
				BulletName = BulletKnifeName;
			}
			else
			{
				BulletName = BulletForkName;
			}
			if (BulletCount < BulletReadyFXList.Count)
			{
				StopEffect(BulletReadyFXList.get_Item(BulletCount));
			}
			Skill5_2_ThrowKnife_Parabola_BossRush skill5_2_ThrowKnife_Parabola_BossRush2 = this;
			string bulletName = BulletName;
			FP shootHeight = ShootHeight;
			FP range = 0;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true));
			skill5_2_ThrowKnife_Parabola_BossRush2.Shoot(bulletName, shapeRandomPoint, shootHeight, range, default, AimType.Position, BulletDirectionType.BulletToTarget, entityPositionObsoleted);
			yield return WaitTime(2f / (float)BulletAmount);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
