using System;
using System.Collections.Generic;
using AK.Wwise;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/旋转武器")]
public class AdventureRotateWeapon : AdventureWeapon
{
	[Serializable]
	public class wwiseSpeedData
	{
		public FP _speed;

		public Event startEvent;

		public Event endEvent;
	}

	[Space]
	public FP _duration;

	public FP _radius = 1;

	public FP hitTestInterval = 0f;

	public bool followActivePlayer;

	public DeterministicCollider[] weaponColliders;

	public FP rotateSpeed = 180f;

	public FP _startRotation;

	public FP radiusChange_perFrame = 0f;

	public bool ifollow = true;

	public FP rotate_delayTime;

	public bool closeRefreshPos;

	public bool enableEarlyWarningEffect;

	public GameObject earlyWarningPrefab;

	public FP earlyWarningDuration = 1f;

	public float earlyWarningScale = 1f;

	public UnityEngine.Transform[] cTrans;

	public GameObject hittedPrefab;

	public wwiseSpeedData[] wiseDatas;

	[Space]
	public bool useLocalShape;

	public HitBox.Shape shape = HitBox.Shape.Fan;

	public FP shape_angle;

	public FP shape_length;

	public FP shape_width;

	public FP shape_radius;

	public FP shape_innerRadius;

	private LogicEntity followOw;

	private AdventureActor _ownerAd;

	private TrueSync.Physics2D.Transform rotationTransfrom;

	private FP rotateAngle;

	private FP current_radius;

	private List<AdventureEarlyWarningFXPlayer> earlyWarningFXPlayers = new List<AdventureEarlyWarningFXPlayer>();

	private List<long> _earlyWarningFXTokens = new List<long>();

	private FP _earlyWarningTime;

	private FP _logictime;

	protected FP _leftTime;

	protected FP _rotateOffset;

	protected FP _rotateFp;

	protected List<DeterministicCollider> _targets = new List<DeterministicCollider>(10);

	private FP rotateInterLentgh => new FP(weaponColliders.Length);

	public override bool isEquipableWeapon => true;

	protected override void OnInit()
	{
		base.OnInit();
		Init();
		if (weaponColliders == null || weaponColliders.Length == 0)
		{
			owner.LogError("旋转武器碰撞体没有配置");
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
		tsTransform.transformSyncEnabled = true;
		Init();
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		if (owner != null)
		{
			owner.TryGetComponent<AdventureActor>(out _ownerAd);
			followOw = owner;
			tsTransform.Position = followOw.tsTransform.Position;
		}
		_leftTime = _duration;
		if (_leftTime <= 0)
		{
			_leftTime = -999;
		}
		rotateAngle = 0;
		_rotateFp = 0;
		RotateWeaponColliders(0);
		wwiseSpeedData wiseData = getWiseData();
		if (wiseData != null && wiseData.startEvent != null)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(wiseData.startEvent.Name, gameObject);
		}
		_earlyWarningTime = 0f;
		if (!enableEarlyWarningEffect || !(earlyWarningPrefab != null))
		{
			return;
		}
		earlyWarningFXPlayers.Clear();
		_earlyWarningFXTokens.Clear();
		_earlyWarningTime = earlyWarningDuration;
		for (int i = 0; i < weaponColliders.Length; i++)
		{
			UnityEngine.Transform transform = base.transform;
			if (cTrans != null && cTrans[i] != null)
			{
				transform = cTrans[i];
			}
			AdventureEarlyWarningFXPlayer adventureEarlyWarningFXPlayer = AdventureEarlyWarningFXPlayer.PlayFX(earlyWarningPrefab, (float)earlyWarningDuration, transform.position, transform.rotation, earlyWarningScale);
			adventureEarlyWarningFXPlayer.Bind(gameObject);
			_earlyWarningFXTokens.Add(adventureEarlyWarningFXPlayer.token);
			earlyWarningFXPlayers.Add(adventureEarlyWarningFXPlayer);
		}
	}

	public void fixLeftTime(FP fixedValue)
	{
		if (_leftTime != -999)
		{
			_leftTime += fixedValue;
		}
	}

	private void Init()
	{
		current_radius = _radius;
		for (int i = 0; i < weaponColliders.Length; i++)
		{
			weaponColliders[i].gameObject.transform.localScale = transform.localScale;
			weaponColliders[i].gameObject.AddOrGetComponent<AdventureWeaponEntity>().ActiveSelf = !enableEarlyWarningEffect;
		}
	}

	public FP GetAngel()
	{
		return rotateAngle;
	}

	protected virtual void RotateWeaponColliders(FP rotate)
	{
		FP fP = 360f / rotateInterLentgh;
		for (int i = 0; i < weaponColliders.Length; i++)
		{
			DeterministicCollider deterministicCollider = weaponColliders[i];
			FP t = fP * i + rotate + _startRotation + tsTransform.Rotation;
			t = TSMath.Repeat(t, 360f);
			rotationTransfrom.Set(tsTransform.dtTransform.p, t * FP.Deg2Rad);
			TSVector2 position = MathUtils.Mul(ref rotationTransfrom, new TSVector2(0f, current_radius));
			if (deterministicCollider.tsTransform != null)
			{
				deterministicCollider.tsTransform.Position = position;
				deterministicCollider.tsTransform.PositionY = tsTransform.PositionY;
				deterministicCollider.tsTransform.Rotation = t;
			}
		}
	}

	protected virtual void CheckWeaponCollidersHit()
	{
		for (int i = 0; i < weaponColliders.Length; i++)
		{
			DeterministicCollider deterministicCollider = weaponColliders[i];
			if (!deterministicCollider.ActiveSelf)
			{
				continue;
			}
			if (!useLocalShape)
			{
				_hitBox.HitWithCollider(deterministicCollider, hittedPrefab, hitTestInterval);
				continue;
			}
			int num = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
			int hittedCount;
			int damageCount;
			switch (shape)
			{
			case HitBox.Shape.Rectangle:
				_hitBox.RectangleAreaHit(shape_width * deterministicCollider.transform.lossyScale.x, shape_length * deterministicCollider.transform.lossyScale.z, deterministicCollider.tsTransform.Position, deterministicCollider.tsTransform.Rotation, out hittedCount, out damageCount, num, hittedPrefab, isHittedEffectScale: true, -5, hitTestInterval);
				break;
			case HitBox.Shape.Circle:
				_hitBox.CircleAreaHit(shape_radius * deterministicCollider.transform.lossyScale.x, shape_innerRadius * deterministicCollider.transform.lossyScale.x, deterministicCollider.tsTransform.Position, out damageCount, out hittedCount, num, hittedPrefab, isHittedEffectScale: true, -5, hitTestInterval);
				break;
			case HitBox.Shape.Fan:
				_hitBox.FanAreaHit(shape_angle, shape_radius * deterministicCollider.transform.lossyScale.x, shape_innerRadius * deterministicCollider.transform.lossyScale.x, deterministicCollider.tsTransform.Position, deterministicCollider.tsTransform.Rotation, out hittedCount, out damageCount, num, hittedPrefab, isHittedEffectScale: true, hitTestInterval);
				break;
			}
		}
	}

	public override bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!actor.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		(damaged, _, _) = (actor as AdventureActor).Damage(_owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public override bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!isValid)
		{
			return false;
		}
		AdventureActor component = actor.GetComponent<AdventureActor>();
		if (!component.CurrentStepCanbeHurt())
		{
			return true;
		}
		DestructibleStateSingle destructibleStateSingle = actor as DestructibleStateSingle;
		if (heightClass <= destructibleStateSingle.getHeight())
		{
			(damaged, _, _) = component.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		}
		return true;
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (owner.IsDead())
		{
			_ownerAd.EquipDrop(this);
			return;
		}
		if (_ownerAd != null && _ownerAd is PlayerAdventureActor && SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != followOw && followActivePlayer)
		{
			followOw = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		}
		if (ifollow)
		{
			tsTransform.Position = followOw.tsTransform.Position;
		}
		if (_earlyWarningTime > 0f)
		{
			_earlyWarningTime -= LogicDeltaTime;
			if (!(_earlyWarningTime <= 0f))
			{
				return;
			}
			for (int i = 0; i < earlyWarningFXPlayers.Count; i++)
			{
				if (earlyWarningFXPlayers.get_Item(i).token == _earlyWarningFXTokens.get_Item(i))
				{
					earlyWarningFXPlayers.get_Item(i).Complete();
				}
			}
			earlyWarningFXPlayers.Clear();
			_earlyWarningFXTokens.Clear();
			for (int j = 0; j < weaponColliders.Length; j++)
			{
				weaponColliders[j].gameObject.AddOrGetComponent<AdventureWeaponEntity>().ActiveSelf = true;
			}
			return;
		}
		if (_leftTime != -999)
		{
			if (_leftTime < 0)
			{
				_ownerAd.EquipDrop(this);
				return;
			}
			_leftTime -= LogicDeltaTime;
		}
		_logictime = (enableEarlyWarningEffect ? (LogicTime - earlyWarningDuration) : LogicTime);
		FP rotate = _rotateOffset + _logictime * rotateSpeed;
		if (LogicDeltaTime > 0)
		{
			current_radius += radiusChange_perFrame;
		}
		if (weaponColliders != null)
		{
			if (_logictime >= rotate_delayTime)
			{
				rotateAngle += LogicDeltaTime * rotateSpeed;
				RotateWeaponColliders(rotate);
			}
			CheckWeaponCollidersHit();
		}
	}

	public override void ModifyWeaponScaleByMulti(FP scaleMulti)
	{
		for (int i = 0; i < weaponColliders.Length; i++)
		{
			DeterministicCollider obj = weaponColliders[i];
			obj.gameObject.transform.localScale = DefaultWeaponScale * scaleMulti.AsFloat();
			obj.LoadFromUnityCollider(obj.gameObject.GetComponent<Collider>(), applyTransformScale: true);
		}
		for (int j = 0; j < weaponColliders.Length; j++)
		{
			weaponColliders[j].GetComponentInChildren<PlayFXAssistant>().FxScaleMutli = scaleMulti;
		}
	}

	protected override void OnWeaponScaleChange()
	{
		for (int i = 0; i < weaponColliders.Length; i++)
		{
			DeterministicCollider obj = weaponColliders[i];
			obj.gameObject.transform.localScale = transform.localScale;
			obj.LoadFromUnityCollider(obj.gameObject.GetComponent<Collider>(), applyTransformScale: true);
		}
		for (int j = 0; j < weaponColliders.Length; j++)
		{
			weaponColliders[j].GetComponentInChildren<PlayFXAssistant>().FxScaleMutli = transform.localScale.x;
		}
	}

	public override void OnEquipWith()
	{
		OnEquipUpdate();
	}

	public override void OnEquipUpdate()
	{
		if (closeRefreshPos)
		{
			return;
		}
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		AdventureActor component = owner.GetComponent<AdventureActor>();
		for (int i = 0; i < component.equipedWeapons.Count; i++)
		{
			AdventureRotateWeapon adventureRotateWeapon = component.equipedWeapons.get_Item(i) as AdventureRotateWeapon;
			if (adventureRotateWeapon != null && adventureRotateWeapon.weaponTag == weaponTag)
			{
				if (adventureRotateWeapon == this)
				{
					num = num2;
				}
				num2++;
				num3 += adventureRotateWeapon.weaponColliders.Length;
			}
		}
		FP fP = 360f / new FP(num3);
		_rotateOffset = fP * num;
	}

	public override void OnEquipDrop()
	{
		Finish(cancel: true);
		wwiseSpeedData wiseData = getWiseData();
		if (wiseData != null && wiseData.endEvent != null)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(wiseData.endEvent.Name, gameObject);
		}
	}

	public override void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		base.Finish(cancel, catched, ignorFinishFX);
		RotateWeaponColliders(0);
	}

	protected override void OnVisualUpdate()
	{
		if (ifollow)
		{
			Vector3 position = followOw.transform.position;
			position.y = base.transform.position.y;
			base.transform.position = position;
		}
		for (int i = 0; i < earlyWarningFXPlayers.Count; i++)
		{
			UnityEngine.Transform transform = base.transform;
			if (cTrans != null && cTrans[i] != null)
			{
				transform = cTrans[i];
			}
			earlyWarningFXPlayers.get_Item(i).transform.SetPositionAndRotation(transform.position, transform.rotation);
		}
	}

	public wwiseSpeedData getWiseData()
	{
		if (wiseDatas != null && wiseDatas.Length != 0)
		{
			for (int num = wiseDatas.Length - 1; num >= 0; num--)
			{
				if (TSMath.Abs(rotateSpeed) >= wiseDatas[num]._speed)
				{
					return wiseDatas[num];
				}
			}
		}
		return null;
	}
}
