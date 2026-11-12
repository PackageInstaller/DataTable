using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill7_CallKnife : SimpleAPI_ChuShi
{
	private static readonly ComboInputBuffer.ActionKey[] Call = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private TSVector2 CallBackTargetPosition;

	private TSVector2 CenterPosition;

	private int KnifeAndForkCount;

	private FP TurnSpeed;

	private bool IsCallBackChargeEnd;

	private TSVector2 SkillPoint;

	private CoroutineNode CheckBackBulletCoroutine;

	private CoroutineNode CallBackChargeNode;

	private CoroutineNode CallBackNode;

	private List<long> LinkEffects;

	private List<TSVector2> JumpPointList;

	private List<TSVector2> AllSummonPosition;

	private DeterministicShape LeftArea;

	private DeterministicShape RightArea;

	protected override void OnSkillEnable()
	{
		AddBuffToTarget(_actor, 990020140);
		TurnSpeed = GetRotSpdInSkill();
		SetLogicTagToggleValue(_actor, "IsCallKnife", value: true);
		IsCallBackChargeEnd = false;
		KnifeAndForkCount = 0;
		SetBlockPriorityToStatic();
		JumpPointList = new List<TSVector2>
		{
			GetPlaceHolderPosition("CallKnifeJumpPoint5"),
			GetPlaceHolderPosition("CallKnifeJumpPoint4"),
			GetPlaceHolderPosition("CallKnifeJumpPoint3"),
			GetPlaceHolderPosition("CallKnifeJumpPoint2"),
			GetPlaceHolderPosition("CallKnifeJumpPoint1")
		};
		SkillPoint = GetPlaceHolderPosition("CallKnifeJumpPoint1");
		CenterPosition = GetPlaceHolderPosition("CenterPosition");
		LinkEffects = new List<long>();
		AllSummonPosition = new List<TSVector2>();
	}

	protected override void OnSkillDisable()
	{
		AllSummonPosition.Clear();
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
		StopDash();
		StopCor(CheckBackBulletCoroutine);
		SetLogicTagToggleValue(_actor, "IsCallKnife", value: false);
		List<LogicEntity> targetByTeammateIndexes = GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 });
		KillActors(targetByTeammateIndexes);
	}

	protected override IEnumerator DoMainLogic()
	{
		foreach (TSVector2 jumpPoint in JumpPointList)
		{
			Skill7_CallKnife skill7_CallKnife = this;
			TSVector2 centerPosition = CenterPosition;
			FP radius = 50;
			FP innerRadius = 0;
			FP angle = 180;
			FP tSVectToAngle = GetTSVectToAngle(CenterPosition - jumpPoint, 0);
			DeterministicShape shapeData = skill7_CallKnife.GetShapeData(DeterministicShape.ShapeType.Fan, centerPosition, default, default, radius, innerRadius, angle, tSVectToAngle);
			int count = GetTargetsFromShape(shapeData, GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 })).Count;
			if (count > KnifeAndForkCount)
			{
				KnifeAndForkCount = count;
				SkillPoint = jumpPoint;
			}
		}
		yield return StartCor(JumpToPoints(SkillPoint));
		yield return BeginLookAtByPos(TSVector2.zero, 0, TurnSpeed * 2);
		CallBackTargetPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.2));
		if (GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 }).Count == 0)
		{
			IsCallBackChargeEnd = true;
		}
		else
		{
			StartCor(ref CallBackChargeNode, CallBackCharge());
		}
		while (!IsCallBackChargeEnd)
		{
			if (GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 }).Count == 0)
			{
				IsCallBackChargeEnd = true;
				StopCor(CallBackChargeNode);
				StartCor(ref CallBackNode, CallBack());
			}
			yield return null;
		}
		StopCor(CheckBackBulletCoroutine);
		yield return WaitTime(2);
	}

	protected IEnumerator CheckBrokenLineBulletBack()
	{
		while (true)
		{
			List<DeterministicCollider> list = new List<DeterministicCollider>();
			SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(2, CallBackTargetPosition, list, 32768);
			for (int i = 0; i < list.Count; i++)
			{
				AdventureBullet adventureBullet = list.get_Item(i).Entity as AdventureBullet;
				if (adventureBullet != null && adventureBullet.owner == _actor)
				{
					Skill7_CallKnife skill7_CallKnife = this;
					TSVector2 position = adventureBullet.tsTransform.Position;
					skill7_CallKnife.PlayEffect("BulletBorn", 1f, default, position);
					adventureBullet.Finish(cancel: true);
				}
			}
			yield return null;
		}
	}

	protected IEnumerator CallBackCharge()
	{
		BeginAttack(2, Call, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		List<LogicEntity> AllSummon = GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 });
		foreach (LogicEntity item4 in AllSummon)
		{
			Skill7_CallKnife skill7_CallKnife = this;
			LogicEntity target = item4;
			long item = skill7_CallKnife.PlayLinkEffect("CallLine1", useCustomSource: false, null, default, default, target);
			LinkEffects.Add(item);
			SetLogicTagToggleValue(item4, "IsCallBack", value: true);
		}
		yield return WaitTime(0.1);
		foreach (LogicEntity item5 in AllSummon)
		{
			Skill7_CallKnife skill7_CallKnife2 = this;
			LogicEntity target = item5;
			long item2 = skill7_CallKnife2.PlayLinkEffect("CallLine2", useCustomSource: false, null, default, default, target);
			LinkEffects.Add(item2);
		}
		yield return WaitTime(1.5);
		AllSummon.Clear();
		AllSummon = GetTargetByTeammateIndexes(new List<int> { 1, 2, 4, 5 });
		for (int num = AllSummon.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = AllSummon.get_Item(num);
			AdventureActor adventureActor = logicEntity as AdventureActor;
			Skill7_CallKnife skill7_CallKnife3 = this;
			LogicEntity target = logicEntity;
			long item3 = skill7_CallKnife3.PlayLinkEffect("CallLine2", useCustomSource: false, null, default, default, target, default, default, breakWhenLostSourceOrTarget: false);
			LinkEffects.Add(item3);
			Skill7_CallKnife skill7_CallKnife4 = this;
			TSVector2 position = adventureActor.tsTransform.Position;
			skill7_CallKnife4.PlayEffect("HitFlashFX", 1f, default, position, default, 0.5f);
			AllSummonPosition.Add(GetEntityPositionObsoleted(logicEntity));
			adventureActor.DestroySelf();
		}
	}

	private IEnumerator CallBack()
	{
		FP CallBackTargetPositionY = 1.4;
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_50541_skill_silkcatchknife_explosion");
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitTime(0.3);
		foreach (long linkEffect in LinkEffects)
		{
			StopEffect(linkEffect);
		}
		StartCor(ref CheckBackBulletCoroutine, CheckBrokenLineBulletBack());
		foreach (TSVector2 item in AllSummonPosition)
		{
			FanMultipleShoot("Knife_CallBack_Fire", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, item, CallBackTargetPositionY, CallBackTargetPosition - item, 0, AimType.Default, BulletDirectionType.BulletToTarget, 0, 0, 0);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
