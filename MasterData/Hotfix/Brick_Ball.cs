#define LOG_ERROR
using System.Collections.Generic;
using TrueSync;

public class Brick_Ball : Brick_BallBase
{
	public Brick_BallSkin[] BallSkin;

	public FP spawnInitialSpeed = 13f;

	public FP spawnNormalMaxSpeed = 16f;

	public FP spawnLimitSpeed = 25f;

	public FP spawnLimitSpeedInv = 32f;

	public FP spawnMinSpeed = 12f;

	public FP spawnChangeSpeed = 1.5f;

	public FP spawnRandomAngle = 5f;

	public FP spawnPoy = 0.38f;

	private Brick_BallSkin currentSkin;

	private int _outAreaImmuneCount;

	private AdventureFXPlayer _outAreaImmuneFx;

	private int _swordEnhanceCount;

	private string _swordEnhanceAreaFx;

	protected override FP read_initialSpeed => spawnInitialSpeed;

	protected override FP normal_maxSpeed => spawnNormalMaxSpeed;

	protected override FP limitSpeed => spawnLimitSpeed;

	protected override FP limitSpeed_inv => spawnLimitSpeedInv;

	protected override FP minSpeed => spawnMinSpeed;

	protected override FP read_changeSpeed => spawnChangeSpeed;

	protected override FP random_Angle => spawnRandomAngle;

	protected override FP _poy => spawnPoy;

	protected override void RegisterToManager()
	{
		Singleton<BrickBreakerManager>.Instance.InitBall(this, ref _isSplitBall);
	}

	protected override bool PassThroughOnHit()
	{
		return ICrossBall();
	}

	protected override bool ExplodeOnHit()
	{
		return IBoomBall();
	}

	protected override void OnExplodeConsumed()
	{
		SwitchBall(BrickBallType.Normal);
	}

	protected override void OnHitTarget(TSVector2 hitPoint)
	{
		if (_swordEnhanceCount > 0)
		{
			Singleton<BrickBreakerManager>.Instance.PlaySwordEnhanceArea(tsTransform.Position, _swordEnhanceAreaFx);
			_swordEnhanceCount--;
		}
		if (ILaserBall())
		{
			Singleton<BrickBreakerManager>.Instance.PlayLaserTriggerArea(hitPoint, currentSkin.ballType);
		}
	}

	protected override void OnActiveSkin()
	{
		SwitchBall(BrickBallType.Normal);
	}

	protected override void OnResetOnPaddleSkin()
	{
		_swordEnhanceCount = 0;
		if (currentSkin == null || currentSkin.resetToNormal)
		{
			SwitchBall(BrickBallType.Normal);
		}
	}

	protected override void RegisterBornImmune()
	{
		Singleton<BrickBreakerManager>.Instance.GrantBornImmuneIfActive(this);
	}

	public void SwitchBall(BrickBallType newBallType)
	{
		if (BallSkin == null)
		{
			return;
		}
		Brick_BallSkin brick_BallSkin = null;
		for (int i = 0; i < BallSkin.Length; i++)
		{
			if (BallSkin[i] != null && BallSkin[i].ballType == newBallType)
			{
				brick_BallSkin = BallSkin[i];
				break;
			}
		}
		if (brick_BallSkin == null)
		{
			NovaLogger.Error("SwitchBall: 未找到球类型对应的皮肤==" + newBallType);
			return;
		}
		for (int j = 0; j < BallSkin.Length; j++)
		{
			if (BallSkin[j] != null)
			{
				BallSkin[j].ActiveSelf = BallSkin[j] == brick_BallSkin;
			}
		}
		currentSkin = brick_BallSkin;
		ChangeHitId();
	}

	public bool ICrossBall()
	{
		if (currentSkin != null)
		{
			return currentSkin.ballType == BrickBallType.Fire;
		}
		return false;
	}

	public bool IBoomBall()
	{
		if (currentSkin != null)
		{
			return currentSkin.ballType == BrickBallType.Boom;
		}
		return false;
	}

	public bool ILaserBall()
	{
		if (currentSkin == null)
		{
			return false;
		}
		BrickBallType ballType = currentSkin.ballType;
		if ((uint)(ballType - 3) <= 5u)
		{
			return true;
		}
		return false;
	}

	protected override bool IsLightningBall()
	{
		if (currentSkin == null)
		{
			return false;
		}
		BrickBallType ballType = currentSkin.ballType;
		if (ballType == BrickBallType.Lightning || (uint)(ballType - 7) <= 1u)
		{
			return true;
		}
		return false;
	}

	protected override void HitTarget(ref DeterministicRaycastHit raycastHit)
	{
		if (!(Hit_Box == null))
		{
			Hit_Box.HitSingleTarget(UniqueAttackId, raycastHit.collider, out var _, out var _, ref raycastHit, currentSkin.hitBox.hurtEffectSource, currentSkin.skinIsHittedEffectScale, currentSkin.skinDamageImmuneDuration);
		}
	}

	protected override void ChangeHitId()
	{
		if (!(Hit_Box == null) && !(currentSkin == null) && !(currentSkin.hitBox == null))
		{
			Hit_Box.hitDamageId = currentSkin.skinHitId;
			Hit_Box.featureFlags = currentSkin.hitBox.featureFlags;
			Hit_Box.featureData = currentSkin.hitBox.featureData;
			Hit_Box.hurtAnimType = currentSkin.hitBox.hurtAnimType;
		}
	}

	protected override void HandleOutAreaDeath()
	{
		Singleton<BrickBreakerManager>.Instance.RemoveBall(this);
		Singleton<BrickBreakerManager>.Instance.RemoveAllBlackHoleForBall(this);
		Singleton<BrickBreakerManager>.Instance.RemoveAllSpeedBandForBall(this);
		List<Brick_Ball> energyBalls = Singleton<BrickBreakerManager>.Instance.GetEnergyBalls();
		if (energyBalls == null || energyBalls.Count == 0)
		{
			Singleton<BrickBreakerManager>.Instance.BallLaunchState(launch: false);
			Singleton<BrickBreakerManager>.Instance.SetBallBornCD(_value: true);
			Singleton<BrickBreakerManager>.Instance.UpdateLife(-1);
		}
		else
		{
			PlayFeedBack_out();
		}
	}

	public void GrantOutAreaImmune(int count, string fxName)
	{
		if (count > 0)
		{
			_outAreaImmuneCount = count;
			_outAreaImmuneFx?.Stop();
			_outAreaImmuneFx = null;
			if (!string.IsNullOrEmpty(fxName))
			{
				_outAreaImmuneFx = Singleton<BrickBreakerManager>.Instance.PlayBrickFx(fxName, transform.position, transform);
			}
		}
	}

	protected override bool TryConsumeOutAreaImmune(bool cost)
	{
		if (_outAreaImmuneCount <= 0)
		{
			return false;
		}
		if (cost)
		{
			_outAreaImmuneCount--;
		}
		if (_outAreaImmuneCount <= 0)
		{
			_outAreaImmuneFx?.Stop();
			_outAreaImmuneFx = null;
		}
		return true;
	}

	protected override void ClearOutAreaImmune()
	{
		_outAreaImmuneCount = 0;
		_outAreaImmuneFx?.Stop();
		_outAreaImmuneFx = null;
	}

	public void GrantSwordEnhance(int count, string areaFxKey)
	{
		if (count > 0)
		{
			_swordEnhanceCount += count;
			_swordEnhanceAreaFx = areaFxKey;
		}
	}

	public BrickBallType GetBallSkinType()
	{
		if (!(currentSkin != null))
		{
			return BrickBallType.Normal;
		}
		return currentSkin.ballType;
	}
}
