#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Action : MonsterActionBase
{
	private const int SkillConfront_Id = 5017104;

	private const int SkillMove_Id = 5017102;

	private const int SkillDash_Id = 5017103;

	private const int SkillNormalAttack_Id = 5017101;

	private const int SkillIce_Id = 5017105;

	private const int SkillWait_Id = 5017106;

	private FP distance_Near_1 = 6;

	private FP distance_Near_2 = 5;

	private FP distance_Far_1 = 5;

	private FP distance_Far_2 = 8;

	private FP distance_attack = 5;

	private FP angle_attack = 90;

	private FP sceneRange = 10;

	private FP radius_w_1 = 13;

	private FP radius_n_1 = 10;

	private FP angle_1 = 60;

	private FP radius_w_2 = 10;

	private FP radius_n_2 = 8;

	private FP angle_2 = 30;

	private FP angle_offset = 90;

	private FP radius_w_3 = 10;

	private FP radius_n_3 = 8;

	private FP angle_3 = 60;

	private int Skill_Test;

	private bool isOdd;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		isOdd = true;
		SetLogicTagToggleValue(_actor, "OddNumer", isOdd);
		SetLogicTagToggleValue(_actor, "paidi", value: false);
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = OnCloseTo;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = OnAttack;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = OnStayAway;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = OnIceAction;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1002, 1003, 1004 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
	}

	protected override void SetListenEvents()
	{
	}

	private void ToWait()
	{
		GotoCastSkill(5017106);
	}

	private LogicEntity GetTarget()
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (CheckTargetIsValid(attackTarget))
		{
			return attackTarget;
		}
		return SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
	}

	private IEnumerator OnCloseTo()
	{
		NovaLogger.Debug("冰箱怪.Action.靠近流程");
		LogicEntity _target = GetTarget();
		if (_target == null)
		{
			yield break;
		}
		isOdd = GetLogicTagToggleValue(_actor, "OddNumer");
		SetLogicTagToggleValue(_actor, "OddNumer", !isOdd);
		SetLogicTagFpValue(_actor, "state", 0);
		FP distance = _actor.DistanceWithRadius(_target);
		if (!isOdd && _target is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorInfo.attackType == HotfixEnum.characterAttackType.RANGED && distance > distance_Near_1)
		{
			GotoCastSkill(5017103);
			yield return WaitSkillFinish();
		}
		else if (distance > distance_Near_2)
		{
			if (distance > distance_Near_1)
			{
				GotoCastSkill(5017102);
			}
			else if (isLeftOrRight(_target, _actor))
			{
				GotoCastSkill(5017101);
				yield return WaitSkillFinish();
				if (_actor.DistanceWithRadius(_target) > distance_Near_2 && distance < distance_Near_1)
				{
					if (isLeftOrRight(_target, _actor))
					{
						yield break;
					}
					GotoCastSkill(5017102);
				}
			}
			else
			{
				GotoCastSkill(5017102);
			}
			yield return WaitSkillFinish();
		}
		ToWait();
		yield return WaitSkillFinish();
	}

	private IEnumerator OnAttack()
	{
		NovaLogger.Debug("冰箱怪.Action.攻击流程");
		SetLogicTagFpValue(_actor, "state", 1);
		LogicEntity _target = GetTarget();
		if (_target == null)
		{
			yield break;
		}
		bool logicTagToggleValue = GetLogicTagToggleValue(_actor, "paidi");
		FP fP = _actor.DistanceWithRadius(_target);
		if (logicTagToggleValue || fP > distance_attack)
		{
			SetLogicTagToggleValue(_actor, "paidi", value: false);
			if (!isForward(_target, _actor))
			{
				GotoCastSkill(5017101);
				yield return WaitSkillFinish();
			}
			if (isForward(_target, _actor))
			{
				GotoCastSkill(5017103);
				yield return WaitSkillFinish();
			}
		}
		else
		{
			SetLogicTagToggleValue(_actor, "paidi", value: true);
			GotoCastSkill(5017101);
			yield return WaitSkillFinish();
		}
		ToWait();
		yield return WaitSkillFinish();
	}

	private DeterministicShape GetShape(FP radius_w, FP radius_n, FP _angle, FP _rotation)
	{
		return new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Fan,
			position = _actor.tsTransform.Position,
			angle = _angle,
			rotation = _rotation,
			innerRadius = radius_n,
			radius = radius_w
		};
	}

	private IEnumerator OnStayAway()
	{
		NovaLogger.Debug("冰箱怪.Action.远离流程");
		SetLogicTagFpValue(_actor, "state", 2);
		LogicEntity _target = GetTarget();
		if (_target == null)
		{
			yield break;
		}
		FP distance = _actor.DistanceWithRadius(_target);
		if (distance < distance_Far_2)
		{
			FP fP = TSVector2.Distance(TSVector2.zero, _actor.tsTransform.Position);
			Parallel_1.toPos = true;
			Parallel_1.safemove = false;
			if (fP > sceneRange)
			{
				FP angle = (TSVector2.zero - _actor.tsTransform.Position).normalized.GetAngle();
				DeterministicShape shape = GetShape(radius_w_1, radius_n_1, angle_1, angle);
				Parallel_1.targetPos = _actor.RandomActorReachablePointInsideShape(shape);
				NovaLogger.Debug($"冰箱怪.Action.远离流程.目标点坐标{Parallel_1.targetPos}");
			}
			else
			{
				Parallel_1.safemove = true;
				if (isForward(_target, _actor))
				{
					FP angle2 = (target.tsTransform.Position - _actor.tsTransform.Position).normalized.GetAngle();
					angle2 = ((TSRandom.Range(0, 100) > 50) ? (angle2 + angle_offset) : (angle2 - angle_offset));
					DeterministicShape shape2 = GetShape(radius_w_2, radius_n_2, angle_2, angle2);
					Parallel_1.targetPos = _actor.RandomActorReachablePointInsideShape(shape2);
					NovaLogger.Debug($"冰箱怪.Action.远离流程.目标点坐标{Parallel_1.targetPos}");
				}
				else
				{
					DeterministicShape shape3 = GetShape(radius_w_3, radius_n_3, angle_3, _actor.tsTransform.Rotation);
					Parallel_1.targetPos = _actor.RandomActorReachablePointInsideShape(shape3);
					NovaLogger.Debug($"冰箱怪.Action.远离流程.目标点坐标{Parallel_1.targetPos}");
				}
			}
			if (!isForward(_actor, Parallel_1.targetPos))
			{
				Parallel_1.toRot = true;
				GotoCastSkill(5017101);
				yield return WaitSkillFinish();
			}
			GotoCastSkill(5017102);
			yield return WaitSkillFinish();
		}
		if (!isOdd && _target is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorInfo.attackType == HotfixEnum.characterAttackType.MELEE && distance < distance_Far_1)
		{
			GotoCastSkill(5017104);
			yield return WaitSkillFinish();
			GotoCastSkill(5017103);
			yield return WaitSkillFinish();
		}
		ToWait();
		yield return WaitSkillFinish();
	}

	private IEnumerator OnIceAction()
	{
		SetLogicTagFpValue(_actor, "state", 3);
		GotoCastSkill(5017105);
		yield return WaitSkillFinish();
		ToWait();
		yield return WaitSkillFinish();
	}

	private bool isLeftOrRight(LogicEntity player, LogicEntity monster)
	{
		TSVector2 normalized = monster.tsTransform.Forward.normalized;
		TSVector2 normalized2 = (player.tsTransform.Position - monster.tsTransform.Position).normalized;
		FP fP = TSVector2.Angle(normalized, normalized2);
		if (fP < 315 && fP > 225)
		{
			return true;
		}
		if (fP < 135 && fP > 45)
		{
			return true;
		}
		return false;
	}

	private bool isForward(LogicEntity player, LogicEntity monster)
	{
		TSVector2 normalized = monster.tsTransform.Forward.normalized;
		TSVector2 normalized2 = (player.tsTransform.Position - monster.tsTransform.Position).normalized;
		FP fP = TSVector2.Angle(normalized, normalized2);
		FP fP2 = angle_attack / 2;
		FP fP3 = 360 - fP2;
		if (fP >= fP3 || fP <= fP2)
		{
			return true;
		}
		return false;
	}

	private bool isForward(LogicEntity monster, TSVector2 pos)
	{
		TSVector2 normalized = monster.tsTransform.Forward.normalized;
		TSVector2 normalized2 = (pos - monster.tsTransform.Position).normalized;
		FP fP = TSVector2.Angle(normalized, normalized2);
		FP fP2 = angle_attack / 2;
		FP fP3 = 360 - fP2;
		if (fP >= fP3 || fP <= fP2)
		{
			return true;
		}
		return false;
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
	}
}
