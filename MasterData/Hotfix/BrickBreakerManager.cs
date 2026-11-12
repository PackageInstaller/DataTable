#define LOG_ERROR
using System;
using System.Collections.Generic;
using AdventureBehaviour;
using PathologicalGames;
using TrueSync;
using UnityEngine;

public class BrickBreakerManager : Singleton<BrickBreakerManager>
{
	private readonly List<FP> rangeLs = new List<FP>(4);

	private AdventureFXPlayer currentKeepFx;

	private readonly List<Brick_Ball> energyBalls = new List<Brick_Ball>();

	private Transform ballPrefab;

	private bool _pendingSplitBall;

	private bool _pendingResetToPaddle;

	private bool _pendingResetInit;

	public FP paddle_FramBeginPosX;

	public FP ballPauseTime;

	public bool actorInv;

	private readonly List<Brick_BallBase> ballsToDestroy = new List<Brick_BallBase>();

	private readonly List<Brick_BallBase> poleSpawnedBalls = new List<Brick_BallBase>();

	private const int MAX_SPAWNED_BALLS = 9;

	private readonly List<Brick_BallBase> _allBallsBuf = new List<Brick_BallBase>();

	private TSVector2 orgMinzPos;

	private TSVector2 invStarMinzPos;

	private bool needSkillUseTip;

	private DeterministicCollider minDeter;

	private const int MAX_SPLIT_BALLS = 9;

	private int Split_num;

	private FP Split_angle;

	private FP Split_rot;

	private FP SplitDistance;

	private GameObject SplitFx;

	private readonly List<DeterministicCollider> hitColliders = new List<DeterministicCollider>();

	private int _bornImmuneCount;

	private string _bornImmuneFxName;

	public const int Event_BallCaughtByPaddle = 157010001;

	private readonly FP BUBBLE_RADIUS = 5.7;

	private readonly FP BUBBLE_INNER_REFLECT_ANGLE_OFFSET = 5;

	private readonly string BUBBLE_FX = "FX/BreakOut/fx_breakout_16001_loop_start_bubble_big";

	private TSVector2 bubbleCenter;

	private FP bubbleTimer;

	private AdventureFXPlayer bubbleFx;

	private TSVector2 huntingChainPos;

	private FP huntingChainTimer;

	private AdventureFXPlayer huntingChainFx;

	private PlayFX _huntingChainPlayFx;

	public GameObject boomFx;

	public int boomRange;

	public int boomId;

	public bool boomClear;

	private float boomFxScale;

	private int exceptDropScro;

	public bool InvincibleStar;

	private FP invaTime;

	public FP disableTime;

	private GameObject disableFx;

	private AdventureFXPlayer invincibleFx;

	private AdventureFXPlayer roleInvincibleFx;

	public bool invstarOnDisable;

	private readonly FP invstar_up_colliderY = 2.2;

	private FP portalTractionTime;

	private GameObject laserAreaHorizontal;

	private GameObject laserAreaVertical;

	private GameObject laserAreaLightning;

	private bool _crossEatLightning;

	private bool _lightningHEatVertical;

	private bool _lightningVEatHorizontal;

	private readonly Dictionary<long, (GameObject a, GameObject b)> _chainFollowUps = new Dictionary<long, (GameObject, GameObject)>();

	private readonly HashSet<(long areaId, long targetId)> _chainHitted = new HashSet<(long, long)>();

	private bool _chainListening;

	private readonly Dictionary<Brick_BallBase, List<Gear_BlackHole>> _ballBlackHoleMap = new Dictionary<Brick_BallBase, List<Gear_BlackHole>>(BrickBallRefComparer.Instance);

	private readonly Dictionary<Brick_BallBase, List<Portal_End>> _ballPortalTractionMap = new Dictionary<Brick_BallBase, List<Portal_End>>(BrickBallRefComparer.Instance);

	private readonly Dictionary<Brick_BallBase, FP> _ballSpeedBandMap = new Dictionary<Brick_BallBase, FP>(BrickBallRefComparer.Instance);

	private readonly Dictionary<Brick_BallBase, List<Gear_BouncePole>> _ballBouncePoleMap = new Dictionary<Brick_BallBase, List<Gear_BouncePole>>(BrickBallRefComparer.Instance);

	private List<GearBase> _gearList = new List<GearBase>(8);

	public Brick_Paddle Paddle { get; private set; }

	public Brick_Ball BrickBall { get; private set; }

	public PaddleCollider CurrentPaddleCollider { get; private set; }

	public BrickActor Actor { get; private set; }

	public bool IsLaunched { get; private set; }

	public bool InBornCD { get; private set; }

	public bool HasBubble { get; private set; }

	public bool HasHuntingChain { get; private set; }

	public TSVector2 HuntingChainPos => huntingChainPos;

	public bool PortalTractionActive { get; private set; }

	public bool HasPortalTraction => PortalTractionActive;

	public void OnUpdate(FP deltaTime)
	{
		if (ballsToDestroy.Count > 0)
		{
			for (int num = ballsToDestroy.Count - 1; num >= 0; num--)
			{
				UnityEngine.Object.Destroy(ballsToDestroy.get_Item(num).gameObject);
			}
			ballsToDestroy.Clear();
		}
		Paddle?.OnLogicUpdate(deltaTime);
		ballPauseTime -= deltaTime;
		if (ballPauseTime < 0)
		{
			for (int num2 = energyBalls.Count - 1; num2 >= 0; num2--)
			{
				if (!(energyBalls.get_Item(num2) == null))
				{
					energyBalls.get_Item(num2).OnLogicUpdate(deltaTime);
				}
			}
		}
		for (int num3 = poleSpawnedBalls.Count - 1; num3 >= 0; num3--)
		{
			if (!(poleSpawnedBalls.get_Item(num3) == null))
			{
				poleSpawnedBalls.get_Item(num3).OnLogicUpdate(deltaTime);
			}
		}
		OnUpdate_Drop(deltaTime);
		OnUpdate_Bubble(deltaTime);
		OnUpdate_HuntingChain(deltaTime);
		InviStarSetMinCollierUp();
	}

	public TSVector2 GetPalldeFixReflect(FP posx)
	{
		if (posx > paddle_FramBeginPosX)
		{
			return new TSVector2(1, 1);
		}
		return new TSVector2(-1, 1);
	}

	public void InitPaddle(Brick_Paddle paddle)
	{
		Paddle = paddle;
		TryFlushPendingResetToPaddle();
	}

	private void TryFlushPendingResetToPaddle()
	{
		if (_pendingResetToPaddle && !(Paddle == null) && !(BrickBall == null) && !(CurrentPaddleCollider == null))
		{
			_pendingResetToPaddle = false;
			ResetBalltoPaddle(_pendingResetInit);
		}
	}

	public void InitBall(Brick_Ball ball, ref bool iSplit)
	{
		if (BrickBall == ball)
		{
			iSplit = false;
			return;
		}
		iSplit = true;
		AddBall(ball);
		if (BrickBall == null)
		{
			iSplit = false;
			BrickBall = ball;
			ballPrefab = ball.transform;
			TryFlushPendingResetToPaddle();
		}
	}

	public List<Brick_Ball> GetEnergyBalls()
	{
		return energyBalls;
	}

	public List<Brick_BallBase> GetPoleSpawnedBalls()
	{
		return poleSpawnedBalls;
	}

	public void AddSpawnedBall(Brick_BallBase ball)
	{
		if (ball != null && !poleSpawnedBalls.Contains(ball))
		{
			poleSpawnedBalls.Add(ball);
		}
	}

	public void RemoveSpawnedBall(Brick_BallBase ball)
	{
		if (!(ball == null))
		{
			poleSpawnedBalls.Remove(ball);
			if (ball.gameObject != null)
			{
				ball.ActiveSelf = false;
				ballsToDestroy.Add(ball);
			}
		}
	}

	public List<Brick_BallBase> GetAllBalls()
	{
		_allBallsBuf.Clear();
		for (int i = 0; i < energyBalls.Count; i++)
		{
			_allBallsBuf.Add(energyBalls.get_Item(i));
		}
		_allBallsBuf.AddRange(poleSpawnedBalls);
		return _allBallsBuf;
	}

	public void SpawnBallFromBouncePole(Gear_BouncePole pole, TSVector2 pos, TSVector2 dir, Brick_BallBase source)
	{
		if (!(pole == null) && pole.EnableSpawn && !(pole.SpawnBallPrefab == null) && poleSpawnedBalls.Count < 9)
		{
			float y = source.transform.position.y;
			GameObject gameObject = UnityEngine.Object.Instantiate(pole.SpawnBallPrefab, new Vector3((float)pos.x, y, (float)pos.y), Quaternion.identity);
			if (!gameObject.TryGetComponent<Brick_SpawnBall>(out var component))
			{
				NovaLogger.Error("SpawnBallFromBouncePole: 预制体缺少 Brick_SpawnBall 组件,销毁游离对象");
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			TSVector2 spawnDirection = pole.GetSpawnDirection(dir);
			component.SetMoveDirection(spawnDirection);
			component.SetChSpeed(0);
			component.SetLaunchedState(launched: true);
			component.Active();
			component.ApplyHitId();
		}
	}

	public void AddBall(Brick_Ball ball)
	{
		if (ball != null && !energyBalls.Contains(ball))
		{
			energyBalls.Add(ball);
		}
	}

	public void RemoveBall(Brick_Ball ball)
	{
		if (ball != null && energyBalls.Contains(ball))
		{
			energyBalls.Remove(ball);
		}
		if (ball != null && ball.IsSplitBall() && ball.gameObject != null)
		{
			ball.ActiveSelf = false;
			ballsToDestroy.Add(ball);
		}
	}

	public void InitActor(BrickActor _actor)
	{
		Actor = _actor;
		if (!(CurrentPaddleCollider == null))
		{
			Actor.tsTransform.Position = CurrentPaddleCollider.tsTransform.Position;
		}
	}

	public void ResetBalltoPaddle(bool init = false)
	{
		if (Paddle == null || BrickBall == null || CurrentPaddleCollider == null)
		{
			_pendingResetToPaddle = true;
			_pendingResetInit = init;
			return;
		}
		if (energyBalls.Count > 0)
		{
			for (int num = energyBalls.Count - 1; num >= 0; num--)
			{
				Brick_Ball brick_Ball = energyBalls.get_Item(num);
				if (brick_Ball != null && brick_Ball.IsSplitBall() && brick_Ball.gameObject != null)
				{
					brick_Ball.ActiveSelf = false;
					ballsToDestroy.Add(brick_Ball);
				}
			}
		}
		energyBalls.Clear();
		energyBalls.Add(BrickBall);
		BrickBall.ResetOnPaddle(init);
		SwitchPaddle(0);
		ResetBouncePoleAddSpeed();
		ResetBandSpeed();
		string currentPaddleFx_Keep = Paddle.GetCurrentPaddleFx_Keep();
		currentKeepFx?.Stop();
		currentKeepFx = PlayBrickFx(currentPaddleFx_Keep, CurrentPaddleCollider.transform.position, CurrentPaddleCollider.transform);
	}

	public AdventureFXPlayer PlayBrickFx(string fxStr, Vector3 pos, Transform ts = null, AdventureActor actor = null)
	{
		GameObject gameObject = ((!(actor == null)) ? ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, fxStr) : ModuleController<AdventureModuleController>.Instance.GetFxByAlias(null, fxStr, forceUseCommonConfig: true));
		if (gameObject == null)
		{
			string assetName = "Assets/AssetBundles/" + fxStr + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
		}
		if (gameObject != null)
		{
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(gameObject, 1f, pos, Quaternion.identity);
			if (ts != null)
			{
				adventureFXPlayer.Bind(ts.gameObject);
				adventureFXPlayer.syncNode = ts;
			}
			return adventureFXPlayer;
		}
		return null;
	}

	public AdventureFXPlayer PlayBrickFxByPrefab(GameObject fxPrefab, Vector3 pos, Transform ts = null)
	{
		if (fxPrefab == null)
		{
			return null;
		}
		AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(fxPrefab, 1f, pos, Quaternion.identity);
		if (ts != null)
		{
			adventureFXPlayer.Bind(ts.gameObject);
			adventureFXPlayer.syncNode = ts;
		}
		return adventureFXPlayer;
	}

	public void SetSkillTips(bool iUse)
	{
		needSkillUseTip = iUse;
		MonoSingleton<LuaManager>.Instance.FireEvent("Brick_ShootButtonState", !IsLaunched && !InBornCD, needSkillUseTip);
	}

	public void BallLaunchState(bool launch, bool init = false)
	{
		if (!InBornCD)
		{
			if (!IsLaunched & launch)
			{
				string currentPaddleFx = Paddle.GetCurrentPaddleFx();
				PlayBrickFx(currentPaddleFx, CurrentPaddleCollider.transform.position, CurrentPaddleCollider.transform);
				currentKeepFx?.Stop();
			}
			IsLaunched = launch;
			if (!launch)
			{
				ResetBalltoPaddle(init);
			}
			else if (_pendingSplitBall)
			{
				_pendingSplitBall = false;
				SplitBall();
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("Brick_ShootButtonState", !IsLaunched && !InBornCD, needSkillUseTip);
		}
	}

	public void SetBallBornCD(bool _value)
	{
		if (InBornCD != _value)
		{
			InBornCD = _value;
			MonoSingleton<LuaManager>.Instance.FireEvent("Brick_ShootButtonState", !IsLaunched && !InBornCD, needSkillUseTip);
		}
	}

	public void SwitchPaddle(int index)
	{
		if (!(Paddle == null))
		{
			Paddle.SwitchPaddle(index);
		}
	}

	public void ChangePaddleCollider(PaddleCollider paddleC)
	{
		CurrentPaddleCollider = paddleC;
		CurrentPaddleCollider.dtcollider.collisionListener = Paddle;
		TryFlushPendingResetToPaddle();
	}

	public void SwitchBall(BrickBallType ballType)
	{
		if (!(BrickBall == null))
		{
			ResetLaserUpgrade();
			for (int i = 0; i < energyBalls.Count; i++)
			{
				energyBalls.get_Item(i).SwitchBall(ballType);
			}
		}
	}

	public FP GetPaddleColliderIndex(DeterministicRaycastHit dRaycastHit)
	{
		if (dRaycastHit.isValid && CurrentPaddleCollider != null)
		{
			FP rayCastColliderPointToLocalPercent = CurrentPaddleCollider.GetRayCastColliderPointToLocalPercent(dRaycastHit);
			return Paddle.GetFixAngle(rayCastColliderPointToLocalPercent);
		}
		return 0;
	}

	public void InitRangeAreaInfo(Transform rangeT)
	{
		if (rangeT == null)
		{
			return;
		}
		int childCount = rangeT.childCount;
		if (childCount < 1)
		{
			return;
		}
		rangeLs.Clear();
		rangeLs.Add(FP.MaxValue);
		rangeLs.Add(FP.MinValue);
		rangeLs.Add(FP.MaxValue);
		rangeLs.Add(FP.MinValue);
		for (int i = 0; i < childCount; i++)
		{
			Vector3 position = rangeT.GetChild(i).position;
			if (position.x < rangeLs.get_Item(0))
			{
				rangeLs.set_Item(0, (FP)position.x);
			}
			if (position.x > rangeLs.get_Item(1))
			{
				rangeLs.set_Item(1, (FP)position.x);
			}
			if (position.z < rangeLs.get_Item(2))
			{
				rangeLs.set_Item(2, (FP)position.z);
				minDeter = rangeT.GetChild(i).GetComponent<DeterministicCollider>();
			}
			if (position.z > rangeLs.get_Item(3))
			{
				rangeLs.set_Item(3, (FP)position.z);
			}
		}
		if (minDeter != null)
		{
			orgMinzPos = minDeter.tsTransform.Position;
			invStarMinzPos = orgMinzPos + new TSVector2(0, invstar_up_colliderY);
		}
	}

	public bool CheckInArea(TSVector2 pos, bool contSize = false)
	{
		bool result = true;
		if (rangeLs.Count < 4)
		{
			return result;
		}
		float num = (contSize ? 3f : 0f);
		if (pos.y <= rangeLs.get_Item(2) + num || pos.y >= rangeLs.get_Item(3) - num)
		{
			result = false;
		}
		if (pos.x <= rangeLs.get_Item(0) + num || pos.x >= rangeLs.get_Item(1) - num)
		{
			result = false;
		}
		return result;
	}

	public void UpdateLife(int life, bool fromHit = false)
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is BrickBreakerController brickBreakerController))
		{
			return;
		}
		if (life < 0)
		{
			if (InvincibleStar || actorInv)
			{
				return;
			}
			BrickBall?.PlayFeedBack_out();
		}
		brickBreakerController.UpdateLife(life);
	}

	public void UpdateScrole(int scrole)
	{
		if (scrole != 0 && ModuleController<AdventureModuleController>.Instance.levelInstance is BrickBreakerController brickBreakerController)
		{
			brickBreakerController.UpdateScrole(scrole);
		}
	}

	public void SplitBall(Brick_Ball sourceBall)
	{
		if (sourceBall == null || ballPrefab == null || Split_num < 1)
		{
			return;
		}
		List<Brick_Ball> list = GetEnergyBalls();
		if (list != null && list.Count >= 9)
		{
			return;
		}
		PlayBrickFxByPrefab(SplitFx, sourceBall.transform.position);
		TSVector2 position = sourceBall.tsTransform.Position;
		TSVector2 moveDirection = sourceBall.GetMoveDirection();
		BrickBallType ballSkinType = sourceBall.GetBallSkinType();
		FP chSpeed = sourceBall.GetChSpeed();
		TSVector2 baseDir = TSVector2.Rotate(moveDirection, Split_rot);
		List<Brick_Ball> list2 = new List<Brick_Ball>();
		if (Split_angle < 360)
		{
			FP fP = ((Split_num > 1) ? (Split_angle / (Split_num - 1)) : ((FP)0));
			FP fP2 = -Split_angle / 2;
			for (int i = 0; i < Split_num; i++)
			{
				if (GetEnergyBalls().Count >= 9)
				{
					break;
				}
				FP angleOffset = fP2 + fP * i;
				Brick_Ball brick_Ball = SplitBallAtAngle(position, baseDir, ballSkinType, chSpeed, angleOffset);
				if (brick_Ball != null)
				{
					list2.Add(brick_Ball);
				}
			}
		}
		else
		{
			FP fP3 = Split_angle / Split_num;
			for (int j = 0; j < Split_num; j++)
			{
				if (GetEnergyBalls().Count >= 9)
				{
					break;
				}
				FP angleOffset2 = fP3 * j;
				Brick_Ball brick_Ball2 = SplitBallAtAngle(position, baseDir, ballSkinType, chSpeed, angleOffset2);
				if (brick_Ball2 != null)
				{
					list2.Add(brick_Ball2);
				}
			}
		}
		foreach (Brick_Ball item in list2)
		{
			CopySpeedEffectsToSplitBall(sourceBall, item);
		}
	}

	private Brick_Ball SplitBallAtAngle(TSVector2 sourcePos, TSVector2 baseDir, BrickBallType skinType, FP chSpeed, FP angleOffset)
	{
		TSVector2 tSVector = TSVector2.Rotate(baseDir, angleOffset);
		TSVector2 pos = sourcePos;
		pos = AdjustPositionIfBlocked(pos, tSVector);
		GameObject gameObject = UnityEngine.Object.Instantiate(ballPrefab.gameObject, new Vector3((float)pos.x, ballPrefab.position.y, (float)pos.y), Quaternion.identity);
		if (gameObject.TryGetComponent<Brick_Ball>(out var component))
		{
			component.SetMoveDirection(tSVector);
			component.SetChSpeed(chSpeed);
			component.SwitchBall(skinType);
			component.SetLaunchedState(launched: true);
			component.Active();
			GrantBornImmuneIfActive(component);
			return component;
		}
		NovaLogger.Error("SplitBallAtAngle: prefab missing Brick_Ball component, destroying orphan object.");
		UnityEngine.Object.Destroy(gameObject);
		return null;
	}

	private TSVector2 AdjustPositionIfBlocked(TSVector2 pos, TSVector2 dir)
	{
		FP fP = 0.5;
		FP radius = 0.5;
		int num = (int)(long)(SplitDistance / fP);
		num = ((num < 1) ? 1 : num);
		for (int num2 = num; num2 > 0; num2--)
		{
			TSVector2 tSVector = pos + dir * (num2 * fP);
			if (!IsPositionBlocked(tSVector, radius))
			{
				return tSVector;
			}
		}
		for (int i = 10; i <= 80; i += 10)
		{
			TSVector2 tSVector2 = TSVector2.Rotate(dir, i);
			TSVector2 tSVector3 = TSVector2.Rotate(dir, -i);
			if (!IsPositionBlocked(pos + tSVector2 * fP, radius))
			{
				return pos + tSVector2 * fP;
			}
			if (!IsPositionBlocked(pos + tSVector3 * fP, radius))
			{
				return pos + tSVector3 * fP;
			}
		}
		return pos;
	}

	private bool IsPositionBlocked(TSVector2 pos, FP radius)
	{
		int layerMask = 4263936;
		return SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(radius, pos, hitColliders, layerMask);
	}

	public bool IsBallInPaddle(TSVector2 pos, FP radius)
	{
		int layerMask = 4194304;
		return SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(radius, pos, hitColliders, layerMask);
	}

	public void SetBornBallOutAreaImmune(int count, string fxName)
	{
		_bornImmuneCount = count;
		_bornImmuneFxName = fxName;
		if (!IsLaunched)
		{
			for (int i = 0; i < energyBalls.Count; i++)
			{
				GrantBornImmuneIfActive(energyBalls.get_Item(i));
			}
		}
	}

	public void GrantBornImmuneIfActive(Brick_Ball ball)
	{
		if (!(ball == null) && _bornImmuneCount > 0)
		{
			ball.GrantOutAreaImmune(_bornImmuneCount, _bornImmuneFxName);
		}
	}

	public void OnBallCaughtByPaddle()
	{
		if (!(Actor == null))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = 157010001;
			Actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	public void EnhanceAllEnergyBalls(int countPerBall, string areaFxKey)
	{
		if (countPerBall <= 0)
		{
			return;
		}
		List<Brick_Ball> list = GetEnergyBalls();
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				list.get_Item(i)?.GrantSwordEnhance(countPerBall, areaFxKey);
			}
		}
	}

	public void PlaySwordEnhanceArea(TSVector2 pos, string areaFxKey)
	{
		if (!(Actor == null) && !string.IsNullOrEmpty(areaFxKey))
		{
			ILRuntimeAPI.PlayAreaEffect(Actor, areaFxKey, pos);
		}
	}

	public void CreateBubble(TSVector2 center, FP BUBBLE_DURATION)
	{
		bubbleCenter = center;
		HasBubble = true;
		bubbleTimer = BUBBLE_DURATION;
		bubbleFx?.Stop();
		bubbleFx = null;
		if (!string.IsNullOrEmpty(BUBBLE_FX))
		{
			bubbleFx = PlayBrickFx(pos: new Vector3((float)bubbleCenter.x, 0f, (float)bubbleCenter.y), fxStr: BUBBLE_FX);
		}
	}

	public void ApplyBubbleConfine(Brick_BallBase ball, TSVector2 prevPos)
	{
		if (!HasBubble || ball == null)
		{
			return;
		}
		TSVector2 position = ball.tsTransform.Position;
		FP radius = ball.DtCollider.Radius;
		TSVector2 tSVector = position - bubbleCenter;
		FP magnitude = tSVector.magnitude;
		if (ball.BubbleConfineExempt)
		{
			if (magnitude + radius < BUBBLE_RADIUS || magnitude - radius > BUBBLE_RADIUS)
			{
				ball.BubbleConfineExempt = false;
			}
			return;
		}
		TSVector2 tSVector2 = tSVector.normalized;
		if (tSVector2 == TSVector2.zero)
		{
			tSVector2 = TSVector2.up;
		}
		TSVector2 moveDirection = ball.GetMoveDirection();
		FP fP = moveDirection.x * tSVector2.x + moveDirection.y * tSVector2.y;
		FP magnitude2 = (prevPos - bubbleCenter).magnitude;
		bool flag = false;
		if (magnitude2 <= BUBBLE_RADIUS)
		{
			if (magnitude + radius < BUBBLE_RADIUS)
			{
				return;
			}
			ball.tsTransform.Position = bubbleCenter + tSVector2 * (BUBBLE_RADIUS - radius);
			if (fP > 0)
			{
				TSVector2 normalized = TSVector2.Reflect(moveDirection, -tSVector2).normalized;
				normalized = RotateBubbleReflect(normalized, BUBBLE_INNER_REFLECT_ANGLE_OFFSET);
				ball.SetMoveDirection(normalized);
				flag = true;
			}
		}
		else
		{
			if (magnitude - radius > BUBBLE_RADIUS)
			{
				return;
			}
			ball.tsTransform.Position = bubbleCenter + tSVector2 * (BUBBLE_RADIUS + radius);
			if (fP < 0)
			{
				TSVector2 normalized2 = TSVector2.Reflect(moveDirection, tSVector2).normalized;
				ball.SetMoveDirection(normalized2);
				flag = true;
			}
		}
		if (flag)
		{
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("char_16001_main_P1_bubble_insert");
		}
	}

	protected void OnUpdate_Bubble(FP deltaTime)
	{
		if (HasBubble)
		{
			bubbleTimer -= deltaTime;
			if (bubbleTimer <= 0)
			{
				EndBubble();
			}
		}
	}

	public void EndBubble()
	{
		if (HasBubble)
		{
			HasBubble = false;
			bubbleTimer = 0;
			bubbleFx?.Stop();
			bubbleFx = null;
		}
	}

	private static TSVector2 RotateBubbleReflect(TSVector2 dir, FP angleDeg)
	{
		return TSVector2.Rotate(dir, angleDeg);
	}

	public void StartHuntingChain(TSVector2 linkPos, FP duration, string linkFx)
	{
		huntingChainPos = linkPos;
		HasHuntingChain = true;
		huntingChainTimer = duration;
		huntingChainFx?.Stop();
		huntingChainFx = null;
		if (Actor != null && !string.IsNullOrEmpty(linkFx))
		{
			if (_huntingChainPlayFx == null)
			{
				_huntingChainPlayFx = new PlayFX();
			}
			_huntingChainPlayFx.Stop();
			huntingChainFx = _huntingChainPlayFx.PlayLinFx(Actor, linkFx, 1f, useCustSource: true, Actor.gameObject, default, default, null, new TSVector(linkPos.x, 0, linkPos.y), default);
		}
	}

	protected void OnUpdate_HuntingChain(FP deltaTime)
	{
		if (HasHuntingChain)
		{
			huntingChainTimer -= deltaTime;
			if (huntingChainTimer <= 0)
			{
				EndHuntingChain();
			}
		}
	}

	public void EndHuntingChain()
	{
		if (HasHuntingChain)
		{
			HasHuntingChain = false;
			huntingChainTimer = 0;
			huntingChainFx?.Stop();
			huntingChainFx = null;
		}
	}

	public TSVector2 GetHuntingChainReflect(TSVector2 ballPos)
	{
		TSVector2 normalized = (huntingChainPos - ballPos).normalized;
		if (!(normalized == TSVector2.zero))
		{
			return normalized;
		}
		return TSVector2.up;
	}

	public void OnGetDropItem(BrickDrop dropItem)
	{
		if (dropItem == null)
		{
			return;
		}
		bool flag = true;
		switch (dropItem.dropType)
		{
		case HotfixEnum.BrickDropType.BrickFire:
			SwitchBall(BrickBallType.Fire);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_energy");
			break;
		case HotfixEnum.BrickDropType.BrickBoom:
			UpdateLife(-1, fromHit: true);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_debuff_shrinkBorad");
			break;
		case HotfixEnum.BrickDropType.BrickEnergy:
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_energy");
			if (Actor != null)
			{
				Actor.skillMgr?.ModifyEnergyByAbs(Actor.mainSkillId, dropItem.SpecialParmas);
			}
			break;
		case HotfixEnum.BrickDropType.BrickExpCoin:
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_coinGet");
			UpdateScrole(dropItem.SpecialParmas);
			break;
		case HotfixEnum.BrickDropType.BrickHp:
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_heal");
			UpdateLife(1);
			break;
		case HotfixEnum.BrickDropType.BrickPaddle:
			SwitchPaddle(dropItem.SpecialParmas);
			if (dropItem.SpecialParmas == 1)
			{
				MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_energy");
			}
			else if (dropItem.SpecialParmas == 2)
			{
				MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_debuff_shrinkBorad");
			}
			break;
		case HotfixEnum.BrickDropType.BrickBoomBall:
			SwitchBoomBall(dropItem);
			break;
		case HotfixEnum.BrickDropType.BrickInv:
			GetInviStar(dropItem);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_shield");
			break;
		case HotfixEnum.BrickDropType.BrickSplit:
			SplitBall(dropItem);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_split");
			break;
		case HotfixEnum.BrickDropType.BrickPortal_Hole:
			GetPortalTraction(dropItem.SpecialParmas);
			break;
		case HotfixEnum.BrickDropType.Brick_HorizontalLaser:
			SwitchLaserBall(BrickBallType.HorizontalLaser, dropItem);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_energy");
			break;
		case HotfixEnum.BrickDropType.Brick_VerticalLaser:
			SwitchLaserBall(BrickBallType.VerticalLaser, dropItem);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_energy");
			break;
		case HotfixEnum.BrickDropType.Brick_Lightning:
			SwitchLaserBall(BrickBallType.Lightning, dropItem);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_energy");
			break;
		default:
			flag = false;
			break;
		}
		if (flag)
		{
			UpdateScrole(exceptDropScro);
			if (ModuleController<AdventureModuleController>.Instance.levelInstance is BrickBreakerController brickBreakerController)
			{
				brickBreakerController.ActivityEventToLua("Brick_Drop", dropItem.DropId);
			}
			if (Actor != null)
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.eventHashCode = 145010001;
				Actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
	}

	public void GetInviStar()
	{
		invaTime = 100;
		InvincibleStar = true;
		disableTime = 5;
		invstarOnDisable = false;
	}

	public void GetPortalTraction(FP duration)
	{
		PortalTractionActive = true;
		portalTractionTime = duration;
	}

	public void EndPortalTraction()
	{
		if (PortalTractionActive)
		{
			PortalTractionActive = false;
			portalTractionTime = 0;
			ResetPortalTraction();
		}
	}

	public void InviStarSetMinCollierUp()
	{
		if (!InvincibleStar || minDeter == null)
		{
			return;
		}
		FP y = minDeter.tsTransform.Position.y;
		if (y > orgMinzPos.y)
		{
			return;
		}
		FP fP = y + minDeter.ColliderLength / 2;
		List<Brick_BallBase> allBalls = GetAllBalls();
		for (int num = allBalls.Count - 1; num >= 0; num--)
		{
			if (!(allBalls.get_Item(num) == null) && allBalls.get_Item(num).tsTransform.Position.y < fP)
			{
				return;
			}
		}
		minDeter.tsTransform.Position = invStarMinzPos;
	}

	public void InviStarSetMinCollierDown()
	{
		if (!InvincibleStar && !(minDeter == null))
		{
			minDeter.tsTransform.Position = orgMinzPos;
		}
	}

	private void GetInviStar(BrickDrop dropItem)
	{
		invaTime = dropItem.SpecialParmas;
		if (!(invaTime <= 0))
		{
			InvincibleStar = true;
			disableTime = FP.FromConfigFloat(dropItem.disableDuration);
			disableFx = dropItem.disableFx;
			Vector3 zero = Vector3.zero;
			invincibleFx?.Stop();
			invincibleFx = PlayBrickFxByPrefab(dropItem.invFx, zero);
			roleInvincibleFx?.Stop();
			if (Actor != null)
			{
				roleInvincibleFx = PlayBrickFxByPrefab(dropItem.roleFx, Actor.transform.position, Actor.transform);
			}
			invstarOnDisable = false;
		}
	}

	private void SwitchBoomBall(BrickDrop dropItem)
	{
		SwitchBall(BrickBallType.Boom);
		boomRange = dropItem.SpecialParmas;
		boomFx = dropItem.BoomFx;
		boomClear = dropItem.desClear;
		boomId = dropItem.hitId;
		boomFxScale = dropItem.BoomFxScale;
	}

	public void PlayBoomBall(Vector3 pos)
	{
		if (boomRange <= 0)
		{
			return;
		}
		MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_rpg_boom");
		if (boomFx != null)
		{
			AdventureFXPlayer.PlayFX(boomFx, 1f, pos, Quaternion.identity, boomFxScale);
		}
		int layerMask = 65792;
		SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(boomRange, new TSVector2(pos.x, pos.z), hitColliders, layerMask);
		if (hitColliders.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < hitColliders.Count; i++)
		{
			DestructibleStateSingle component = hitColliders.get_Item(i).GetComponent<DestructibleStateSingle>();
			if (boomClear && component != null)
			{
				component.OnKill();
			}
			else if (boomId > 0)
			{
				AdventureActor component2 = hitColliders.get_Item(i).GetComponent<AdventureActor>();
				if (component2 != null)
				{
					ILRuntimeAPI.HitActor(Actor, component2, boomId);
				}
			}
		}
	}

	public void SplitBall(BrickDrop drop = null)
	{
		if (drop != null)
		{
			Split_num = drop.splitNum;
			Split_angle = FP.FromConfigFloat(drop.splitAngle);
			Split_rot = FP.FromConfigFloat(drop.splitRot);
			SplitDistance = FP.FromConfigFloat(drop.splitDistance);
			SplitFx = drop.splitFx;
		}
		if (InBornCD || !IsLaunched)
		{
			_pendingSplitBall = true;
			return;
		}
		List<Brick_Ball> list = GetEnergyBalls();
		if (list != null && list.Count != 0)
		{
			List<Brick_Ball> list2 = new List<Brick_Ball>(list);
			int count = list2.Count;
			for (int i = 0; i < count; i++)
			{
				SplitBall(list2.get_Item(i));
			}
		}
	}

	public void SetExceptDropScro(int exceptScro)
	{
		exceptDropScro = exceptScro;
	}

	private void OnUpdate_Drop(FP deltaTime)
	{
		if (PortalTractionActive && portalTractionTime > 0)
		{
			portalTractionTime -= deltaTime;
			if (portalTractionTime <= 0)
			{
				EndPortalTraction();
			}
		}
		if (invaTime > 0)
		{
			invaTime -= deltaTime;
			if (invaTime <= 0)
			{
				invincibleFx?.Stop();
				if (disableTime > 0)
				{
					invstarOnDisable = true;
					Vector3 zero = Vector3.zero;
					invincibleFx = PlayBrickFxByPrefab(disableFx, zero);
				}
				else
				{
					roleInvincibleFx?.Stop();
					InvincibleStar = false;
					InviStarSetMinCollierDown();
				}
			}
		}
		else if (invstarOnDisable && disableTime > 0)
		{
			disableTime -= deltaTime;
			if (disableTime <= 0)
			{
				roleInvincibleFx?.Stop();
				InvincibleStar = false;
				InviStarSetMinCollierDown();
				invstarOnDisable = false;
				invincibleFx?.Stop();
			}
		}
	}

	public void OnClear()
	{
		_pendingResetToPaddle = false;
		needSkillUseTip = false;
		boomRange = 0;
		boomFx = null;
		boomClear = false;
		boomId = 0;
		boomFxScale = 1f;
		laserAreaHorizontal = null;
		laserAreaVertical = null;
		laserAreaLightning = null;
		_crossEatLightning = false;
		_lightningHEatVertical = false;
		_lightningVEatHorizontal = false;
		_chainFollowUps.Clear();
		_chainHitted.Clear();
		if (_chainListening)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_FOR_EFFECT", OnChainDamage);
			_chainListening = false;
		}
		InvincibleStar = false;
		InviStarSetMinCollierDown();
		minDeter = null;
		invaTime = 0;
		disableTime = 0;
		invincibleFx?.Stop();
		invincibleFx = null;
		roleInvincibleFx?.Stop();
		roleInvincibleFx = null;
		invstarOnDisable = false;
		_pendingSplitBall = false;
		ballPauseTime = 0;
		actorInv = false;
		Split_num = 0;
		Split_angle = 0;
		Split_rot = 0;
		SplitDistance = 0;
		SplitFx = null;
		_bornImmuneCount = 0;
		EndBubble();
		EndHuntingChain();
		EndPortalTraction();
		energyBalls?.Clear();
		for (int num = poleSpawnedBalls.Count - 1; num >= 0; num--)
		{
			if (poleSpawnedBalls.get_Item(num) != null && poleSpawnedBalls.get_Item(num).gameObject != null)
			{
				UnityEngine.Object.Destroy(poleSpawnedBalls.get_Item(num).gameObject);
			}
		}
		poleSpawnedBalls.Clear();
		if (ballsToDestroy.Count > 0)
		{
			for (int num2 = ballsToDestroy.Count - 1; num2 >= 0; num2--)
			{
				UnityEngine.Object.Destroy(ballsToDestroy.get_Item(num2).gameObject);
			}
			ballsToDestroy.Clear();
		}
	}

	private void SwitchLaserBall(BrickBallType pickType, BrickDrop dropItem)
	{
		if (dropItem != null && dropItem.triggerArea != null)
		{
			switch (pickType)
			{
			case BrickBallType.HorizontalLaser:
				laserAreaHorizontal = dropItem.triggerArea;
				break;
			case BrickBallType.VerticalLaser:
				laserAreaVertical = dropItem.triggerArea;
				break;
			case BrickBallType.Lightning:
				laserAreaLightning = dropItem.triggerArea;
				break;
			}
		}
		BrickBallType currentBallSkinType = GetCurrentBallSkinType();
		if (!TryUpgradeLaserBall(currentBallSkinType, pickType))
		{
			BrickBallType brickBallType = CombineLaserBall(currentBallSkinType, pickType);
			if (brickBallType != currentBallSkinType)
			{
				SwitchBall(brickBallType);
			}
		}
	}

	private void ResetLaserUpgrade()
	{
		_crossEatLightning = false;
		_lightningHEatVertical = false;
		_lightningVEatHorizontal = false;
	}

	private bool TryUpgradeLaserBall(BrickBallType current, BrickBallType pick)
	{
		if (current == BrickBallType.CrossLaser && pick == BrickBallType.Lightning)
		{
			_crossEatLightning = true;
			return true;
		}
		if (current == BrickBallType.LightningHorizontalLaser && pick == BrickBallType.VerticalLaser)
		{
			_lightningHEatVertical = true;
			return true;
		}
		if (current == BrickBallType.LightningVerticalLaser && pick == BrickBallType.HorizontalLaser)
		{
			_lightningVEatHorizontal = true;
			return true;
		}
		return false;
	}

	public void PlayLaserTriggerArea(TSVector2 pos, BrickBallType ballType)
	{
		if (Actor == null)
		{
			return;
		}
		switch (ballType)
		{
		case BrickBallType.HorizontalLaser:
			SpawnLaserArea(laserAreaHorizontal, pos);
			break;
		case BrickBallType.VerticalLaser:
			SpawnLaserArea(laserAreaVertical, pos);
			break;
		case BrickBallType.Lightning:
			SpawnLaserArea(laserAreaLightning, pos);
			break;
		case BrickBallType.CrossLaser:
			SpawnLaserArea(laserAreaHorizontal, pos);
			SpawnLaserArea(laserAreaVertical, pos);
			if (_crossEatLightning)
			{
				SpawnLaserArea(laserAreaLightning, pos);
			}
			break;
		case BrickBallType.LightningHorizontalLaser:
			SpawnChainArea(laserAreaLightning, pos, laserAreaHorizontal, _lightningHEatVertical ? laserAreaVertical : null);
			break;
		case BrickBallType.LightningVerticalLaser:
			SpawnChainArea(laserAreaLightning, pos, laserAreaVertical, _lightningVEatHorizontal ? laserAreaHorizontal : null);
			break;
		}
	}

	private void SpawnLaserArea(GameObject prefab, TSVector2 pos)
	{
		if (!(prefab == null))
		{
			ILRuntimeAPI.PlayAreaEffect(Actor, prefab, pos);
		}
	}

	private void SpawnChainArea(GameObject source, TSVector2 pos, GameObject followUpA, GameObject followUpB)
	{
		if (source == null || (followUpA == null && followUpB == null))
		{
			return;
		}
		EnsureChainListening();
		ILRuntimeAPI.PlayAreaEffect(Actor, source, pos, default, (AreaEffectEntity areaEffect) =>
		{
			if (!(areaEffect == null) && areaEffect.Id > 0)
			{
				_chainFollowUps.set_Item(areaEffect.Id, (followUpA, followUpB));
				AreaEffectEntity areaEffectEntity = areaEffect;
				areaEffectEntity.OnBeforeEnd = (Action)Delegate.Combine(areaEffectEntity.OnBeforeEnd, (Action)(() =>
				{
					RemoveChain(areaEffect.Id);
				}));
			}
		});
	}

	private void RemoveChain(long areaEffectId)
	{
		_chainFollowUps.Remove(areaEffectId);
		_chainHitted.RemoveWhere(((long areaId, long targetId) k) => k.areaId == areaEffectId);
	}

	private void EnsureChainListening()
	{
		if (!_chainListening)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_FOR_EFFECT", OnChainDamage);
			_chainListening = true;
		}
	}

	private void OnChainDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageForEffectEvent adventureActorReceiveDamageForEffectEvent && _chainFollowUps.TryGetValue(adventureActorReceiveDamageForEffectEvent.areaEffectId, out (GameObject, GameObject) value) && !(adventureActorReceiveDamageForEffectEvent.to == null) && !(Actor == null) && _chainHitted.Add((adventureActorReceiveDamageForEffectEvent.areaEffectId, adventureActorReceiveDamageForEffectEvent.to.Id)))
		{
			TSVector2 position = adventureActorReceiveDamageForEffectEvent.to.tsTransform.Position;
			if (value.Item1 != null)
			{
				ILRuntimeAPI.PlayAreaEffect(Actor, value.Item1, position);
			}
			if (value.Item2 != null)
			{
				ILRuntimeAPI.PlayAreaEffect(Actor, value.Item2, position);
			}
		}
	}

	private BrickBallType GetCurrentBallSkinType()
	{
		List<Brick_Ball> list = GetEnergyBalls();
		if (list == null)
		{
			return BrickBallType.Normal;
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i) != null)
			{
				return list.get_Item(i).GetBallSkinType();
			}
		}
		return BrickBallType.Normal;
	}

	private BrickBallType CombineLaserBall(BrickBallType current, BrickBallType pick)
	{
		switch (pick)
		{
		case BrickBallType.HorizontalLaser:
			switch (current)
			{
			case BrickBallType.VerticalLaser:
				return BrickBallType.CrossLaser;
			case BrickBallType.Lightning:
				return BrickBallType.LightningHorizontalLaser;
			}
			break;
		case BrickBallType.VerticalLaser:
			switch (current)
			{
			case BrickBallType.HorizontalLaser:
				return BrickBallType.CrossLaser;
			case BrickBallType.Lightning:
				return BrickBallType.LightningVerticalLaser;
			}
			break;
		case BrickBallType.Lightning:
			switch (current)
			{
			case BrickBallType.HorizontalLaser:
				return BrickBallType.LightningHorizontalLaser;
			case BrickBallType.VerticalLaser:
				return BrickBallType.LightningVerticalLaser;
			}
			break;
		}
		if ((uint)(current - 6) <= 2u && (pick == BrickBallType.HorizontalLaser || pick == BrickBallType.VerticalLaser || pick == BrickBallType.Lightning))
		{
			return current;
		}
		return pick;
	}

	public void AddBlackHoleForBall(Brick_BallBase ball, Gear_BlackHole blackHole)
	{
		if (!(ball == null) && !(blackHole == null))
		{
			if (!_ballBlackHoleMap.TryGetValue(ball, out var value))
			{
				value = new List<Gear_BlackHole>();
				_ballBlackHoleMap.set_Item(ball, value);
			}
			if (!value.Contains(blackHole))
			{
				value.Add(blackHole);
			}
		}
	}

	public void RemoveBlackHoleForBall(Brick_BallBase ball, Gear_BlackHole blackHole)
	{
		if (!(ball == null) && !(blackHole == null) && _ballBlackHoleMap.TryGetValue(ball, out var value))
		{
			value.Remove(blackHole);
			if (value.Count == 0)
			{
				_ballBlackHoleMap.Remove(ball);
			}
		}
	}

	public void RemoveAllBlackHoleForBall(Brick_BallBase ball)
	{
		if (!(ball == null))
		{
			_ballBlackHoleMap.Remove(ball);
		}
	}

	public bool HaveBlackHoleForBall(Brick_BallBase ball)
	{
		if (InvincibleStar)
		{
			return false;
		}
		if (ball == null)
		{
			return false;
		}
		if (_ballBlackHoleMap.TryGetValue(ball, out var value))
		{
			return value.Count > 0;
		}
		return false;
	}

	public (TSVector2, FP) CaculateGriavityDirAndDis(Brick_BallBase ball, ref TSVector2 moveData)
	{
		if (ball == null)
		{
			return (moveData.normalized, moveData.magnitude);
		}
		if (!_ballBlackHoleMap.TryGetValue(ball, out var value) || value.Count == 0)
		{
			return (moveData.normalized, moveData.magnitude);
		}
		TSVector2 tSVector = moveData;
		TSVector2 tSVector2;
		FP fP;
		for (int num = value.Count - 1; num >= 0; num--)
		{
			Gear_BlackHole gear_BlackHole = value.get_Item(num);
			if (gear_BlackHole == null || !gear_BlackHole.ActiveSelf)
			{
				value.RemoveAt(num);
			}
			else if (!gear_BlackHole.inTriggerCD)
			{
				TrueSyncTransform tsTransform = gear_BlackHole.tsTransform;
				tSVector2 = tsTransform.Position - ball.tsTransform.Position;
				fP = TSVector2.Distance(ball.tsTransform.Position, tsTransform.Position);
				FP fP2 = gear_BlackHole.gravitySpeed * gear_BlackHole.LogicDeltaTime;
				if (fP2 > fP)
				{
					fP2 = fP;
				}
				TSVector2 tSVector3 = tSVector2.normalized;
				if (!gear_BlackHole.isAttractMode)
				{
					tSVector3 = -tSVector3;
				}
				tSVector += tSVector3 * fP2 * gear_BlackHole.angle_change_rat;
				moveData += tSVector3 * fP2;
			}
		}
		if (value.Count == 0)
		{
			_ballBlackHoleMap.Remove(ball);
		}
		tSVector2 = tSVector.normalized;
		fP = FP.Sqrt(moveData.LengthSquared());
		return (tSVector2, fP);
	}

	public void AddPortalTractionForBall(Brick_BallBase ball, Portal_End end)
	{
		if (!(ball == null) && !(end == null))
		{
			if (!_ballPortalTractionMap.TryGetValue(ball, out var value))
			{
				value = new List<Portal_End>();
				_ballPortalTractionMap.set_Item(ball, value);
			}
			if (!value.Contains(end))
			{
				value.Add(end);
			}
		}
	}

	public void RemovePortalTractionForBall(Brick_BallBase ball, Portal_End end)
	{
		if (!(ball == null) && !(end == null) && _ballPortalTractionMap.TryGetValue(ball, out var value))
		{
			value.Remove(end);
			if (value.Count == 0)
			{
				_ballPortalTractionMap.Remove(ball);
			}
		}
	}

	public void RemoveAllPortalTractionForBall(Brick_BallBase ball)
	{
		if (!(ball == null))
		{
			_ballPortalTractionMap.Remove(ball);
		}
	}

	public bool HavePortalTractionForBall(Brick_BallBase ball)
	{
		if (InvincibleStar)
		{
			return false;
		}
		if (!PortalTractionActive)
		{
			return false;
		}
		if (ball == null)
		{
			return false;
		}
		if (_ballPortalTractionMap.TryGetValue(ball, out var value))
		{
			return value.Count > 0;
		}
		return false;
	}

	public (TSVector2, FP) CaculateTractionDirAndDis(Brick_BallBase ball, ref TSVector2 moveData)
	{
		if (ball == null)
		{
			return (moveData.normalized, moveData.magnitude);
		}
		if (!_ballPortalTractionMap.TryGetValue(ball, out var value) || value.Count == 0)
		{
			return (moveData.normalized, moveData.magnitude);
		}
		TSVector2 tSVector = moveData;
		for (int num = value.Count - 1; num >= 0; num--)
		{
			Portal_End portal_End = value.get_Item(num);
			if (portal_End == null || !portal_End.ActiveSelf)
			{
				value.RemoveAt(num);
			}
			else if (!portal_End.InTractionCD && !portal_End.IsBallImmune(ball))
			{
				TSVector2 tSVector2 = -portal_End.Collider.tsTransform.Forward;
				FP fP = portal_End.TractionSpeed * portal_End.LogicDeltaTime;
				tSVector += tSVector2 * fP * portal_End.TractionAngleRate;
				moveData += tSVector2 * fP;
			}
		}
		if (value.Count == 0)
		{
			_ballPortalTractionMap.Remove(ball);
		}
		TSVector2 normalized = tSVector.normalized;
		FP item = FP.Sqrt(moveData.LengthSquared());
		return (normalized, item);
	}

	public void ResetPortalTraction()
	{
		_ballPortalTractionMap.Clear();
	}

	public void AddSpeedBandForBall(Brick_BallBase ball, FP fixSpeed)
	{
		if (!InvincibleStar && !(ball == null))
		{
			if (!_ballSpeedBandMap.ContainsKey(ball))
			{
				_ballSpeedBandMap.Add(ball, fixSpeed);
			}
			else
			{
				_ballSpeedBandMap.get_Item(ball) += fixSpeed;
			}
		}
	}

	public void RemoveAllSpeedBandForBall(Brick_BallBase ball)
	{
		if (!(ball == null))
		{
			_ballSpeedBandMap.Remove(ball);
		}
	}

	public bool HaveSpeedBandForBall(Brick_BallBase ball)
	{
		if (ball == null)
		{
			return false;
		}
		return _ballSpeedBandMap.ContainsKey(ball);
	}

	public FP GetSpeedBandSpeedDelta(Brick_BallBase ball, FP currentSpeed, FP minSpeed, FP maxSpeed)
	{
		if (ball == null)
		{
			return 0;
		}
		if (!_ballSpeedBandMap.ContainsKey(ball))
		{
			return 0;
		}
		FP fP = _ballSpeedBandMap.get_Item(ball);
		FP value = currentSpeed + fP;
		value = TSMath.Clamp(value, minSpeed, maxSpeed);
		_ballSpeedBandMap.set_Item(ball, value - currentSpeed);
		return _ballSpeedBandMap.get_Item(ball);
	}

	public void ResetBandSpeed()
	{
		_ballSpeedBandMap.Clear();
	}

	public Gear_BouncePole IsGearBouncePole(Brick_BallBase ball, DeterministicRaycastHit dRaycastHit)
	{
		if (_gearList.Find((GearBase gearBase) => gearBase.Id == dRaycastHit.collider.Entity.Id) is Gear_BouncePole gear_BouncePole)
		{
			if (!InvincibleStar)
			{
				gear_BouncePole.AddSpeed();
				if (!_ballBouncePoleMap.ContainsKey(ball))
				{
					_ballBouncePoleMap.set_Item(ball, new List<Gear_BouncePole>());
				}
				if (!_ballBouncePoleMap.get_Item(ball).Contains(gear_BouncePole))
				{
					_ballBouncePoleMap.get_Item(ball).Add(gear_BouncePole);
				}
			}
			return gear_BouncePole;
		}
		return null;
	}

	public FP GetBouncePoleAddSpeed(Brick_BallBase ball)
	{
		if (ball == null)
		{
			return 0;
		}
		if (!_ballBouncePoleMap.TryGetValue(ball, out var value) || value.Count <= 0)
		{
			return 0;
		}
		FP result = 0;
		for (int num = value.Count - 1; num >= 0; num--)
		{
			if (value.get_Item(num).Add_Speed > 0)
			{
				result += value.get_Item(num).Add_Speed;
			}
			else
			{
				value.RemoveAt(num);
			}
		}
		return result;
	}

	public void ResetBouncePoleAddSpeed()
	{
		_ballBouncePoleMap.Clear();
	}

	public void CopySpeedEffectsToSplitBall(Brick_BallBase sourceBall, Brick_BallBase splitBall)
	{
		if (!(sourceBall == null) && !(splitBall == null))
		{
			if (_ballSpeedBandMap.TryGetValue(sourceBall, out var value))
			{
				_ballSpeedBandMap.set_Item(splitBall, value);
			}
			if (_ballBouncePoleMap.TryGetValue(sourceBall, out var value2) && value2.Count > 0)
			{
				_ballBouncePoleMap.set_Item(splitBall, new List<Gear_BouncePole>(value2));
			}
		}
	}

	public void SetAllBouncePoleProximityBoost(AdventureActor target, FP distance, FP extraAngularSpeed)
	{
		for (int i = 0; i < _gearList.Count; i++)
		{
			if (_gearList.get_Item(i) is Gear_BouncePole gear_BouncePole)
			{
				gear_BouncePole.SetProximitySpeedBoost(target, distance, extraAngularSpeed);
			}
		}
	}

	public long GetGearToScence(string fxAlias, TSVector2 position = default(TSVector2), FP rotation = default(FP))
	{
		if (string.IsNullOrEmpty(fxAlias))
		{
			return 0L;
		}
		fxAlias = "Assets/AssetBundles/" + fxAlias + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, fxAlias, typeof(GameObject)) as GameObject;
		if (gameObject == null)
		{
			Debug.LogError("机关资源不存在:" + fxAlias);
			return 0L;
		}
		Vector3 spawnPosition = new Vector3((float)position.x, 0f, (float)position.y);
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)rotation, 0f);
		GearBase gearBase = Spawn(gameObject, spawnPosition, spawnRotation);
		if (gearBase != null)
		{
			return gearBase.Id;
		}
		return 0L;
	}

	public void ClearGearById(long id)
	{
		if (id > 0)
		{
			GearBase gearBase = _gearList.Find((GearBase gearBase2) => gearBase2.Id == id);
			if (gearBase != null)
			{
				gearBase.ActiveSelf = false;
			}
		}
	}

	public void ClearAllGear()
	{
		if (_gearList.Count > 0)
		{
			for (int num = _gearList.Count - 1; num >= 0; num--)
			{
				_gearList.get_Item(num).ActiveSelf = false;
			}
		}
	}

	protected GearBase Spawn(GameObject fxPrefab, Vector3 spawnPosition, Quaternion spawnRotation)
	{
		SpawnPool spawnPool = PoolManager.Pools.get_Item("Effect");
		Transform transform = ((!(spawnPool != null)) ? UnityEngine.Object.Instantiate(fxPrefab, spawnPosition, spawnRotation).transform : spawnPool.Spawn(fxPrefab.transform, spawnPosition, spawnRotation));
		transform.SetParent(ObjectPoolUtils.GetPoolRootNode("Effect"));
		if (transform.TryGetComponent<GearBase>(out var component))
		{
			_gearList.Add(component);
			return component;
		}
		spawnPool.Despawn(transform, spawnPool.group);
		return null;
	}

	public void Despawn(GearBase entity)
	{
		_gearList.Remove(entity);
		if (PoolManager.Pools.TryGetValue("Effect", out var spawnPool))
		{
			spawnPool.Despawn(entity.transform, spawnPool.group);
		}
	}

	public void RegisterBakedGears(GearBase[] gears)
	{
		if (gears == null)
		{
			return;
		}
		foreach (GearBase gearBase in gears)
		{
			if (!(gearBase == null) && !_gearList.Contains(gearBase))
			{
				gearBase.IsBaked = true;
				_gearList.Add(gearBase);
			}
		}
	}

	public void UnregisterBakedGear(GearBase entity)
	{
		_gearList.Remove(entity);
	}
}
