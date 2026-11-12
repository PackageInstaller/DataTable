#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._141;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "ComboSupport";

	private readonly FP loopDuration = 2;

	private readonly string eventName_Summon = "Summon";

	private readonly string bulletKey_Summon = "Bullet_Soldier_14101_Support_Skill";

	private readonly TSVector2 shootOffset = new TSVector2(0, 2);

	private readonly FP shootPositionY = 2;

	private readonly FP randomRadius = 4;

	public static readonly int summonedChessId = 100004;

	private readonly int summonCount_Base = 1;

	private readonly int summonCount_Potential2 = 2;

	private readonly FP ringInnerRadius = 4;

	private readonly FP ringOuterRadius = 8;

	private readonly FP minSummonDistance = 3;

	private readonly int maxPickTry = 8;

	private readonly FP sectorFillRatio = 0.5;

	private readonly HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private readonly int summonMultiplier_Partner = 2;

	private readonly int[] buffId_ExtraSummon_Partner = new int[3] { 1164209769, 1701603169, 7562030 };

	private bool _beginLoop;

	private FP _loopDuration;

	private readonly List<TSVector2> _pickedPositions = new List<TSVector2>();

	private readonly List<TSVector2> _occupiedPositions = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_beginLoop = false;
		_loopDuration = 0;
		_pickedPositions.Clear();
		_occupiedPositions.Clear();
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Summon))
		{
			DoSummonLogic();
		}
	}

	private void OnAnticipationEnd()
	{
		_loopDuration = loopDuration;
		_beginLoop = true;
	}

	public void OnUpdate()
	{
		if (_beginLoop)
		{
			if (_loopDuration > 0)
			{
				_loopDuration -= _actor.LogicDeltaTime;
				return;
			}
			_beginLoop = false;
			comboAttack.CancelAttack();
		}
	}

	private void DoSummonLogic()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		TSVector2 position = _actor.tsTransform.Position;
		if (attackTarget != null)
		{
			TSVector2 normalized = (attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			FP fP = TSVector2.Distance(_actor.tsTransform.Position, attackTarget.tsTransform.Position);
			position += fP * normalized / 2;
		}
		int num = ((((SoldierActor)_actor).GetPotentialLv() >= 2) ? summonCount_Potential2 : summonCount_Base);
		int partnerLv = GetPartnerLv();
		int num2 = ((partnerLv >= 1) ? (num * summonMultiplier_Partner) : num);
		int extraSummonBuffId = GetExtraSummonBuffId(partnerLv);
		CollectOccupiedPositions();
		for (int i = 0; i < num2; i++)
		{
			TSVector2 position2 = PickSummonPosition(position, i, num2);
			SoldierActor soldierActor = SpawnSummon(attackTarget, position2);
			if (!(soldierActor == null))
			{
				TSVector2 position3 = soldierActor.tsTransform.Position;
				_pickedPositions.Add(position3);
				ShootSummonBullet(position3);
				if (i >= num && extraSummonBuffId > 0)
				{
					AddExtraSummonBuff(soldierActor, extraSummonBuffId);
				}
			}
		}
	}

	private void CollectOccupiedPositions()
	{
		_occupiedPositions.Clear();
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		List<SoldierLevelController.SoldierSummonData> soldierSummonInfos = soldierLevelController.GetSoldierSummonInfos();
		for (int i = 0; i < soldierSummonInfos.Count; i++)
		{
			SoldierLevelController.SoldierSummonData soldierSummonData = soldierSummonInfos.get_Item(i);
			if (soldierSummonData == null || !soldierSummonData.isAlive || soldierSummonData.summonerId != _actor.Id || soldierSummonData.dataID != summonedChessId)
			{
				continue;
			}
			SoldierActor summoned = soldierSummonData.summoned;
			if (!(summoned == null) && summoned.Id == soldierSummonData.entityId)
			{
				ActorHealthInfo actorHealthInfo = summoned.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive)
				{
					_occupiedPositions.Add(summoned.tsTransform.Position);
				}
			}
		}
	}

	private TSVector2 PickSummonPosition(TSVector2 center, int index, int totalCount)
	{
		TSVector2 result = center;
		bool flag = false;
		for (int i = 0; i < maxPickTry; i++)
		{
			TSVector2 position = ((index == 0) ? ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(randomRadius, 0, center)) : PickSectorPoint(center, index, totalCount, i));
			if (index == 0 && position == center)
			{
				break;
			}
			if (TryMakeWalkable(ref position))
			{
				if (!flag)
				{
					result = position;
					flag = true;
				}
				if (IsPositionFree(position))
				{
					return position;
				}
			}
		}
		if (!flag)
		{
			return center;
		}
		return result;
	}

	private TSVector2 PickSectorPoint(TSVector2 center, int index, int totalCount, int tryIndex)
	{
		int num = ((totalCount <= 1) ? 1 : (totalCount - 1));
		FP fP = (FP)360 / (FP)num;
		FP fP2 = fP * (1 - sectorFillRatio) / 2;
		FP degrees = fP * (index - 1) + fP2 + TSRandom.value * fP * sectorFillRatio;
		FP fP3 = ((maxPickTry > 1) ? ((FP)tryIndex / (FP)(maxPickTry - 1)) : ((FP)0));
		FP fP4 = ringOuterRadius - (ringOuterRadius - ringInnerRadius) * fP3;
		return center + TSVector2.Rotate(TSVector2.up, degrees) * fP4;
	}

	private bool TryMakeWalkable(ref TSVector2 position)
	{
		if (!_actor.QueryPositionWalkable(position))
		{
			return _actor.QueryClosestPositionWalkable(position, out position);
		}
		return true;
	}

	private bool IsPositionFree(TSVector2 position)
	{
		for (int i = 0; i < _pickedPositions.Count; i++)
		{
			if (TSVector2.Distance(position, _pickedPositions.get_Item(i)) < minSummonDistance)
			{
				return false;
			}
		}
		for (int j = 0; j < _occupiedPositions.Count; j++)
		{
			if (TSVector2.Distance(position, _occupiedPositions.get_Item(j)) < minSummonDistance)
			{
				return false;
			}
		}
		return true;
	}

	private void AddExtraSummonBuff(SoldierActor summon, int buffId)
	{
		if (!(summon.buffComponent == null) && summon.buffComponent.AddBuff(buffId, _actor) == null)
		{
			NovaLogger.Error($"141 支援技能：羁绊新增召唤物的 buff {buffId} 添加失败。" + "常见原因：①该 buff 配了\"减益(DeBuff)\"标签，而召唤物处于无双(Unparalleled)状态会被 CheckBuff 拒绝，应改配\"增益\"标签；②Buff/BuffValue 配表查不到该 id；③与已有 buff 的 GroupId/Sort 互斥。");
		}
	}

	private void ShootSummonBullet(TSVector2 targetPosition)
	{
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.y;
		ILRuntimeAPI.Shoot(bulletKey_Summon, _actor, default, position, shootPositionY, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}

	private SoldierActor SpawnSummon(LogicEntity target, TSVector2 position)
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return null;
		}
		if (!_actor.QueryPositionWalkable(position))
		{
			_actor.QueryClosestPositionWalkable(position, out position);
		}
		TSVector2 normalized = ((target != null) ? (target.tsTransform.Position - _actor.tsTransform.Position) : _actor.tsTransform.Forward).normalized;
		return soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, position, normalized.GetAngle());
	}

	private int GetPartnerLv()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(partnerType);
	}

	private int GetExtraSummonBuffId(int partnerLv)
	{
		if (partnerLv < 1 || buffId_ExtraSummon_Partner.Length == 0)
		{
			return 0;
		}
		int num = partnerLv - 1;
		if (num >= buffId_ExtraSummon_Partner.Length)
		{
			num = buffId_ExtraSummon_Partner.Length - 1;
		}
		return buffId_ExtraSummon_Partner[num];
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_beginLoop = false;
		_loopDuration = 0;
		_pickedPositions.Clear();
		_occupiedPositions.Clear();
	}
}
