#define LOG_ERROR
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

public class Brick_Paddle : LogicEntity, IDeterministicCollisionListener
{
	public class PaddleAngleData
	{
		public FP SpacePercent;

		public FP AngleFix;
	}

	protected readonly FP moveSpeed = 23;

	protected readonly FP xLimit = 11.5f;

	protected readonly TSVector2 actorOffeset = new TSVector2(0, 1);

	protected readonly FP posy = 0.2f;

	protected readonly List<PaddleAngleData> AngleFix_Datas = new List<PaddleAngleData>
	{
		new PaddleAngleData
		{
			SpacePercent = 20,
			AngleFix = 30
		},
		new PaddleAngleData
		{
			SpacePercent = 20,
			AngleFix = 15
		},
		new PaddleAngleData
		{
			SpacePercent = 20,
			AngleFix = 0
		},
		new PaddleAngleData
		{
			SpacePercent = 20,
			AngleFix = -15
		},
		new PaddleAngleData
		{
			SpacePercent = 20,
			AngleFix = -30
		}
	};

	protected readonly List<string> fx_Paddle = new List<string> { "fx_breakout_paddie_light_7m", "fx_breakout_paddie_light_9m", "fx_breakout_paddie_light_5m" };

	protected readonly List<string> fx_Paddle_Keep = new List<string> { "7m", "9m", "5m" };

	protected readonly List<string> fx_Paddle_Change = new List<string> { "fx_breakout_paddie_reset_7m", "fx_breakout_paddie_change_long_7m_to_9m", "fx_breakout_paddie_change_long_7m_to_5m" };

	protected int currentIndex;

	private TSVector2 currentPaddlePos;

	public List<PaddleCollider> cPaddles = new List<PaddleCollider>(3);

	public PaddleCollider_Ch LeftCollider;

	public PaddleCollider_Ch RightCollider;

	private FP currentSpeed;

	protected override void OnInit()
	{
		Singleton<BrickBreakerManager>.Instance.InitPaddle(this);
		currentPaddlePos = TSVector2.zero;
		currentIndex = 0;
		currentSpeed = moveSpeed;
	}

	public void ChangeSpeed(FP speed)
	{
		currentSpeed = speed;
	}

	public void ResetSpeed()
	{
		currentSpeed = moveSpeed;
	}

	private PaddleCollider GetInitPaddle(string paddleName)
	{
		Transform transform = base.transform.Find(paddleName);
		if (transform == null)
		{
			NovaLogger.Error("打砖块移动版名称配置错误==" + paddleName);
			return null;
		}
		return transform.gameObject.AddOrGetComponent<PaddleCollider>();
	}

	protected override void OnActive()
	{
		SwitchPaddle(0, init: true);
	}

	protected override void OnDeactive()
	{
	}

	protected override void OnShutdown()
	{
	}

	public void OnLogicUpdate(FP LogicDeltaTime)
	{
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection().x * currentSpeed * LogicDeltaTime * TSVector2.right;
		PaddleCollider currentPaddleCollider = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider;
		Singleton<BrickBreakerManager>.Instance.paddle_FramBeginPosX = currentPaddleCollider.tsTransform.Position.x;
		currentPaddlePos = currentPaddleCollider.tsTransform.Position + tSVector;
		currentPaddlePos.x = TSMath.Clamp(currentPaddlePos.x, -xLimit, xLimit);
		currentPaddleCollider.tsTransform.Position = currentPaddlePos;
		LeftCollider.tsTransform.Position = currentPaddlePos + currentPaddleCollider.GetOffsetPos(iLeft: true);
		RightCollider.tsTransform.Position = currentPaddlePos + currentPaddleCollider.GetOffsetPos(iLeft: false);
		if (Singleton<BrickBreakerManager>.Instance.Actor != null)
		{
			Singleton<BrickBreakerManager>.Instance.Actor.tsTransform.Position = currentPaddlePos + actorOffeset;
			Singleton<BrickBreakerManager>.Instance.Actor.tsTransform.PositionY = posy;
		}
		for (int i = 0; i < cPaddles.Count; i++)
		{
			if (currentIndex != i)
			{
				cPaddles.get_Item(i).transform.position = new Vector3((float)currentPaddlePos.x, 0f, (float)currentPaddlePos.y);
			}
		}
		currentPaddleCollider.dtcollider.ColliderSync();
		LeftCollider.dtcollider.ColliderSync();
		RightCollider.dtcollider.ColliderSync();
		List<DropEntity> dropsList = SceneSingleton<DropsManager>.Instance._dropsList;
		if (dropsList != null && dropsList.Count > 0)
		{
			for (int j = 0; j < SceneSingleton<DropsManager>.Instance._dropsList.Count; j++)
			{
				if (SceneSingleton<DropsManager>.Instance._dropsList.get_Item(j) is BrickDrop brickDrop)
				{
					brickDrop.dtCollider.ColliderSync();
					SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, currentPaddleCollider.dtcollider, brickDrop.dtCollider, duplex: false);
					SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, LeftCollider.dtcollider, brickDrop.dtCollider, duplex: false);
					SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, RightCollider.dtcollider, brickDrop.dtCollider, duplex: false);
				}
			}
		}
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if ((object)instance == null || instance.weapons.Count <= 0)
		{
			return;
		}
		for (int k = 0; k < ModuleController<AdventureModuleController>.Instance.weapons.Count; k++)
		{
			if (ModuleController<AdventureModuleController>.Instance.weapons.get_Item(k) is AdventureBulletBase adventureBulletBase)
			{
				adventureBulletBase.dtCollider.ColliderSync();
				SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, currentPaddleCollider.dtcollider, adventureBulletBase.dtCollider, duplex: false);
				SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, LeftCollider.dtcollider, adventureBulletBase.dtCollider, duplex: false);
				SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, RightCollider.dtcollider, adventureBulletBase.dtCollider, duplex: false);
			}
		}
	}

	public void SwitchPaddle(int index, bool init = false)
	{
		if (cPaddles.Count >= 1 && index >= 0 && index < cPaddles.Count)
		{
			for (int i = 0; i < cPaddles.Count; i++)
			{
				cPaddles.get_Item(i).ActiveSelf = index == i;
			}
			currentIndex = index;
			if (!init && fx_Paddle_Change.Count > index)
			{
				Transform transform = Singleton<BrickBreakerManager>.Instance.CurrentPaddleCollider.transform;
				Singleton<BrickBreakerManager>.Instance.PlayBrickFx(fx_Paddle_Change.get_Item(index), transform.position, transform);
			}
		}
	}

	public string GetCurrentPaddleFx()
	{
		if (fx_Paddle.Count > currentIndex)
		{
			return fx_Paddle.get_Item(currentIndex);
		}
		return null;
	}

	public string GetCurrentPaddleFx_Keep()
	{
		if (fx_Paddle_Keep.Count > currentIndex)
		{
			return fx_Paddle_Keep.get_Item(currentIndex);
		}
		return null;
	}

	public FP GetFixAngle(FP percent)
	{
		if (AngleFix_Datas == null || AngleFix_Datas.Count < 1)
		{
			return 0;
		}
		if (percent <= 0)
		{
			return AngleFix_Datas.get_Item(0).AngleFix;
		}
		if (percent >= 1)
		{
			List<PaddleAngleData> angleFix_Datas = AngleFix_Datas;
			return angleFix_Datas.get_Item(angleFix_Datas.Count - 1).AngleFix;
		}
		FP fP = 0;
		int index = 0;
		for (int i = 0; i < AngleFix_Datas.Count; i++)
		{
			fP += AngleFix_Datas.get_Item(i).SpacePercent / 100;
			if (percent <= fP)
			{
				index = i;
				break;
			}
		}
		return AngleFix_Datas.get_Item(index).AngleFix;
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		if (other.TryGetComponent<BrickDrop>(out var component))
		{
			component.Finish(isPick: true);
			return;
		}
		AdventureBulletBase component2 = other.GetComponent<AdventureBulletBase>();
		if (component2 != null && component2.owner != Singleton<BrickBreakerManager>.Instance.Actor)
		{
			if (component2 is AdventureBullet adventureBullet && adventureBullet.hitPrefab != null)
			{
				AdventureFXPlayer.PlayFX(adventureBullet.hitPrefab, 1f, component2.transform.position, component2.transform.rotation);
			}
			else if (component2 is AdventureProjectile adventureProjectile && adventureProjectile.hittedPrefab != null)
			{
				AdventureFXPlayer.PlayFX(adventureProjectile.hittedPrefab, 1f, component2.transform.position, component2.transform.rotation);
			}
			component2.Finish(cancel: true);
			Singleton<BrickBreakerManager>.Instance.UpdateLife(-1, fromHit: true);
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
	}

	public FP GetxLimt()
	{
		return xLimit;
	}

	private void TestButtonEvent()
	{
		if (Input.GetKeyDown(KeyCode.Q))
		{
			string fxAlias = "Misc/BreakOut/Gear/Gear_BouncePole_1";
			Singleton<BrickBreakerManager>.Instance.GetGearToScence(fxAlias, TSVector2.zero);
		}
		else if (Input.GetKey(KeyCode.Space))
		{
			if (!Singleton<BrickBreakerManager>.Instance.IsLaunched)
			{
				Singleton<BrickBreakerManager>.Instance.BallLaunchState(launch: true);
			}
		}
		else if (Input.GetKeyDown(KeyCode.E))
		{
			BrickActor actor = Singleton<BrickBreakerManager>.Instance.Actor;
			ILRuntimeAPI.CreateSkill(actor.mainSkillId, actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, null, (FP cd) =>
			{
			});
		}
	}
}
