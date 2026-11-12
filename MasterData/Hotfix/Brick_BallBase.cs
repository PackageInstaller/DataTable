#define LOG_ERROR
using System.Collections.Generic;
using System.Diagnostics;
using TrueSync;
using UnityEngine;

public abstract class Brick_BallBase : LogicEntity, IHitBoxContext
{
	protected readonly int wallFixTime = 6;

	protected readonly string ballFx_outArea = "";

	protected readonly string ballFx_reset = "fx_breakout_base_ball_bron";

	protected readonly FP ballResetTime = 0.6f;

	protected readonly FP actorOffset = -1f;

	public ParticleSystem[] trailParticles;

	private Collider collider;

	private const int hitableLayerMask_Default = 4264192;

	private TSVector2 startPosition;

	private TSVector2 moveDirection;

	private FP chSpeed;

	private int wallIndex;

	private FP currentSpeed;

	private bool useMaxSpeed;

	private FP waitResTime;

	private bool hasReflect;

	private FP delInvSpeed;

	private FP elapsedDisableTime;

	public FP I_Speed;

	private bool outArea;

	private bool hitPaddle;

	private int inPaddleCount;

	private readonly List<ParticleSystem> _teleportPsList = new List<ParticleSystem>();

	private readonly List<ParticleSystemRenderer> _teleportPsRendererList = new List<ParticleSystemRenderer>();

	private int _teleportHideFrames;

	private const int TELEPORT_HIDE_FRAMES = 3;

	private static readonly bool LOG_TELEPORT_TRAIL_COST = false;

	private static readonly Stopwatch _trailCostSw = new Stopwatch();

	private double _teleportTrailTotalMs;

	private int _teleportTrailClearCalls;

	private bool _keepLaunchedState;

	protected bool _isSplitBall;

	private bool _launchedPrev;

	protected readonly string CameraShakeDataPath = "FX/PlayerFeedbackEffect/CameraShake_BreakOut_NormalBall";

	protected readonly string CameraShakeDataPath_fire = "FX/PlayerFeedbackEffect/CameraShake_BreakOut_FireBall";

	protected readonly string CameraShakeDataPath_out = "FX/PlayerFeedbackEffect/CameraShake_BreakOut_LoseBall";

	protected readonly string hitFx_fire = "fx_common_hit_fire_burning";

	protected readonly FP CameraShakeCd_fire = 0.5f;

	protected Dictionary<long, FP> _hitedEntities = new Dictionary<long, FP>(10);

	protected AdventurePlayerFeedbackEffectConfigureData feedBackData_normal;

	protected AdventurePlayerFeedbackEffectConfigureData feedBackData_fire;

	protected AdventurePlayerFeedbackEffectConfigureData feedBackData_out;

	private FP CameraShakeTriggerTime;

	private readonly FP minAngle = 20;

	private readonly FP maxAngle = 70;

	private readonly FP fixMinAngle = 10;

	private readonly FP fixMaxAngle = 20;

	private readonly FP rangeFix = 5;

	private readonly List<DeterministicRaycastHit> _sphereCandidates = new List<DeterministicRaycastHit>(8);

	private readonly DeterministicRaycastHit[] _probeHits = new DeterministicRaycastHit[3];

	private int _probeCount;

	private FP limit_paddleReflectAngle = 75;

	protected virtual FP read_initialSpeed => 13f;

	protected virtual FP normal_maxSpeed => 16f;

	protected virtual FP limitSpeed => 25f;

	protected virtual FP limitSpeed_inv => 32f;

	protected virtual FP minSpeed => 12f;

	protected virtual FP read_changeSpeed => 1.5f;

	protected virtual FP random_Angle => 5f;

	protected virtual FP _poy => 0.38f;

	public DeterministicCollider DtCollider { get; private set; }

	protected VisualSmooth Smooth { get; private set; }

	public bool BubbleConfineExempt { get; set; }

	protected virtual bool AffectedByLaunchState => true;

	protected virtual bool CanSpawnOnBouncePole => true;

	public HitBox Hit_Box { get; protected set; }

	protected AdventureActor Player => Singleton<BrickBreakerManager>.Instance.Actor;

	protected int UniqueAttackId
	{
		get
		{
			if (SceneSingleton<AdventurePlayerController>.Instance != null)
			{
				return SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
			}
			return 0;
		}
	}

	protected virtual bool PassThroughOnHit()
	{
		return false;
	}

	protected virtual bool ExplodeOnHit()
	{
		return false;
	}

	protected virtual void OnExplodeConsumed()
	{
	}

	protected virtual void OnHitTarget(TSVector2 hitPoint)
	{
	}

	protected virtual bool IsLightningBall()
	{
		return false;
	}

	protected virtual void OnActiveSkin()
	{
	}

	protected virtual void OnResetOnPaddleSkin()
	{
	}

	protected virtual void RegisterBornImmune()
	{
	}

	protected virtual bool TryConsumeOutAreaImmune(bool cost)
	{
		return false;
	}

	protected virtual void ClearOutAreaImmune()
	{
	}

	protected abstract void RegisterToManager();

	protected abstract void HitTarget(ref DeterministicRaycastHit raycastHit);

	protected abstract void HandleOutAreaDeath();

	protected override void OnInit()
	{
		startPosition = tsTransform.Position;
		tsTransform.PositionY = -999;
		useMaxSpeed = false;
		hasReflect = false;
		DeterministicCollider dtCollider = null;
		this.SetDeterministicCollider(ref collider, ref dtCollider);
		DtCollider = dtCollider;
		gameObject.layer = 23;
		Smooth = AddOrGetMonoLogicComponent<VisualSmooth>();
		OnHitDataInit();
		CacheTrailRenderers();
		RegisterToManager();
	}

	protected override void OnDeactive()
	{
		tsTransform.transformSyncEnabled = true;
		ClearOutAreaImmune();
		DisableLogicUpdate();
	}

	protected override void OnShutdown()
	{
	}

	private int GetBallHitLayMask(int index)
	{
		return index switch
		{
			1 => 4264192, 
			2 => 256, 
			3 => 4263936, 
			_ => 4264192, 
		};
	}

	public void OnLogicUpdate(FP LogicDeltaTime)
	{
		TickTeleportTrailHide();
		if (!_isSplitBall)
		{
			Singleton<BrickBreakerManager>.Instance.SetBallBornCD(waitResTime > 0);
			waitResTime -= LogicDeltaTime;
			if (Singleton<BrickBreakerManager>.Instance.InBornCD)
			{
				return;
			}
		}
		if (AffectedByLaunchState && !Singleton<BrickBreakerManager>.Instance.IsLaunched)
		{
			_launchedPrev = false;
			if (!_isSplitBall)
			{
				FP x = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider.tsTransform.Position.x;
				tsTransform.Position = new TSVector2(x, startPosition.y);
				tsTransform.PositionY = _poy;
			}
			return;
		}
		if (!_launchedPrev)
		{
			_launchedPrev = true;
			if (!_isSplitBall)
			{
				PlayBallShootSound();
				if (Singleton<BrickBreakerManager>.Instance.HasHuntingChain)
				{
					moveDirection = Singleton<BrickBreakerManager>.Instance.GetHuntingChainReflect(tsTransform.Position);
				}
			}
		}
		outArea = false;
		hitPaddle = false;
		if (Singleton<BrickBreakerManager>.Instance.InvincibleStar)
		{
			bool invstarOnDisable = Singleton<BrickBreakerManager>.Instance.invstarOnDisable;
			if (delInvSpeed <= 0 && !invstarOnDisable)
			{
				delInvSpeed = limitSpeed_inv - I_Speed;
				if (I_Speed <= 0)
				{
					delInvSpeed = limitSpeed_inv - read_initialSpeed;
				}
				delInvSpeed /= Singleton<BrickBreakerManager>.Instance.disableTime;
				elapsedDisableTime = 0;
			}
			currentSpeed = limitSpeed_inv;
			if (invstarOnDisable)
			{
				if (delInvSpeed > 0)
				{
					elapsedDisableTime += LogicDeltaTime;
					currentSpeed -= elapsedDisableTime * delInvSpeed;
				}
				else
				{
					currentSpeed = read_initialSpeed;
				}
			}
		}
		else
		{
			delInvSpeed = 0;
			currentSpeed = read_initialSpeed + chSpeed;
			currentSpeed += Singleton<BrickBreakerManager>.Instance.GetBouncePoleAddSpeed(this);
			if (Singleton<BrickBreakerManager>.Instance.HaveSpeedBandForBall(this))
			{
				currentSpeed += Singleton<BrickBreakerManager>.Instance.GetSpeedBandSpeedDelta(this, currentSpeed, minSpeed, limitSpeed);
			}
			if (currentSpeed < normal_maxSpeed && hasReflect)
			{
				chSpeed += read_changeSpeed;
				currentSpeed += read_changeSpeed;
			}
			currentSpeed = TSMath.Clamp(currentSpeed, minSpeed, limitSpeed);
		}
		if (useMaxSpeed)
		{
			currentSpeed = limitSpeed_inv;
		}
		FP fP = currentSpeed * LogicDeltaTime;
		TSVector2 moveData = moveDirection * fP;
		if (Singleton<BrickBreakerManager>.Instance.HaveBlackHoleForBall(this))
		{
			(moveDirection, fP) = Singleton<BrickBreakerManager>.Instance.CaculateGriavityDirAndDis(this, ref moveData);
		}
		if (Singleton<BrickBreakerManager>.Instance.HavePortalTractionForBall(this))
		{
			(moveDirection, fP) = Singleton<BrickBreakerManager>.Instance.CaculateTractionDirAndDis(this, ref moveData);
		}
		TSVector2 origin = tsTransform.Position;
		TSVector2 direction = moveDirection.normalized;
		FP fP2 = fP;
		bool flag = false;
		hasReflect = false;
		if (PassThroughOnHit() && SceneSingleton<DeterministicCollisionManager>.Instance.SphereCast(ref origin, ref direction, out var hitInfo, fP2, DtCollider.Radius, GetBallHitLayMask(2)))
		{
			flag = true;
			HitTarget(ref hitInfo);
		}
		if (SphereCastHit(ref origin, ref direction, out var hitInfo2, fP2, DtCollider.Radius, GetBallHitLayMask(flag ? 3 : 5)))
		{
			CastReflect(hitInfo2, fP2, moveData);
		}
		else
		{
			tsTransform.Position += moveData;
		}
		if (!outArea)
		{
			Singleton<BrickBreakerManager>.Instance.ApplyBubbleConfine(this, origin);
			tsTransform.Forward = moveDirection;
			tsTransform.PositionY = _poy;
			CheckInPaddle();
		}
		CheckOutArea(fP2);
		I_Speed = currentSpeed;
	}

	private void PlayBallShootSound()
	{
		string soundName = (TryConsumeOutAreaImmune(cost: false) ? "char_16001_support_atk" : "mode_breakout_game_shootBall");
		MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(soundName);
		if (IsLightningBall())
		{
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_elec");
		}
	}

	private void CastReflect(DeterministicRaycastHit raycastHit, FP max_distance, TSVector2 moveDelta)
	{
		hasReflect = true;
		bool flag = false;
		int layer = raycastHit.collider.gameObject.layer;
		bool flag2 = false;
		FP fP = 0;
		Gear_BouncePole gear_BouncePole = null;
		switch (layer)
		{
		case 12:
			flag = true;
			OutAreaC(raycastHit.point, 0);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_game_hardBrick");
			break;
		case 8:
			if (ExplodeOnHit())
			{
				Singleton<BrickBreakerManager>.Instance.PlayBoomBall(transform.position);
				HitTarget(ref raycastHit);
				OnExplodeConsumed();
			}
			else
			{
				HitTarget(ref raycastHit);
			}
			OnHitTarget(raycastHit.collider.tsTransform.Position);
			if (raycastHit.collider.GetComponent<LogicEntity>() is AdventureActor entity && entity.IsDead())
			{
				hasReflect = false;
			}
			if (PassThroughOnHit())
			{
				hasReflect = false;
			}
			break;
		case 16:
			HitTarget(ref raycastHit);
			OnHitTarget(raycastHit.collider.tsTransform.Position);
			if (PassThroughOnHit())
			{
				hasReflect = false;
			}
			break;
		case 22:
		{
			Gear_BouncePole gear_BouncePole2 = Singleton<BrickBreakerManager>.Instance.IsGearBouncePole(this, raycastHit);
			if (gear_BouncePole2 != null)
			{
				gear_BouncePole = gear_BouncePole2;
				gear_BouncePole2.PlayHitFx();
				gear_BouncePole2.PlayAnim();
				break;
			}
			hitPaddle = true;
			flag2 = FP.Approximately(raycastHit.normal.GetAngle(), 0);
			if (flag2)
			{
				fP = Singleton<BrickBreakerManager>.Instance.GetPaddleColliderIndex(raycastHit);
			}
			OutAreaC(raycastHit.point, actorOffset);
			string currentPaddleFx = Singleton<BrickBreakerManager>.Instance.Paddle.GetCurrentPaddleFx();
			PaddleCollider currentPaddleCollider = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider;
			Singleton<BrickBreakerManager>.Instance.PlayBrickFx(currentPaddleFx, currentPaddleCollider.transform.position, currentPaddleCollider.transform);
			Vector3 pos = new Vector3((float)raycastHit.point.x, 1f, (float)raycastHit.point.y);
			Singleton<BrickBreakerManager>.Instance.PlayBrickFx("fx_breakout_paddie_hit", pos);
			PlayBallShootSound();
			Singleton<BrickBreakerManager>.Instance.OnBallCaughtByPaddle();
			break;
		}
		default:
			hasReflect = false;
			break;
		}
		if (hasReflect)
		{
			FP fP2 = TSMath.Max(max_distance - raycastHit.distance, 0);
			TSVector2 tSVector = TSVector2.Reflect(moveDirection, raycastHit.normal).normalized;
			if (hitPaddle && !flag2)
			{
				tSVector = Singleton<BrickBreakerManager>.Instance.GetPalldeFixReflect(tsTransform.Position.x);
			}
			else
			{
				if (!flag & flag2)
				{
					fP += TSRandom.Range(-random_Angle, random_Angle);
				}
				if (fP != 0)
				{
					tSVector = TSVector2.Rotate(tSVector, fP);
				}
				if (hitPaddle)
				{
					tSVector = FixPaddleReflectAngle(tSVector);
				}
				tSVector = RepeatWallAngleFix(flag, tSVector, raycastHit.normal, hitPaddle);
			}
			if (hitPaddle && Singleton<BrickBreakerManager>.Instance.HasHuntingChain)
			{
				tSVector = Singleton<BrickBreakerManager>.Instance.GetHuntingChainReflect(tsTransform.Position);
			}
			TSVector2 origin = raycastHit.point;
			if (fP2 > 0 && !SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref tSVector, out raycastHit, fP2, 4264192))
			{
				origin += tSVector * fP2;
			}
			tsTransform.Position = origin;
			moveDirection = tSVector;
			if (gear_BouncePole != null && CanSpawnOnBouncePole)
			{
				Singleton<BrickBreakerManager>.Instance.SpawnBallFromBouncePole(gear_BouncePole, origin, tSVector, this);
			}
		}
		else
		{
			tsTransform.Position += moveDelta;
		}
	}

	private void CheckInPaddle()
	{
		if (outArea || hitPaddle)
		{
			return;
		}
		if (Singleton<BrickBreakerManager>.Instance.IsBallInPaddle(tsTransform.Position, DtCollider.Radius))
		{
			inPaddleCount++;
			if (inPaddleCount > 9)
			{
				moveDirection = TSVector2.up;
			}
			else
			{
				moveDirection = Singleton<BrickBreakerManager>.Instance.GetPalldeFixReflect(tsTransform.Position.x);
			}
			return;
		}
		if (inPaddleCount > 0)
		{
			Singleton<BrickBreakerManager>.Instance.OnBallCaughtByPaddle();
		}
		inPaddleCount = 0;
		if (!Singleton<BrickBreakerManager>.Instance.InvincibleStar)
		{
			DeterministicCollider dtcollider = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider.dtcollider;
			FP fP = dtcollider.tsTransform.Position.x - dtcollider.ColliderWidth / 2;
			FP fP2 = dtcollider.tsTransform.Position.x + dtcollider.ColliderWidth / 2;
			FP fP3 = dtcollider.tsTransform.Position.y - dtcollider.ColliderLength / 2;
			FP fP4 = dtcollider.tsTransform.Position.y + dtcollider.ColliderLength / 2;
			if (tsTransform.Position.x > fP + DtCollider.Radius && tsTransform.Position.x < fP2 - DtCollider.Radius && tsTransform.Position.y > fP3 + DtCollider.Radius && tsTransform.Position.y < fP4 - DtCollider.Radius)
			{
				outArea = true;
				tsTransform.PositionY = -999;
				Singleton<BrickBreakerManager>.Instance.PlayBrickFx(ballFx_outArea, new Vector3((float)tsTransform.Position.x, 0.5f, (float)tsTransform.Position.y));
			}
		}
	}

	private void OutAreaC(TSVector2 pos, FP offsetY)
	{
		if (!(Singleton<BrickBreakerManager>.Instance.Actor == null) && !Singleton<BrickBreakerManager>.Instance.InvincibleStar && !useMaxSpeed && pos.y < Singleton<BrickBreakerManager>.Instance.Actor.tsTransform.Position.y + offsetY)
		{
			outArea = true;
			tsTransform.PositionY = -999;
			Singleton<BrickBreakerManager>.Instance.PlayBrickFx(ballFx_outArea, new Vector3((float)pos.x, 0.5f, (float)pos.y));
		}
	}

	private void CheckOutArea(FP move_distance)
	{
		if (!Singleton<BrickBreakerManager>.Instance.CheckInArea(tsTransform.Position))
		{
			moveDirection = (TSVector2.zero - tsTransform.Position).normalized;
			tsTransform.Position += moveDirection * move_distance;
			int num = 0;
			while (num < 3 && !Singleton<BrickBreakerManager>.Instance.CheckInArea(tsTransform.Position, contSize: true))
			{
				num++;
				moveDirection = (TSVector2.zero - tsTransform.Position).normalized;
				tsTransform.Position += moveDirection * move_distance;
			}
			return;
		}
		if (moveDirection == TSVector2.zero)
		{
			moveDirection = TSVector2.up;
		}
		if (useMaxSpeed || Singleton<BrickBreakerManager>.Instance.InvincibleStar || !outArea)
		{
			return;
		}
		if (TryConsumeOutAreaImmune(cost: true))
		{
			outArea = false;
			moveDirection = (TSVector2.zero - tsTransform.Position).normalized;
			if (moveDirection == TSVector2.zero)
			{
				moveDirection = TSVector2.up;
			}
			tsTransform.Position += moveDirection * move_distance;
			tsTransform.Forward = moveDirection;
			tsTransform.PositionY = _poy;
		}
		else
		{
			HandleOutAreaDeath();
		}
	}

	public void PlayFeedBack_out()
	{
		feedBackData_out?.Play(transform.position, gameObject, 2);
	}

	public void ResetOnPaddle(bool init = false)
	{
		if (!init)
		{
			waitResTime = ballResetTime;
		}
		currentSpeed = 0;
		chSpeed = 0;
		hasReflect = false;
		delInvSpeed = 0;
		elapsedDisableTime = 0;
		TrueSyncTransform trueSyncTransform = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider.tsTransform;
		tsTransform.Position = new TSVector2(trueSyncTransform.Position.x, startPosition.y);
		moveDirection = TSVector2.up;
		tsTransform.Forward = moveDirection;
		tsTransform.PositionY = -999;
		BubbleConfineExempt = false;
		ClearOutAreaImmune();
		OnResetOnPaddleSkin();
		RegisterBornImmune();
		if (!init)
		{
			Singleton<BrickBreakerManager>.Instance.PlayBrickFx(ballFx_reset, trueSyncTransform.transform.position, trueSyncTransform.transform);
		}
	}

	public float GetCurrentSpeed()
	{
		return currentSpeed.AsFloat();
	}

	public FP GetChSpeed()
	{
		return chSpeed;
	}

	public void SetChSpeed(FP chSpd)
	{
		chSpeed = chSpd;
	}

	public void SetMaxSpeed(int pam)
	{
		if (pam == 0)
		{
			useMaxSpeed = false;
		}
		else
		{
			useMaxSpeed = true;
		}
	}

	public TSVector2 GetMoveDirection()
	{
		return moveDirection;
	}

	public void SetMoveDirection(TSVector2 dir)
	{
		moveDirection = dir;
		tsTransform.Forward = moveDirection;
	}

	private void CacheTrailRenderers()
	{
		_teleportPsList.Clear();
		_teleportPsRendererList.Clear();
		if (trailParticles == null)
		{
			NovaLogger.Error("[拖尾消影] trailParticles 未在预制体上拖拽配置");
			return;
		}
		for (int i = 0; i < trailParticles.Length; i++)
		{
			ParticleSystem particleSystem = trailParticles[i];
			if (particleSystem == null)
			{
				NovaLogger.Error($"[拖尾消影] trailParticles[{i}] 为空,请检查预制体拖拽");
				continue;
			}
			_teleportPsList.Add(particleSystem);
			ParticleSystemRenderer component = particleSystem.GetComponent<ParticleSystemRenderer>();
			if (component != null)
			{
				_teleportPsRendererList.Add(component);
			}
		}
	}

	public void OnTeleported()
	{
		if (LOG_TELEPORT_TRAIL_COST)
		{
			_trailCostSw.Restart();
			_teleportTrailTotalMs = 0.0;
			_teleportTrailClearCalls = 0;
		}
		BubbleConfineExempt = true;
		Smooth?.SyncDeterministicTransform();
		ClearTrailVertices();
		SetTrailRenderersEnabled(enabled: false);
		_teleportHideFrames = 3;
		if (LOG_TELEPORT_TRAIL_COST)
		{
			_trailCostSw.Stop();
			double totalMilliseconds = _trailCostSw.Elapsed.TotalMilliseconds;
			_teleportTrailTotalMs += totalMilliseconds;
			NovaLogger.Error($"[拖尾消影] OnTeleported 首帧: {totalMilliseconds:F3}ms | 粒子系统数={_teleportPsList.Count} 渲染器数={_teleportPsRendererList.Count} | Clear×1 关渲染×1");
		}
	}

	private void ClearTrailVertices()
	{
		for (int i = 0; i < _teleportPsList.Count; i++)
		{
			if (_teleportPsList.get_Item(i) != null)
			{
				_teleportPsList.get_Item(i).Clear(withChildren: true);
			}
		}
	}

	private void SetTrailRenderersEnabled(bool enabled)
	{
		for (int i = 0; i < _teleportPsRendererList.Count; i++)
		{
			if (_teleportPsRendererList.get_Item(i) != null)
			{
				_teleportPsRendererList.get_Item(i).enabled = enabled;
			}
		}
	}

	private void TickTeleportTrailHide()
	{
		if (_teleportHideFrames <= 0)
		{
			return;
		}
		if (LOG_TELEPORT_TRAIL_COST)
		{
			_trailCostSw.Restart();
		}
		ClearTrailVertices();
		_teleportHideFrames--;
		if (_teleportHideFrames <= 0)
		{
			SetTrailRenderersEnabled(enabled: true);
		}
		if (LOG_TELEPORT_TRAIL_COST)
		{
			_trailCostSw.Stop();
			double totalMilliseconds = _trailCostSw.Elapsed.TotalMilliseconds;
			_teleportTrailTotalMs += totalMilliseconds;
			_teleportTrailClearCalls++;
			NovaLogger.Error($"[拖尾消影] 窗口帧 (剩余{_teleportHideFrames}): {totalMilliseconds:F3}ms");
			if (_teleportHideFrames <= 0)
			{
				NovaLogger.Error($"[拖尾消影] 本次传送累计: {_teleportTrailTotalMs:F3}ms (Clear×{_teleportTrailClearCalls + 1}, 窗口{3}帧)");
			}
		}
	}

	public void Active()
	{
		OnActive();
	}

	public void SetLaunchedState(bool launched)
	{
		_keepLaunchedState = launched;
	}

	public bool IsSplitBall()
	{
		return _isSplitBall;
	}

	protected override void OnActive()
	{
		Smooth?.OnActive();
		Smooth?.SyncDeterministicTransform();
		tsTransform.transformSyncEnabled = false;
		tsTransform.PositionY = _poy;
		inPaddleCount = 0;
		EnableLogicUpdate();
		if (!_isSplitBall)
		{
			OnActiveSkin();
			delInvSpeed = 0;
			elapsedDisableTime = 0;
		}
		waitResTime = 0;
		if (!_isSplitBall)
		{
			Singleton<BrickBreakerManager>.Instance.SetBallBornCD(waitResTime > 0);
		}
		if (!_keepLaunchedState && !_isSplitBall)
		{
			Singleton<BrickBreakerManager>.Instance.BallLaunchState(launch: false, init: true);
		}
	}

	protected void OnHitDataInit()
	{
		Hit_Box = HitBox.Setup(gameObject, this, this);
		feedBackData_normal = GetCameraShakeData(CameraShakeDataPath);
		feedBackData_fire = GetCameraShakeData(CameraShakeDataPath_fire);
		feedBackData_out = GetCameraShakeData(CameraShakeDataPath_out);
		CameraShakeTriggerTime = 0;
	}

	protected AdventurePlayerFeedbackEffectConfigureData GetCameraShakeData(string path)
	{
		if (!string.IsNullOrEmpty(path))
		{
			string assetName = "Assets/AssetBundles/" + path + ".asset";
			return GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(AdventurePlayerFeedbackEffectConfigureData)) as AdventurePlayerFeedbackEffectConfigureData;
		}
		return null;
	}

	protected virtual void ChangeHitId()
	{
	}

	public FP QueryHitBoxContextTime()
	{
		return LogicTime;
	}

	public TSVector2 QueryHitBoxContextPosition()
	{
		return tsTransform.Position;
	}

	public TSVector2 QueryHitBoxContextDirection()
	{
		return tsTransform.Forward;
	}

	public bool QueryActorHitedTimeout(long entityId, FP timeout)
	{
		if (_hitedEntities.TryGetValue(entityId, out var value) && LogicTime <= value + timeout)
		{
			return false;
		}
		return true;
	}

	public void SetActorHitedTime(long entityId, FP time)
	{
		_hitedEntities.set_Item(entityId, time);
	}

	public bool CheckHitable(HitBox hitBox, LogicEntity entity)
	{
		if (!(Player == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !Player.IsConfrontWith(entity))
		{
			return Player.IsNeutralWith(entity);
		}
		return true;
	}

	public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (Player == null)
		{
			return false;
		}
		if (!entity.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		(damaged, _, _) = (entity as AdventureActor).Damage(Player, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (Player == null)
		{
			return false;
		}
		AdventureActor component = actor.GetComponent<AdventureActor>();
		if (!component.CurrentStepCanbeHurt() && !ExplodeOnHit())
		{
			return true;
		}
		MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(PassThroughOnHit() ? "" : "mode_breakout_game_brickBreak");
		(damaged, _, _) = component.Damage(Player, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		if (PassThroughOnHit())
		{
			if (CameraShakeTriggerTime <= 0 || LogicTime - CameraShakeTriggerTime > CameraShakeCd_fire)
			{
				CameraShakeTriggerTime = LogicTime;
				feedBackData_fire?.Play(transform.position, gameObject, 2);
			}
			Singleton<BrickBreakerManager>.Instance?.PlayBrickFx(hitFx_fire, transform.position);
		}
		else
		{
			feedBackData_normal?.Play(transform.position, gameObject, 2);
		}
		return true;
	}

	private void OnHitCollider(ref TSVector2 origin, ref TSVector2 direction, FP maxDistance, FP radius, ref DeterministicRaycastHit hitInfo, ref DeterministicRaycastHit otherHitInfo)
	{
		hitInfo.normal = otherHitInfo.normal;
		FP fP = 0;
		FP fP2 = maxDistance;
		bool flag = false;
		for (int i = 0; i < 4; i++)
		{
			fP2 *= (FP)0.5;
			fP = (flag ? (fP - fP2) : (fP + fP2));
			flag = SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlapCollider(radius, origin + fP * direction, hitInfo.collider);
			if (fP2 < 0.03)
			{
				break;
			}
		}
		if (flag)
		{
			fP -= fP2;
		}
		hitInfo.distance = fP;
		hitInfo.point = origin + direction * hitInfo.distance;
	}

	private bool SphereCastHit(ref TSVector2 origin, ref TSVector2 direction, out DeterministicRaycastHit hitInfo, FP maxDistance, FP radius, int layerMask = -5)
	{
		hitInfo = new DeterministicRaycastHit
		{
			isValid = false
		};
		FP maxDistance2 = maxDistance + radius;
		TSVector2 direction2 = direction.normalized;
		TSVector2 tSVector = new TSVector2(direction2.y, -direction2.x);
		TSVector2 origin2 = origin + direction * radius;
		SceneSingleton<DeterministicCollisionManager>.Instance.SphereCastAll(ref origin2, ref direction, _sphereCandidates, maxDistance - radius, radius, layerMask);
		if (_sphereCandidates.Count <= 0)
		{
			return false;
		}
		hitInfo = _sphereCandidates.get_Item(0);
		_probeCount = 0;
		for (int i = 0; i < 3; i++)
		{
			TSVector2 origin3 = i switch
			{
				1 => origin + tSVector * radius, 
				0 => origin, 
				_ => origin - tSVector * radius, 
			};
			if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin3, ref direction2, out var hitInfo2, maxDistance2, layerMask))
			{
				_probeHits[_probeCount++] = hitInfo2;
				if (hitInfo2.collider == hitInfo.collider)
				{
					OnHitCollider(ref origin, ref direction2, maxDistance, radius, ref hitInfo, ref hitInfo2);
					return true;
				}
			}
		}
		for (int j = 0; j < _probeCount; j++)
		{
			DeterministicRaycastHit otherHitInfo = _probeHits[j];
			if (IsSphereCandidate(otherHitInfo.collider))
			{
				hitInfo.collider = otherHitInfo.collider;
				hitInfo.isValid = true;
				OnHitCollider(ref origin, ref direction2, maxDistance, radius, ref hitInfo, ref otherHitInfo);
				return true;
			}
		}
		return false;
	}

	private bool IsSphereCandidate(DeterministicCollider collider)
	{
		if (collider == null)
		{
			return false;
		}
		for (int i = 0; i < _sphereCandidates.Count; i++)
		{
			if (_sphereCandidates.get_Item(i).collider == collider)
			{
				return true;
			}
		}
		return false;
	}

	private TSVector2 FixPaddleReflectAngle(TSVector2 reflectDirection)
	{
		FP angle = reflectDirection.GetAngle();
		if (angle < -limit_paddleReflectAngle)
		{
			return TSVector2.Rotate(reflectDirection, -limit_paddleReflectAngle - angle);
		}
		if (angle > limit_paddleReflectAngle)
		{
			return TSVector2.Rotate(reflectDirection, limit_paddleReflectAngle - angle);
		}
		return reflectDirection;
	}

	private bool InAngleArea(FP angle, FP angleA, FP angleB)
	{
		if (angle >= angleA)
		{
			return angle <= angleB;
		}
		return false;
	}

	private FP GetRandomAngle(FP angle, FP angleMin, FP angleMax)
	{
		if (angle < angleMin)
		{
			return TSRandom.Range(fixMinAngle, fixMaxAngle);
		}
		if (angle > angleMax)
		{
			return -TSRandom.Range(fixMinAngle, fixMaxAngle);
		}
		return 0;
	}

	private TSVector2 RepeatWallAngleFix(bool hitWall, TSVector2 reflectDirection, TSVector2 normal, bool hitPaddle)
	{
		if (useMaxSpeed & hitPaddle)
		{
			hitWall = true;
		}
		FP fP = 0;
		if (hitWall)
		{
			wallIndex++;
			if (wallIndex > wallFixTime)
			{
				FP angle = reflectDirection.GetAngle();
				FP angle2 = normal.GetAngle();
				if (FP.Approximately(angle2, 0))
				{
					fP = ((!InAngleArea(angle, -180f, 0f)) ? GetRandomAngle(angle, minAngle, maxAngle) : GetRandomAngle(angle, -maxAngle, -minAngle));
				}
				else if (FP.Approximately(angle2, 180))
				{
					fP = ((!InAngleArea(angle, 0f, 180f)) ? GetRandomAngle(angle, -90f - maxAngle, -90f - minAngle) : GetRandomAngle(angle, 90f + minAngle, 90f + maxAngle));
				}
				else if (FP.Approximately(angle2, 90))
				{
					fP = ((!InAngleArea(angle, -90f, 90f)) ? GetRandomAngle(angle, 90f + minAngle, 90f + maxAngle) : GetRandomAngle(angle, minAngle, maxAngle));
				}
				else if (FP.Approximately(angle2, -90))
				{
					fP = ((!InAngleArea(angle, -90f, 90f)) ? GetRandomAngle(angle, -90f - maxAngle, -90f - minAngle) : GetRandomAngle(angle, -maxAngle, -minAngle));
				}
				if (fP == 0)
				{
					fP = TSRandom.Range(-rangeFix, rangeFix);
				}
				return TSVector2.Rotate(reflectDirection, fP);
			}
		}
		else
		{
			wallIndex = 0;
		}
		return reflectDirection;
	}
}
