using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class SimpleAPI_FengNiao : SkillSimpleBase
{
	protected IEnumerator FlashBeforeAttackForFengNiao(FP Radius = default(FP), FP InnerRadius = default(FP), FP UpRotation = default(FP), FP GoodShapeAngle = default(FP), FP MaxFlashDistance = default(FP), FP MinFlashDistance = default(FP), bool IsCombo = false)
	{
		ComboInputBuffer.ActionKey[] FlashFront_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._2 };
		ComboInputBuffer.ActionKey[] FlashBack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._3 };
		FP FlashSpeed = 80;
		int TryTimes = 0;
		TSVector2 ShapePosition = GetEntityPositionObsoleted(GetAttackTarget());
		TSVector2 FlashPosition = GetPosition();
		DeterministicShape GoodShape = GetShapeData(DeterministicShape.ShapeType.Fan, ShapePosition, default, default, Radius, InnerRadius, GoodShapeAngle, UpRotation);
		if (GetTargetsFromShape(GoodShape, null, includeSelf: true, _actor).Count != 0)
		{
			yield break;
		}
		while (TryTimes <= 20)
		{
			FlashPosition = GetShapeRandomPoint(GoodShape, _actor, isReachable: true);
			if (Distance(FlashPosition, ShapePosition) >= MinFlashDistance && Distance(FlashPosition, ShapePosition) <= MaxFlashDistance)
			{
				break;
			}
			TryTimes++;
			yield return null;
		}
		if (!(FlashPosition == ShapePosition))
		{
			ComboInputBuffer.ActionKey[] keys = ((!(AngleBetween2TSVector(GetForward(), FlashPosition - GetPosition(), signed: false) >= 90)) ? FlashFront_Combo : FlashBack_Combo);
			if (!IsCombo)
			{
				BeginAttack(99, keys, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			}
			SetCloseBlockEnable();
			BeginLookAt_NotWait(GetAttackTarget(), 999, 999);
			BeginDash(99, FlashPosition - GetPosition(), FlashSpeed, Distance(FlashPosition, GetPosition()), 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			StopWaitLookAt();
			if (!IsCombo)
			{
				CancelAttack();
			}
			SetCloseBlockDisable();
		}
	}

	protected IEnumerator FlashBeforeAttackForFengNiaoToFixedPosition(TSVector2 FixedPosition = default(TSVector2))
	{
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._2 };
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._3 };
		FP FlashSpeed = 50;
		ComboInputBuffer.ActionKey[] keys = ((!(AngleBetween2TSVector(GetForward(), FixedPosition - GetPosition(), signed: false) >= 90)) ? array : array2);
		BeginAttack(99, keys, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetCloseBlockEnable();
		BeginLookAt_NotWait(GetAttackTarget(), 999, 999);
		BeginDash(99, FixedPosition - GetPosition(), FlashSpeed, Distance(FixedPosition, GetPosition()), 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopWaitLookAt();
		CancelAttack();
		SetCloseBlockDisable();
	}

	protected IEnumerator SummonBeforeSkillForFengNiao(string SendSkillMessage)
	{
		List<TSVector2> TargetPointOffset = new List<TSVector2>
		{
			new TSVector2(0, 2),
			new TSVector2(1, 1.5),
			new TSVector2(-1, 1.5),
			new TSVector2(-1.6, 0.5),
			new TSVector2(1.6, 0.5),
			new TSVector2(-2, -0.5),
			new TSVector2(2, -0.5)
		};
		List<TSVector2> list = new List<TSVector2>();
		List<LogicEntity> targetByTeammateIndexes = GetTargetByTeammateIndexes(new List<int> { 1, 2 });
		int FlowerBirdCount = 0;
		foreach (LogicEntity item in targetByTeammateIndexes)
		{
			if (GetLogicTagToggleValue(item, "Awaken"))
			{
				FlowerBirdCount++;
				list.Add(GetEntityPositionObsoleted(item));
			}
		}
		if (list.Count > 0)
		{
			foreach (TSVector2 item2 in list)
			{
				SummonTeammate(3, TransLocalPosToWorldPos(item2, item2, new TSVector2(0, 2)), TSVector2.up);
			}
		}
		SummonTeammate(4, TransLocalPosToWorldPos(GetPosition(), GetForward(), TargetPointOffset.get_Item(0)), GetForward());
		while (GetTargetsByLogicTag(LogicTagType._Bool, "SpawnComplete", GetTargetByTeammateIndexes(new List<int> { 3, 4 })).Count < FlowerBirdCount + 1)
		{
			yield return null;
		}
		List<LogicEntity> FlowerBird = new List<LogicEntity>();
		FlowerBird.AddRange(GetTargetsByLogicTag(LogicTagType._Bool, "SpawnComplete", GetTargetByTeammateIndexes(new List<int> { 3, 4 })));
		int num = 0;
		foreach (LogicEntity item3 in FlowerBird)
		{
			if ((item3 as AdventureActor).dataID != GetTeammateIdByIndex(4))
			{
				TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), TargetPointOffset.get_Item(num));
				TSVector2 tSVector2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
				SetLogicTagFpValue(item3, "TargetPointX", tSVector.x);
				SetLogicTagFpValue(item3, "TargetPointY", tSVector.y);
				SetLogicTagFpValue(item3, "WatchPointX", tSVector2.x);
				SetLogicTagFpValue(item3, "WatchPointY", tSVector2.y);
			}
			SetLogicTagStringValue(item3, "SkillMessage", SendSkillMessage);
			SetLogicTagToggleValue(item3, "SummonComplete", value: true);
			num++;
		}
		int CheckCount = 0;
		while (CheckCount < FlowerBirdCount + 1)
		{
			CheckCount = 0;
			foreach (LogicEntity item4 in FlowerBird)
			{
				if (GetLogicTagToggleValue(item4, "SpawnComplete"))
				{
					CheckCount++;
				}
			}
			yield return null;
		}
	}

	protected void FlowerShootStart()
	{
		List<LogicEntity> targetByTeammateIndexes = GetTargetByTeammateIndexes(new List<int> { 1, 2 });
		bool flag = false;
		foreach (LogicEntity item in targetByTeammateIndexes)
		{
			if (GetLogicTagToggleValue(item, "Awaken") && !EntityInSkill(item))
			{
				SetLogicTagToggleValue(item, "Shoot", value: true);
				flag = true;
			}
		}
		if (flag)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = this;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = 155103;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected IEnumerator WanderActForFengNiao()
	{
		yield return BeginLookAtMonsterTarget(0.25, 999);
		yield return BeginLookAtMonsterTarget(2, 90);
	}
}
