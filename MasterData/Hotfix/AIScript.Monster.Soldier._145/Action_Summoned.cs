using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._145;

public class Action_Summoned : AIBase
{
	private static readonly FP durationTime = 3;

	private const int skillId_SummonSkill = 100014504;

	public const int summonedChessId = 100012;

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.RenDaoChuanCheng;

	private const int summonPercent = 100;

	private static readonly FP summonDistance = 4;

	private FP _durationTime;

	private bool _skillRequested;

	private bool _needDestroy;

	public void OnStart()
	{
		_durationTime = durationTime;
		_skillRequested = false;
		_needDestroy = false;
		_actor.EnableUnparalleled();
		_actor.EnableSearchedImmunity();
		_actor.EnableCloseBlock();
	}

	public void OnUpdate()
	{
		if (!_skillRequested)
		{
			_skillRequested = true;
			if (!ILRuntimeAPI.CreateSkill(100014504, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false))
			{
				_needDestroy = true;
			}
		}
		if (_needDestroy || _durationTime <= 0)
		{
			_actor.DestroySelf();
		}
		else
		{
			_durationTime -= _actor.LogicDeltaTime;
		}
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
		_actor.DisableSearchedImmunity();
		_actor.DisableCloseBlock();
		_durationTime = 0;
	}

	public static void TryPartnerSummon(AdventureActor caster)
	{
		if (caster is SoldierActor summoner && ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController && soldierLevelController.GetPartnerLv(HotfixEnum.ChessPartnerType.RenDaoChuanCheng) >= 1 && TSRandom.Range(0, 100) < 100 && TryGetSummonCenter(caster, summoner, soldierLevelController, out var center))
		{
			FP degrees = TSRandom.value * 360;
			TSVector2 result = center + TSVector2.Rotate(new TSVector2(0, 1), degrees) * summonDistance;
			if (caster.QueryPositionWalkable(result) || caster.QueryClosestPositionWalkable(result, out result))
			{
				TSVector2 tSVector = center - result;
				FP rotation = ((tSVector.LengthSquared() > 0) ? tSVector.GetAngle() : caster.tsTransform.Rotation);
				soldierLevelController.SpawnSoldierSummon(summoner, 100012, result, rotation);
			}
		}
	}

	private static bool TryGetSummonCenter(AdventureActor caster, SoldierActor summoner, SoldierLevelController levelController, out TSVector2 center)
	{
		LogicEntity attackTarget = caster.attackTarget;
		if (attackTarget != null && !attackTarget.IsDead())
		{
			center = attackTarget.tsTransform.Position;
			return true;
		}
		if (summoner.isSupport && summoner.onStageType == HotfixEnum.ChessAssistOnStageType.NotAppearing)
		{
			SoldierActor mainControlActor = levelController.GetMainControlActor(summoner.isEnemyCamp);
			if (mainControlActor == null)
			{
				center = default;
				return false;
			}
			center = mainControlActor.tsTransform.Position;
			return true;
		}
		center = caster.tsTransform.Position;
		return true;
	}
}
