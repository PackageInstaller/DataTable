using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/电球")]
[DisallowMultipleComponent]
public class ElectroBallEntity : LogicEntity, ISpecialEntity, IHitBoxContext
{
	private class ElectroBall
	{
		public AdventureActor owner;

		public FP duration;

		public TSVector2 position;

		public AdventureFXPlayer fxPlayer;

		public int hitDamageId;

		private bool _isInfinite;

		public bool isInfinite
		{
			get
			{
				return _isInfinite;
			}
			set
			{
				_isInfinite = value;
				if (_isInfinite)
				{
					duration = -1;
				}
			}
		}

		public bool IsFinish
		{
			get
			{
				if (!isInfinite)
				{
					return duration <= 0;
				}
				return false;
			}
		}

		public void Init(AdventureActor owner, GameObject fxPrefab, FP duration, int hitDamageId, bool isInfinite = false)
		{
			this.owner = owner;
			this.duration = duration;
			this.hitDamageId = hitDamageId;
			this.isInfinite = isInfinite;
			if (fxPrefab != null)
			{
				fxPlayer = AdventureFXPlayer.PlayFX(fxPrefab, 1f, new Vector3((float)position.x, 0f, (float)position.y), Quaternion.identity);
			}
		}

		public void SetPosition(TSVector2 position, FP positionY)
		{
			this.position = position;
			if (fxPlayer != null)
			{
				fxPlayer.transform.position = new Vector3((float)position.x, (float)positionY, (float)position.y);
			}
		}

		public void Update(FP duration, TSVector2 position, FP positionY)
		{
			this.duration = duration;
			if (IsFinish)
			{
				Stop();
			}
			else
			{
				SetPosition(position, positionY);
			}
		}

		public void Stop(bool forceStop = false)
		{
			Clear();
		}

		private void Clear()
		{
			owner = null;
			position = default;
			fxPlayer?.Stop();
			fxPlayer = null;
			duration = 0;
			hitDamageId = 0;
			isInfinite = false;
		}
	}

	public FP duration = 3f;

	public GameObject fx;

	public FP radius = 0.5f;

	public FP rotateSpeed = 60;

	public FP rotateRadius = 1;

	public int maxCount = 3;

	public int hitDamageId;

	public HitBox.FeatureFlag hitFlags;

	public HitBox.HitBoxFeatureData hitFeatureData;

	public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

	public GameObject hittedEffectPrefab;

	public bool isHittedEffectScale = true;

	public bool effectIgnoreTimeScale = true;

	public FP damageImmuneDuration;

	private HitBox _hitBox;

	private readonly int _hitLayer = 256;

	private AdventureActor _owner;

	private AdventureActor _attackActor;

	private List<ElectroBall> _electroBallPool = new List<ElectroBall>(10);

	private List<ElectroBall> _electroBalls = new List<ElectroBall>(10);

	protected Dictionary<long, FP> _hitedEntities = new Dictionary<long, FP>(10);

	private bool NeedUpdate => _electroBalls.Count > 0;

	public int ElectroBallCount => _electroBalls.Count;

	public AdventureActor Owner => _owner;

	protected override void OnInit()
	{
		base.OnInit();
		if (_hitBox == null)
		{
			_hitBox = HitBox.Setup(gameObject, this, this);
			_hitBox.hitDamageId = hitDamageId;
			_hitBox.featureFlags = hitFlags;
			_hitBox.featureData = hitFeatureData;
			_hitBox.hurtAnimType = hurtAnimType;
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	public void Setup(AdventureActor owner)
	{
		_owner = owner;
		EnableLogicUpdate();
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		TSVector2 tSVector = default;
		FP positionY = default;
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		if (playerAdventureActor != null)
		{
			_owner = playerAdventureActor;
			tSVector = playerAdventureActor.tsTransform.Position - tsTransform.Position;
			positionY = playerAdventureActor.dtCollider.HeightCenter;
			tsTransform.Position = playerAdventureActor.tsTransform.Position;
			tsTransform.PositionY = playerAdventureActor.tsTransform.PositionY;
		}
		if (!NeedUpdate)
		{
			return;
		}
		FP degrees = rotateSpeed * LogicDeltaTime;
		for (int i = 0; i < _electroBalls.Count; i++)
		{
			_hitBox.hitDamageId = _electroBalls.get_Item(i).hitDamageId;
			_attackActor = _electroBalls.get_Item(i).owner;
			_hitBox.CircleAreaHit(radius, 0f, _electroBalls.get_Item(i).position, out var _, out var _, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), hittedEffectPrefab, isHittedEffectScale, _hitLayer, damageImmuneDuration, randomHit: false, effectIgnoreTimeScale);
			FP fP = _electroBalls.get_Item(i).duration - LogicDeltaTime;
			TSVector2 tSVector2 = _electroBalls.get_Item(i).position + tSVector;
			TSVector2 v = tSVector2 - tsTransform.Position;
			v = TSVector2.Rotate(v, degrees);
			tSVector2 = tsTransform.Position + v;
			_electroBalls.get_Item(i).Update(fP, tSVector2, positionY);
		}
		List<ElectroBall> list = _electroBalls.FindAll((ElectroBall x) => x.IsFinish);
		if (list.Count > 0)
		{
			for (int num = 0; num < list.Count; num++)
			{
				_electroBallPool.Add(list.get_Item(num));
				_electroBalls.Remove(list.get_Item(num));
			}
			RefreshAllElectroBall(positionY);
			if (_electroBalls.Count > 0 && rotateSpeed > 0)
			{
				damageImmuneDuration = 360 / rotateSpeed / _electroBalls.Count;
			}
			else
			{
				damageImmuneDuration = default;
			}
		}
	}

	public void GenerateElectroBall(AdventureActor owner, int hitDamageId, bool isInfinite = false)
	{
		if (owner == null || maxCount <= 0)
		{
			return;
		}
		if (_electroBalls.Count >= maxCount)
		{
			int index = 0;
			FP fP = 0;
			for (int i = 0; i < _electroBalls.Count; i++)
			{
				FP fP2 = _electroBalls.get_Item(i).duration;
				if (fP <= 0 || fP2 < fP)
				{
					fP = fP2;
					index = i;
				}
			}
			_electroBalls.get_Item(index).duration = duration;
			_electroBalls.get_Item(index).hitDamageId = hitDamageId;
			_electroBalls.get_Item(index).isInfinite = isInfinite;
		}
		else
		{
			ElectroBall electroBall;
			if (_electroBallPool.Count > 0)
			{
				electroBall = _electroBallPool.get_Item(0);
				_electroBallPool.RemoveAt(0);
			}
			else
			{
				electroBall = new ElectroBall();
			}
			electroBall.Init(owner, fx, duration, hitDamageId, isInfinite);
			_electroBalls.Add(electroBall);
			RefreshAllElectroBall(_owner.dtCollider.HeightCenter);
			if (_electroBalls.Count > 0 && rotateSpeed > 0)
			{
				damageImmuneDuration = 360 / rotateSpeed / _electroBalls.Count;
			}
			else
			{
				damageImmuneDuration = default;
			}
		}
	}

	public TSVector2 GetFirstElectroBallPosition()
	{
		if (_electroBalls.Count <= 0)
		{
			return TSVector2.zero;
		}
		return _electroBalls.get_Item(0).position;
	}

	public TSVector2 FinishElectroBall()
	{
		TSVector2 zero = TSVector2.zero;
		if (_electroBalls.Count <= 0)
		{
			return zero;
		}
		int index = 0;
		FP fP = 0;
		for (int i = 0; i < _electroBalls.Count; i++)
		{
			if (!_electroBalls.get_Item(i).isInfinite && (fP <= 0 || _electroBalls.get_Item(i).duration < fP))
			{
				fP = duration;
				index = i;
			}
		}
		zero = _electroBalls.get_Item(index).position;
		_electroBalls.get_Item(index).Stop(forceStop: true);
		return zero;
	}

	private void RefreshAllElectroBall(FP positionY)
	{
		if (_electroBalls.Count > 0)
		{
			TSVector2 v = new TSVector2(0, rotateRadius);
			if (_electroBalls.get_Item(0).position != default(TSVector2))
			{
				v = _electroBalls.get_Item(0).position - tsTransform.Position;
			}
			int num = 360 / _electroBalls.Count;
			for (int i = 0; i < _electroBalls.Count; i++)
			{
				TSVector2 position = tsTransform.Position + TSVector2.Rotate(v, num * i);
				_electroBalls.get_Item(i).SetPosition(position, positionY);
			}
		}
	}

	public void Finish()
	{
		for (int i = 0; i < _electroBalls.Count; i++)
		{
			_electroBalls.get_Item(i).Stop(forceStop: true);
		}
		_electroBalls.Clear();
		_electroBallPool.Clear();
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		DisableLogicUpdate();
		_owner = null;
		_attackActor = null;
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
		if (!(_owner == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !_owner.IsConfrontWith(entity))
		{
			return _owner.IsNeutralWith(entity);
		}
		return true;
	}

	public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (_attackActor == null)
		{
			return false;
		}
		if (!entity.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		(damaged, _, _) = (entity as AdventureActor).Damage(_attackActor, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
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
		return true;
	}
}
