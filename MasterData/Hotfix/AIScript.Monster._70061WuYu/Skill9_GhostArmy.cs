using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill9_GhostArmy : SkillSimpleBase
{
	private const string ComboKey = "Skill9_1_GhostArmy";

	private const string ComboKeyEnd1 = "Skill9_1_GhostArmy_End1";

	private const string ComboKeyEnd2 = "Skill9_1_GhostArmy_End1";

	private static readonly FP EdgeDashSpeed = 40;

	private static readonly FP EdgeFarProbe = 80;

	private static readonly FP SpiralDashSpeed = 20;

	private static readonly FP SpiralMaxDistance = 999;

	private static readonly FP SpiralTangentAngle = 80.5;

	private const int SpiralDirection = 1;

	private static readonly FP SpiralConvergeRadius = 4;

	private static readonly FP SpiralTangentAngle_Near = 25;

	private static readonly FP SpiralStopRadius = 2.5;

	private static readonly FP ExplodeIntervalDist = 8;

	private static readonly FP ExplodeFrontOffset = 2;

	private static readonly FP ExplodeFrontAngle = 45;

	private static readonly FP ExplodeLandDist = 2;

	public const string ExplodeBulletAlias = "Weapon_70061WuYu_Skill1_Bullet";

	private static readonly FP ExplodeBulletHeight = 0.5;

	private static readonly FP BigHeadIntervalDist = 4.5;

	private static readonly FP BigHeadBehindOffset = 1;

	private const string BigHeadCircleAlias = "AreaEffect_70061WuYu_Skill9_BigHeadGhostAttackAct";

	private const string BigHeadCircleAlias_A = "AreaEffect_70061WuYu_Skill9_BigHeadGhostSummonAct";

	public static readonly int BigHeadCircleAInterval = 4;

	private static readonly FP WarlockLingerIntervalDist = 2;

	private static readonly FP WarlockSummonIntervalDist = 20;

	private static readonly FP WarlockLingerBehindOffset = 0;

	public const string WarlockLingerAlias = "Weapon_70061WuYu_MageGhost_Skill1_MageAttack";

	public const string WarlockLingerMarkFxAlias = "fx_m70061_bullet_MageGhost_Atk01";

	public static readonly FP WarlockLingerShotInterval = 0.1;

	public static readonly FP LingerHeight = 0.5;

	public const string Skill9BigHeadAreaEventName = "WuYu_Skill9_RegisterBigHeadArea";

	public const string Skill9CenterReachedEventName = "WuYu_Skill9_CenterReached";

	public const string Skill9LingerMarkEventName = "WuYu_Skill9_RegisterLingerMark";

	public const string Skill9CleanupEventName = "WuYu_Skill9_Cleanup";

	public const string ExplodeBulletTag = "Weapon_70061WuYu_Skill9_ExplodeBulletTag";

	private int _summonTeammateId;

	private CoroutineNode _summonCoroutine;

	private CoroutineNode _spiralCoroutine;

	private bool _completed;

	private TSVector2 _lastFramePos;

	private FP _moveAccumDist;

	private FP _warlockLingerAccum;

	private FP _warlockSummonAccum;

	private int _bigHeadCircleCount;

	private int _warlockSummonCount;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (GetLogicTagToggleValue(_actor, "SummonBoostBigHeadTagId"))
		{
			_summonTeammateId = 2;
		}
		else if (GetLogicTagToggleValue(_actor, "SummonBoostWarlockTagId"))
		{
			_summonTeammateId = 3;
		}
		else
		{
			_summonTeammateId = 1;
		}
		_completed = false;
		_lastFramePos = GetPosition();
		_moveAccumDist = FP.Zero;
		_warlockLingerAccum = FP.Zero;
		_warlockSummonAccum = FP.Zero;
		_bigHeadCircleCount = 0;
	}

	protected override void OnSkillDisable()
	{
		StopCor(_summonCoroutine);
		StopCor(_spiralCoroutine);
		StopWaitLookAt();
		StopDash();
		if (!_completed)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventName = "WuYu_Skill9_Cleanup";
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Skill9_1_GhostArmy", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		FaceToEdge();
		FP distance = Distance(GetPosition(), GetArenaEdgeAlongForward());
		BeginDashActorForward(1, EdgeDashSpeed, distance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
		yield return WaitDashFinish();
		StartCor(ref _summonCoroutine, GetAlongwaySummonEnumerator());
		TSVector2 tSVector = GetPlaceHolderPosition("CenterPoint") - GetPosition();
		TSVector2 tSVector2 = ((tSVector.magnitude > FP.Zero) ? tSVector.normalized : GetForward());
		FP value = SpiralTangentAngle * FP.Deg2Rad;
		TSVector2 normalized = (tSVector2 * TSMath.Cos(value) + RotateTo(tSVector2, 90).normalized * TSMath.Sin(value)).normalized;
		Dash spiral = BeginDash(2, normalized, SpiralDashSpeed, SpiralMaxDistance, 999, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
		StartCor(ref _spiralCoroutine, SpiralSteer(spiral));
		yield return WaitDashFinish();
		StopCor(_summonCoroutine);
		_summonCoroutine = null;
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventName = "WuYu_Skill9_CenterReached";
		adventureActorCustomEvent.intParam = _summonTeammateId;
		_actor.DispatchEvent(adventureActorCustomEvent);
		CancelAttack();
		BeginAttack(0, (TSRandom.Range(0, 2) == 0) ? "Skill9_1_GhostArmy_End1" : "Skill9_1_GhostArmy_End1", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_completed = true;
	}

	private void FaceToEdge()
	{
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("CenterPoint");
		TSVector2 tSVector = GetPosition() - placeHolderPosition;
		TSVector2 tSVector2 = ((tSVector.magnitude > FP.Zero) ? tSVector.normalized : GetForward());
		BeginLookAtByPos_NotWait(GetPosition() + tSVector2, 0.1);
	}

	private TSVector2 GetArenaEdgeAlongForward()
	{
		TSVector2 position = GetPosition();
		TSVector2 tSVector = position + GetForward() * EdgeFarProbe;
		AdventureActor actor = _actor;
		if ((object)actor != null && !actor.QueryPositionWalkable(tSVector) && actor.LinecastNavmeshGraph(position, tSVector, out var linecastHitPoint))
		{
			return linecastHitPoint;
		}
		return tSVector;
	}

	private IEnumerator SpiralSteer(Dash spiral)
	{
		while (true)
		{
			TSVector2 tSVector = GetPlaceHolderPosition("CenterPoint") - GetPosition();
			FP magnitude = tSVector.magnitude;
			if (magnitude <= SpiralStopRadius)
			{
				break;
			}
			TSVector2 direction;
			if (magnitude < FP.Epsilon)
			{
				direction = GetForward();
			}
			else
			{
				FP value = ((magnitude <= SpiralConvergeRadius) ? SpiralTangentAngle_Near : SpiralTangentAngle) * FP.Deg2Rad;
				FP fP = TSMath.Cos(value);
				FP fP2 = TSMath.Sin(value);
				TSVector2 tSVector2 = tSVector / magnitude;
				TSVector2 normalized = RotateTo(tSVector2, 90).normalized;
				direction = (tSVector2 * fP + normalized * fP2).normalized;
			}
			spiral._direction = direction;
			yield return WaitFrame(1);
		}
		StopDash();
	}

	private IEnumerator GetAlongwaySummonEnumerator()
	{
		_lastFramePos = GetPosition();
		_warlockLingerAccum = WarlockLingerIntervalDist;
		_warlockSummonAccum = WarlockSummonIntervalDist;
		if (_summonTeammateId == 1)
		{
			_moveAccumDist = ExplodeIntervalDist;
			return RunExplodeSummon();
		}
		if (_summonTeammateId == 2)
		{
			_moveAccumDist = BigHeadIntervalDist;
			return RunBigHeadSummon();
		}
		return RunWarlockSummon();
	}

	private bool AccumulateMove(ref FP accum, FP threshold)
	{
		TSVector2 position = GetPosition();
		accum += Distance(_lastFramePos, position);
		_lastFramePos = position;
		if (accum < threshold)
		{
			return false;
		}
		accum = FP.Zero;
		return true;
	}

	private IEnumerator RunExplodeSummon()
	{
		while (true)
		{
			yield return null;
			if (AccumulateMove(ref _moveAccumDist, ExplodeIntervalDist))
			{
				ThrowExplodeBullets();
			}
		}
	}

	private void ThrowExplodeBullets()
	{
		TSVector2 forward = GetForward();
		TSVector2 tSVector = GetPosition() + forward * ExplodeFrontOffset;
		TSVector2 normalized = RotateTo(forward, -ExplodeFrontAngle).normalized;
		TSVector2 targetPosition = tSVector + normalized * ExplodeLandDist;
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Weapon_70061WuYu_Skill1_Bullet", _actor, default, tSVector, ExplodeBulletHeight, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		if (!(adventureBulletBase == null))
		{
			adventureBulletBase.ModifyBulletTag("Weapon_70061WuYu_Skill9_ExplodeBulletTag");
		}
	}

	private IEnumerator RunBigHeadSummon()
	{
		while (true)
		{
			yield return null;
			if (AccumulateMove(ref _moveAccumDist, BigHeadIntervalDist))
			{
				LayBigHeadCircle();
			}
		}
	}

	private void LayBigHeadCircle()
	{
		_bigHeadCircleCount++;
		bool flag = _bigHeadCircleCount >= BigHeadCircleAInterval;
		if (flag)
		{
			_bigHeadCircleCount = 0;
		}
		TSVector2 position = GetPosition() - GetForward() * BigHeadBehindOffset;
		long num = PlayAreaEffect(flag ? "AreaEffect_70061WuYu_Skill9_BigHeadGhostSummonAct" : "AreaEffect_70061WuYu_Skill9_BigHeadGhostAttackAct", position);
		if (num > 0 && flag)
		{
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(num);
			if (!(areaEffect == null))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.eventName = "WuYu_Skill9_RegisterBigHeadArea";
				adventureActorCustomEvent.target = areaEffect;
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
	}

	private IEnumerator RunWarlockSummon()
	{
		while (true)
		{
			yield return null;
			TSVector2 position = GetPosition();
			FP fP = Distance(_lastFramePos, position);
			_lastFramePos = position;
			_warlockLingerAccum += fP;
			if (_warlockLingerAccum >= WarlockLingerIntervalDist)
			{
				PlaceLingerMark(position);
				_warlockLingerAccum = FP.Zero;
			}
			_warlockSummonAccum += fP;
			if (_warlockSummonAccum >= WarlockSummonIntervalDist)
			{
				_warlockSummonCount = (_warlockSummonCount + 1) % 2;
				int index = ((_warlockSummonCount == 1) ? _summonTeammateId : 5);
				LogicEntity currentPlayer = GetCurrentPlayer();
				TSVector2 tSVector = ((currentPlayer != null) ? (currentPlayer.tsTransform.Position - position) : GetForward());
				SummonTeammate(index, position, (tSVector.magnitude > FP.Zero) ? tSVector.normalized : GetForward());
				_warlockSummonAccum = FP.Zero;
			}
		}
	}

	private void PlaceLingerMark(TSVector2 pos)
	{
		TSVector2 item = pos - GetForward() * WarlockLingerBehindOffset;
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventName = "WuYu_Skill9_RegisterLingerMark";
		if (adventureActorCustomEvent.tsVector2ParamList == null)
		{
			adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2>();
		}
		adventureActorCustomEvent.tsVector2ParamList.Add(item);
		_actor.DispatchEvent(adventureActorCustomEvent);
	}
}
