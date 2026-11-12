using TrueSync;
using UnityEngine;

public class Gear_BouncePole : GearBase
{
	public FP addSpeed = 5f;

	public FP accSpeed = 2f;

	public GameObject hittedEffectPrefab;

	public bool EnableSpawn;

	public GameObject SpawnBallPrefab;

	public FP randomRange;

	public bool enableOrbit;

	public TSVector2 orbitCenter;

	public FP orbitAngularSpeed = 60f;

	public bool orbitClockwise = true;

	public GameObject refX;

	private string animStr = "BreakOut_Catapult_push";

	private Animator anim;

	private FP _accSpeed;

	private TSVector2 _orbitRadiusVec;

	private AdventureActor _proximityTarget;

	private FP _proximityDistanceSqr;

	private FP _proximityExtraSpeed;

	public FP Add_Speed { get; private set; }

	protected override void OnInit()
	{
		base.OnInit();
		dtCollider.layer = 22;
		anim = GetComponentInChildren<Animator>();
	}

	protected override void OnActive()
	{
		if (enableOrbit)
		{
			_orbitRadiusVec = tsTransform.Position - orbitCenter;
			if (refX != null)
			{
				refX.SetActive(value: true);
			}
		}
		EnableLogicUpdate();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
	}

	protected override void OnShutdown()
	{
	}

	public TSVector2 GetSpawnDirection(TSVector2 dir)
	{
		if (randomRange <= 0)
		{
			return dir;
		}
		FP fP = randomRange / 2;
		FP fP2 = TSRandom.Range((fP < 1) ? (fP * 0.5) : ((FP)1), fP);
		FP fP3 = ((TSRandom.Range(0, 2) == 0) ? ((FP)(-1)) : ((FP)1));
		return TSVector2.Rotate(dir, fP2 * fP3).normalized;
	}

	public void PlayAnim()
	{
		anim?.Play(animStr);
	}

	public void PlayHitFx()
	{
		if (!(hittedEffectPrefab == null))
		{
			AdventureFXPlayer.PlayFX(hittedEffectPrefab, 1f, new Vector3((float)tsTransform.Position.x, 1f, (float)tsTransform.Position.y), transform.localRotation);
		}
	}

	public void AddSpeed()
	{
		Add_Speed += addSpeed;
		_accSpeed = FP.Abs(accSpeed);
	}

	protected override void OnLogicUpdate()
	{
		if (Add_Speed > 0)
		{
			FP fP = _accSpeed * LogicDeltaTime;
			Add_Speed -= fP;
			Add_Speed = ((Add_Speed < 0) ? ((FP)0) : Add_Speed);
		}
		UpdateOrbit();
	}

	public void SetProximitySpeedBoost(AdventureActor target, FP distance, FP extraAngularSpeed)
	{
		_proximityTarget = target;
		_proximityDistanceSqr = distance * distance;
		_proximityExtraSpeed = extraAngularSpeed;
	}

	private void UpdateOrbit()
	{
		if (enableOrbit)
		{
			FP fP = orbitAngularSpeed;
			if (_proximityTarget != null && !_proximityTarget.isDead && (_proximityTarget.tsTransform.Position - tsTransform.Position).LengthSquared() < _proximityDistanceSqr)
			{
				fP += _proximityExtraSpeed;
			}
			FP fP2 = fP * LogicDeltaTime;
			if (orbitClockwise)
			{
				fP2 = -fP2;
			}
			_orbitRadiusVec = TSVector2.Rotate(_orbitRadiusVec, fP2);
			tsTransform.Position = orbitCenter + _orbitRadiusVec;
			dtCollider.ColliderSync();
		}
	}
}
