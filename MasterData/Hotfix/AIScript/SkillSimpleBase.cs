#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

namespace AIScript;

public class SkillSimpleBase : AIBase
{
	public struct TempMultiShootParams
	{
		public HitBox.Shape shape;

		public string bulletAlias;

		public AdventureWeapon.MultipleShootStyle multipleShootStyle;

		public bool alignShoot;

		public FP alignShootDelay;

		public int bulletCount;

		public FP duration;

		public TSVector2 shootPosition;

		public FP shootPositionY;

		public TSVector2 multiShootDirection;

		public FP bulletDirectionOffset;

		public AimType aimType;

		public BulletDirectionType bulletDirectionType;

		public TSVector2 targetPosition;

		public LogicEntity target;

		public FP angle;

		public FP width;

		public FP length;

		public FP radius;

		public FP innerRadius;
	}

	protected class HitFeatureData
	{
		private HitBox.FeatureFlag _featureFlag;

		private HitBox.HitBoxFeatureData _featureData;

		public HitBox.FeatureFlag FeatureFlag => _featureFlag;

		public HitBox.HitBoxFeatureData FeatureData => _featureData;

		public HitFeatureData()
		{
			_featureFlag = HitBox.FeatureFlag.None;
			if (_featureData == null)
			{
				_featureData = new HitBox.HitBoxFeatureData();
			}
		}

		public void ParseData(HitBox.FeatureFlag featureFlag, FP KnockBackForce, FP KnockBackDistance, bool UseAtttackForward, bool UseHitBoxPosition, FP KnockOutForce, string oldAreaTag, GameObject newAreaEffectPrefab, FP StiffDuration, FP FreezeFrameWhenDamage, FP FreezeFrameTimeScaleWhenDamage, FP FreezeFrameWhenCrit, FP FreezeFrameTimeScaleWhenCrit, FP FreezeFrameWhenToughnessBroken, FP FreezeFrameTimeScaleWhenToughnessBroken, FP FreezeFrameWhenKill, FP FreezeFrameTimeScaleWhenKill, List<int> buffIdsForSelf, List<int> buffIdsForTarget, List<int> removeBuffIdsForSelf, List<int> removeBuffIdsForTarget, FP hitStrenth)
		{
			_featureFlag = featureFlag;
			_featureData.KnockBackForce = KnockBackForce;
			_featureData.KnockBackDistance = KnockBackDistance;
			_featureData.UseAtttackForward = UseAtttackForward;
			_featureData.UseHitBoxPosition = UseHitBoxPosition;
			_featureData.KnockOutForce = KnockOutForce;
			_featureData.oldAreaTag = oldAreaTag;
			_featureData.newAreaEffectPrefab = newAreaEffectPrefab;
			_featureData.StiffDuration = StiffDuration;
			_featureData.FreezeFrameWhenDamage = FreezeFrameWhenDamage;
			_featureData.FreezeFrameWhenCrit = FreezeFrameWhenCrit;
			_featureData.FreezeFrameWhenToughnessBroken = FreezeFrameWhenToughnessBroken;
			_featureData.buffIdsForSelf = buffIdsForSelf;
			_featureData.buffIdsForTarget = buffIdsForTarget;
			_featureData.removeBuffIdsForSelf = removeBuffIdsForSelf;
			_featureData.removeBuffIdsForTarget = removeBuffIdsForTarget;
			_featureData.hitStrenth = hitStrenth;
		}

		public void Clear()
		{
			_featureFlag = HitBox.FeatureFlag.None;
		}
	}

	protected static readonly string TurnEvent = "Turn";

	protected static readonly string StopTurnEvent = "StopTurn";

	protected static readonly string ShootEvent = "Shoot";

	protected static readonly string AttackEvent = "Attack";

	protected static readonly string DashEvent = "Dash";

	private Dictionary<SpecialState, int> _specialStateDict = new Dictionary<SpecialState, int>();

	private CoroutineNode aimAtPositionCor;

	private CoroutineNode aimAtMonsterTargetCor;

	private LogicEntity aimTarget;

	private static int evt_DashEnd = CommonHelper.StringToHash("DashEnd");

	private RequestDefaultState moveReq;

	private CoroutineNode waitDurationCorNode;

	protected TraceTarget _traceTarget;

	private RequestTrace traceReq;

	private RequestBezierPathMove _bezierPathMoveReq;

	private BezierPathMove _bezierPathMove;

	private List<PlayFX> _playFXList = new List<PlayFX>();

	private List<AdventureFXPlayer> _adFxList = new List<AdventureFXPlayer>();

	private Dictionary<long, CoroutineNode> _rotateFXCorDic = new Dictionary<long, CoroutineNode>();

	private List<int> summonMonsterIds;

	private bool _isReceiveSkillTakeEffect;

	protected bool _isDisableByLostControl;

	private CoroutineNode executeCoroutineNode;

	private CoroutineNode logicCoroutineNode;

	private CoroutineNode linkFXCoroutineNode;

	private List<CoroutineNode> coroutineNodeList;

	private int waitComboIndex = -1;

	private string waitEventName = string.Empty;

	private bool waitEvent;

	private List<string> receiveCustomEventNames = new List<string>();

	protected ComboAttack comboAttack;

	private RequestComboAttack requestComboAttack;

	private LookAtTarget lookAtTarget;

	public bool inLookAtState;

	private CoroutineNode corRotate;

	private PlayFX playFx;

	private List<PlayFX> playFXList;

	private List<PlayFX> playLinkFXList;

	private PlayMonsterTimeline _playMonsterTimeline;

	private PlayableDirectorConfig _directorConfig;

	private bool _isTimelinePlaying;

	private Dash dash;

	private RequestDash dashReq;

	private bool _inCrossJump;

	private bool needTryShootAgain;

	private int onceShootSuccessCount;

	private bool tryShootAgainFinish;

	private TempMultiShootParams tShootParams;

	private FP tryAnglePerStep = 10;

	private int tryShootTimes;

	private int currentTryShootTimes;

	private RequestDefaultState shootReq;

	private readonly List<long> _bulletIdList = new List<long>(10);

	private List<LogicEntity> _searchTargets;

	private CommomAreaHitConfig _areaHitConfig;

	private HitFeatureData _hitFeatureData;

	private CoroutineNode _dynamicTransparentCor;

	private CoroutineNode _changeModelScaleCor;

	private Dictionary<MonsterEventType, MonsterEventParams> _monsterEventDict;

	protected HitFeatureData GetHitFeatureData(HitBox.FeatureFlag featureFlag = HitBox.FeatureFlag.None, FP KnockBackForce = default(FP), FP KnockBackDistance = default(FP), bool UseAtttackForward = false, FP KnockOutForce = default(FP), string oldAreaTag = null, GameObject newAreaEffectPrefab = null, FP StiffDuration = default(FP), FP FreezeFrameWhenDamage = default(FP), FP FreezeFrameTimeScaleWhenDamage = default(FP), FP FreezeFrameWhenCrit = default(FP), FP FreezeFrameTimeScaleWhenCrit = default(FP), FP FreezeFrameWhenToughnessBroken = default(FP), FP FreezeFrameTimeScaleWhenToughnessBroken = default(FP), FP FreezeFrameWhenKill = default(FP), FP FreezeFrameTimeScaleWhenKill = default(FP), List<int> buffIdsForSelf = null, List<int> buffIdsForTarget = null, List<int> removeBuffIdsForSelf = null, List<int> removeBuffIdsForTarget = null, FP hitStrenth = default(FP), bool UseHitBoxPosition = false)
	{
		if (_hitFeatureData == null)
		{
			_hitFeatureData = new HitFeatureData();
		}
		_hitFeatureData.ParseData(featureFlag, KnockBackForce, KnockBackDistance, UseAtttackForward, UseHitBoxPosition, KnockOutForce, oldAreaTag, newAreaEffectPrefab, StiffDuration, FreezeFrameWhenDamage, FreezeFrameTimeScaleWhenDamage, FreezeFrameWhenCrit, FreezeFrameTimeScaleWhenCrit, FreezeFrameTimeScaleWhenToughnessBroken, FreezeFrameTimeScaleWhenToughnessBroken, FreezeFrameWhenKill, FreezeFrameTimeScaleWhenKill, buffIdsForSelf, buffIdsForTarget, removeBuffIdsForSelf, removeBuffIdsForTarget, hitStrenth);
		return _hitFeatureData;
	}

	protected int AreaHit_Simple(LogicEntity entity, DeterministicShape shape, HitFeatureData hitFeatureData, int hitDamageId, FP damageImmuneDuration, HitBox.HurtAnimType hurtAnimType, string hittedEffectAlias = "")
	{
		if (hitFeatureData == null)
		{
			NovaLogger.Error("AreaHit_Simple Failed，未传入攻击特性数据！");
			return 0;
		}
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			NovaLogger.Error("AreaHit_Simple Failed, LogicEntity非Actor(玩家角色、怪物)！");
			return 0;
		}
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.position = shape.position;
		_areaHitConfig.direction = TSVector2.Rotate(new TSVector2(0, 1), shape.rotation);
		_areaHitConfig.hitDamageId = hitDamageId;
		_areaHitConfig.hitFlags = hitFeatureData.FeatureFlag;
		_areaHitConfig.hitFeatureData = hitFeatureData.FeatureData;
		_areaHitConfig.damageImmuneDuration = damageImmuneDuration;
		_areaHitConfig.hurtAnimType = hurtAnimType;
		_areaHitConfig.hittedEffectAlias = hittedEffectAlias;
		switch (shape.shapeType)
		{
		case DeterministicShape.ShapeType.Rectangle:
			return ILRuntimeAPI.RectangleAreaHit(adventureActor, _areaHitConfig, shape.width, shape.length);
		case DeterministicShape.ShapeType.Circle:
			return ILRuntimeAPI.CircleAreaHit(adventureActor, _areaHitConfig, shape.radius, shape.innerRadius);
		case DeterministicShape.ShapeType.Fan:
			return ILRuntimeAPI.FanAreaHit(adventureActor, _areaHitConfig, shape.angle, shape.radius, shape.innerRadius);
		default:
			NovaLogger.Error("AreaHit_Simple Failed，形状数据有误！");
			return 0;
		}
	}

	protected long PlayAreaEffect(string fxAlias, TSVector2 position = default(TSVector2), FP rotation = default(FP))
	{
		return ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, rotation);
	}

	protected AreaEffectEntity GetAreaEffect(long id)
	{
		return ILRuntimeAPI.GetAreaEffect(id);
	}

	protected void StopAreaEffect(long id)
	{
		ILRuntimeAPI.StopAreaEffect(id);
	}

	protected void DirectDamage(LogicEntity toActor, int damage, string tag, bool showHud = true)
	{
		if (toActor is AdventureActor target)
		{
			ILRuntimeAPI.DirectDamage(_actor, target, damage, tag, null, showHud);
		}
	}

	protected void DirectHeal(LogicEntity toActor, int value, bool showHud = false)
	{
		if (toActor is AdventureActor adventureActor)
		{
			adventureActor.DirectHeal(value, showHud);
		}
	}

	protected long PlayLineAreaWeapon(string fxAlias, bool isFixedEntitySource = false, TSVector2 sourcePosition = default(TSVector2), FP sourcePositionY = default(FP), LogicEntity sourceEntity = null, TSVector2 sourceOffset = default(TSVector2), bool isFixedEntityTarget = false, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), LogicEntity targetEntity = null, TSVector2 targetOffset = default(TSVector2), long overrideLineAreaWeaponId = 0L)
	{
		if (string.IsNullOrEmpty(fxAlias))
		{
			return 0L;
		}
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias(fxAlias);
		if (gameObject != null && SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, gameObject, _actor.transform.position, _actor.transform.rotation) is LineAreaWeaponEntity lineAreaWeaponEntity)
		{
			if (overrideLineAreaWeaponId > 0 && SceneSingleton<SpecialEntityManager>.Instance.GetSpecialEntity(overrideLineAreaWeaponId) is LineAreaWeaponEntity lineAreaWeaponEntity2)
			{
				sourcePosition = lineAreaWeaponEntity2.SourcePosition;
				sourcePositionY = lineAreaWeaponEntity2.SourcePositionY;
				isFixedEntitySource = lineAreaWeaponEntity2.IsFixedEntitySource;
				sourceEntity = ((lineAreaWeaponEntity2.SourceEntity != null) ? ModuleController<AdventureModuleController>.Instance.QueryEntityByID(lineAreaWeaponEntity2.SourceEntity.Id) : null);
				sourceOffset = lineAreaWeaponEntity2.SourceOffset;
				targetPosition = lineAreaWeaponEntity2.TargetPosition;
				targetPositionY = lineAreaWeaponEntity2.TargetPositionY;
				isFixedEntityTarget = lineAreaWeaponEntity2.IsFixedEntityTarget;
				targetEntity = ((lineAreaWeaponEntity2.TargetEntity != null) ? ModuleController<AdventureModuleController>.Instance.QueryEntityByID(lineAreaWeaponEntity2.TargetEntity.Id) : null);
				targetOffset = lineAreaWeaponEntity2.TargetOffset;
				lineAreaWeaponEntity2.Finish();
			}
			lineAreaWeaponEntity.Link(sourcePosition, sourcePositionY, isFixedEntitySource, sourceEntity, sourceOffset, targetPosition, targetPositionY, isFixedEntityTarget, targetEntity, targetOffset);
			return lineAreaWeaponEntity.Id;
		}
		return 0L;
	}

	protected void StopLineAreaWeapon(long id)
	{
		if (id > 0 && SceneSingleton<SpecialEntityManager>.Instance.GetSpecialEntity(id) is LineAreaWeaponEntity lineAreaWeaponEntity)
		{
			lineAreaWeaponEntity.Finish();
		}
	}

	protected void AddBuffToTarget(LogicEntity target, int buffID, int num = 1)
	{
		if (num == 1)
		{
			CommonUtils_MonsterAPI.AddBuffToTarget(target, buffID, _actor);
		}
		else
		{
			CommonUtils_MonsterAPI.AddBuffNumToTarget(target, buffID, _actor, num);
		}
	}

	protected void RemoveBuffFromTarget(LogicEntity target, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		CommonUtils_MonsterAPI.RemoveBuffFromTarget(target, buffID, buffGroupID, buffTag);
	}

	protected void RemoveBuffByNumFromTarget(LogicEntity target, int buffId, int removeNum)
	{
		CommonUtils_MonsterAPI.RemoveBuffByNumFromTarget(target, buffId, removeNum);
	}

	protected int GetBuffNum(LogicEntity target, int buffID)
	{
		return CommonUtils_MonsterAPI.GetBuffNum(target, buffID);
	}

	protected void AddShieldToTarget(LogicEntity target, int shieldId)
	{
		CommonUtils_MonsterAPI.AddShieldToTarget(target, shieldId, _actor);
	}

	protected List<BuffEntity> GetBuffFromTarget(LogicEntity target, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		BuffCom buffCom = (target as AdventureActor)?.buffComponent;
		if (buffCom != null)
		{
			return buffCom.GetBuff(buffID, buffGroupID, buffTag);
		}
		return null;
	}

	protected void RemoveShieldById(LogicEntity target, int shieldId)
	{
		if (target is AdventureActor adventureActor)
		{
			adventureActor.actorShield.RemoveShieldByShieldID(shieldId);
		}
	}

	protected RequestComboAttack BeginAttack(int keyIndex, ComboInputBuffer.ActionKey[] keys, bool flushInputedKeys = false, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null)
	{
		if (requestComboAttack == null)
		{
			requestComboAttack = new RequestComboAttack();
		}
		requestComboAttack.Reset();
		requestComboAttack.comboIndex = keyIndex;
		if (this.comboAttack == null)
		{
			this.comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = this.comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		bool flushInputedKeys2 = flushInputedKeys;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		bool forceInterruptAttack2 = forceInterruptAttack;
		bool autoLookAtTarget2 = autoLookAtTarget;
		Action action = onAnticipationEnd;
		Action action2 = onActivationEnd;
		Action action3 = onComboLoop;
		Action action4 = onRecoveryBegin;
		Action action5 = onComboFinish;
		Action action6 = onInterrupt;
		Action<string> action7 = onCustomEvent;
		Action action8 = onSendSkillTakeEffect;
		comboAttack.BeginAttack(actor, skill, keys, flushInputedKeys2, skillId, forceInterruptAttack2, autoLookAtTarget2, attackTarget, null, default, action, action4, action3, action5, action6, action7, action2, fadeOutAnim: true, action8);
		return requestComboAttack;
	}

	protected RequestComboAttack BeginAttack(int keyIndex, string actionKey, bool flushInputedKeys = false, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null)
	{
		if (requestComboAttack == null)
		{
			requestComboAttack = new RequestComboAttack();
		}
		requestComboAttack.Reset();
		requestComboAttack.comboIndex = keyIndex;
		ref ComboAttack reference = ref comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		bool flushInputedKeys2 = flushInputedKeys;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		bool forceInterruptAttack2 = forceInterruptAttack;
		bool autoLookAtTarget2 = autoLookAtTarget;
		Action action = onAnticipationEnd;
		Action action2 = onActivationEnd;
		Action action3 = onComboLoop;
		Action action4 = onRecoveryBegin;
		Action action5 = onComboFinish;
		Action action6 = onInterrupt;
		Action<string> action7 = onCustomEvent;
		Action action8 = onSendSkillTakeEffect;
		ILRuntimeAPI.BeginComboAttack(ref reference, actor, skill, null, flushInputedKeys2, skillId, forceInterruptAttack2, autoLookAtTarget2, attackTarget, null, default, action, action4, action3, action5, action6, action7, action2, fadeOutAnim: true, action8, keyPerfectMatch: false, actionKey);
		return requestComboAttack;
	}

	protected void CancelAttack()
	{
		comboAttack?.CancelAttack();
	}

	protected void InterruptAttack()
	{
		comboAttack?.InterruptAttack();
	}

	protected CoroutineNode WaitCombo(ComboAttackType comboAttackType)
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(_waitCombo(comboAttackType));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	private IEnumerator _waitCombo(ComboAttackType comboAttackType)
	{
		if (requestComboAttack != null && comboAttackType != ComboAttackType.None)
		{
			while (requestComboAttack.comboAttackType != comboAttackType)
			{
				yield return null;
			}
		}
	}

	protected object WaitCustomEvent(string eventName)
	{
		if (receiveCustomEventNames.Contains(eventName))
		{
			receiveCustomEventNames.Remove(waitEventName);
			return CoroutineNode.YieldContinue;
		}
		waitEventName = eventName;
		waitEvent = true;
		waitComboIndex = -1;
		CoroutineNode coroutineNode = StartCoroutine(waitCustomEvent());
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected virtual void OnCustomEvent(int comboIndex, string eventName)
	{
	}

	protected virtual void OnComboLoop(int comboIndex)
	{
	}

	protected void SummonMonster(int summonActorID, int summonGroupID, TSVector2 spawnPosition, TSVector2 spawnDirection)
	{
		if (summonActorID > 0)
		{
			ILRuntimeAPI.SummonMonster(_actor, 0, summonActorID, spawnPosition, spawnDirection);
		}
		else
		{
			ILRuntimeAPI.SummonMonster(_actor, summonGroupID, summonActorID, spawnPosition, spawnDirection);
		}
	}

	protected void SummonTeammate(int index, TSVector2 spawnPosition, TSVector2 spawnDirection, int maxAmount = 0)
	{
		CommonUtils_MonsterAPI.SummonTeammate(_actor as MonsterAdventureActor, index, spawnPosition, spawnDirection, maxAmount);
	}

	protected void KillActors(List<LogicEntity> entities)
	{
		CommonUtils_MonsterAPI.KillActors(entities);
	}

	protected void ClearActors(List<LogicEntity> entities)
	{
		CommonUtils_MonsterAPI.ClearActors(entities);
	}

	protected void UseMonsterCloneActorCastSkill(int skillId)
	{
		ModuleController<AdventureModuleController>.Instance.UseMonsterCloneActorCastSkill((MonsterAdventureActor)_actor, skillId);
	}

	protected void Idle()
	{
		if (_actor.actorSearchTargetInfo.visionRange != 0 || _actor.actorSearchTargetInfo.hearRange != 0)
		{
			NovaLogger.Error(_actor.name + " visionRange or hearRange非0, 无法切换到Idle");
			return;
		}
		_actor.InterruptAttack(force: true);
		_actor.Idle();
	}

	protected void Action()
	{
		_actor.Action();
	}

	protected void CircleMultipleShoot(string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, FP radius, FP innerRadius, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null)
	{
		MultipleShoot(HitBox.Shape.Circle, bulletAlias, multipleShootStyle, alignShoot, alignShootDelay, bulletCount, duration, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target, 0, 0, 0, radius, innerRadius);
	}

	protected void FanMultipleShoot(string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, FP angle, FP radius, FP innerRadius, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null)
	{
		MultipleShoot(HitBox.Shape.Fan, bulletAlias, multipleShootStyle, alignShoot, alignShootDelay, bulletCount, duration, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target, angle, 0, 0, radius, innerRadius);
	}

	protected void RectangleMultipleShoot(string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, bool awaitShootCompletion, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, FP width, FP length, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null)
	{
		MultipleShoot(HitBox.Shape.Rectangle, bulletAlias, multipleShootStyle, alignShoot, alignShootDelay, bulletCount, duration, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target, 0, width, length, 0, 0);
	}

	protected long Shoot(string bulletAlias, TSVector2 position, FP positionY, FP range, TSVector2 shootDirection = default(TSVector2), AimType aimType = AimType.Default, BulletDirectionType bulletDirectionType = BulletDirectionType.ActorToBullet, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null)
	{
		if (targetPosition == default(TSVector2) && shootDirection != default(TSVector2))
		{
			targetPosition = _actor.tsTransform.Position + shootDirection.normalized;
		}
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bulletAlias, _actor, range, position, positionY, targetPosition, target, aimType, bulletDirectionType);
		if (!(adventureBulletBase != null))
		{
			return 0L;
		}
		return adventureBulletBase.Id;
	}

	protected long ShootWeapon(string weaponAlias, TSVector2 position, FP positionY, TSVector2 shootDirection = default(TSVector2), LogicEntity target = null)
	{
		AdventureWeapon adventureWeapon = ILRuntimeAPI.Shoot(weaponAlias, _actor, position, shootDirection, positionY, target);
		if (!(adventureWeapon != null))
		{
			return 0L;
		}
		return adventureWeapon.Id;
	}

	protected CoroutineNode WaitShootStatus()
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(_waitShoot(BaseNormalStatus.Complete));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected List<long> GetShootBulletIdList()
	{
		return _bulletIdList;
	}

	protected void ClearShootBulletIdList()
	{
		_bulletIdList?.Clear();
	}

	protected TSVector2 GetBulletPosition(long bulletId)
	{
		AdventureBulletBase adventureBulletBase = _actor.QueryOwnedBullet(bulletId);
		if (!(adventureBulletBase != null))
		{
			return TSVector2.zero;
		}
		return adventureBulletBase.tsTransform.Position;
	}

	protected AdventureBulletBase GetBulletByID(long bulletId)
	{
		return _actor.QueryOwnedBullet(bulletId);
	}

	protected TSVector2 GetBulletDirection(long bulletId)
	{
		AdventureBulletBase adventureBulletBase = _actor.QueryOwnedBullet(bulletId);
		if (!(adventureBulletBase != null))
		{
			return TSVector2.up;
		}
		return adventureBulletBase.tsTransform.Forward;
	}

	protected void ClearOwnerBullet()
	{
		List<AdventureBulletBase> list = new List<AdventureBulletBase>();
		_actor.QueryOwnedAliveBullets(list);
		for (int i = 0; i < list.Count; i++)
		{
			list.get_Item(i).Finish();
		}
	}

	protected void ClearOwnerWeapon()
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (adventureWeapon != null && adventureWeapon.owner == _actor && adventureWeapon.ownerId == _actor.Id)
			{
				adventureWeapon.Finish();
			}
		}
	}

	protected void FinishBullet(long bulletId)
	{
		AdventureBulletBase adventureBulletBase = _actor.QueryOwnedBullet(bulletId);
		if (adventureBulletBase != null)
		{
			adventureBulletBase.Finish();
		}
	}

	protected void FinishWeapon(long weaponId)
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (adventureWeapon != null && adventureWeapon.owner == _actor && adventureWeapon.ownerId == _actor.Id && adventureWeapon.Id == weaponId)
			{
				adventureWeapon.Finish();
				break;
			}
		}
	}

	private void EnableSpecialState(SpecialState state)
	{
		if (_specialStateDict.ContainsKey(state))
		{
			_specialStateDict.get_Item(state)++;
		}
		else
		{
			_specialStateDict.set_Item(state, 1);
		}
	}

	private void DisableSpecialState(SpecialState state)
	{
		if (_specialStateDict.ContainsKey(state))
		{
			_specialStateDict.get_Item(state)--;
		}
	}

	private void ClearSpecialState()
	{
		if (_specialStateDict.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<SpecialState, int> item in _specialStateDict)
		{
			switch (item.Key)
			{
			case SpecialState.Armor:
			{
				for (int num2 = 0; num2 < item.Value; num2++)
				{
					SetSuperArmorDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.ImmuneControl:
			{
				for (int j = 0; j < item.Value; j++)
				{
					SetImmuneControlDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.Invincible:
			{
				for (int l = 0; l < item.Value; l++)
				{
					SetInvincibleDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.SearchedImmunity:
			{
				for (int num4 = 0; num4 < item.Value; num4++)
				{
					SetSearchedImmunityDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.CloseBlock:
			{
				for (int n = 0; n < item.Value; n++)
				{
					SetCloseBlockDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.HideMode:
			{
				for (int k = 0; k < item.Value; k++)
				{
					SetHideModelDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.Sneak:
			{
				for (int i = 0; i < item.Value; i++)
				{
					SetSneakDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.HideOut:
			{
				for (int num3 = 0; num3 < item.Value; num3++)
				{
					SetHideOutDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.BattleOut:
			{
				for (int num = 0; num < item.Value; num++)
				{
					SetBattleOutDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.Unparalleled:
			{
				for (int m = 0; m < item.Value; m++)
				{
					SetUnparalleledDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.LockHp:
				if (item.Value > 0)
				{
					SetLockHpDisable(resetCount: false);
				}
				break;
			case SpecialState.LockToughness:
				if (item.Value > 0)
				{
					SetLockToughnessDisable(resetCount: false);
				}
				break;
			case SpecialState.BlockPriorityToStatic:
				if (item.Value > 0)
				{
					ResetBlockPriority(resetCount: false);
				}
				break;
			case SpecialState.CanPerfectDodge:
				if (item.Value > 0)
				{
					CommonUtils_MonsterAPI.SetCanPerfectDodgeEnable(_actor);
				}
				break;
			}
		}
		_specialStateDict.Clear();
	}

	protected void SetSuperArmorEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetSuperArmorEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Armor);
		}
	}

	protected void SetSuperArmorDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetSuperArmorDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Armor);
		}
	}

	protected void InterruptSuperArmor()
	{
		CommonUtils_MonsterAPI.InterruptSuperArmor(_actor);
	}

	protected void SetImmuneControlEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetImmuneControlEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.ImmuneControl);
		}
	}

	protected void SetImmuneControlDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetImmuneControlDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.ImmuneControl);
		}
	}

	public void InterruptImmuneControl()
	{
		CommonUtils_MonsterAPI.InterruptImmuneControl(_actor);
	}

	protected void SetInvincibleEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetInvincibleEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Invincible);
		}
	}

	protected void SetInvincibleDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetInvincibleDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Invincible);
		}
	}

	public void InterruptInvincible()
	{
		CommonUtils_MonsterAPI.InterruptInvincible(_actor);
	}

	protected void SetSearchedImmunityEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetSearchedImmunityEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.SearchedImmunity);
		}
	}

	protected void SetSearchedImmunityDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetSearchedImmunityDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.SearchedImmunity);
		}
	}

	public void InterruptSearchedImmunity()
	{
		CommonUtils_MonsterAPI.InterruptSearchedImmunity(_actor);
	}

	protected void SetCloseBlockEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetCloseBlockEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.CloseBlock);
		}
	}

	protected void SetCloseBlockDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetCloseBlockDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.CloseBlock);
		}
	}

	protected void InterruptCloseBlock()
	{
		CommonUtils_MonsterAPI.InterruptCloseBlock(_actor);
	}

	protected void SetHideModelEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetHideModelEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.HideMode);
		}
	}

	protected void SetHideModelDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetHideModelDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.HideMode);
		}
	}

	protected void InterruptHideModel()
	{
		CommonUtils_MonsterAPI.InterruptHideModel(_actor);
	}

	protected void SetSneakEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetSneakEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Sneak);
		}
	}

	protected void SetSneakDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetSneakDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Sneak);
		}
	}

	protected void EnterSneakWithDynamicTransparentByDistance(FP minDistance, FP maxDistance, FP durationTransparent, FP fadeTime)
	{
		SetSneakEnable();
		StartDynamicTransparent(minDistance, maxDistance, durationTransparent, fadeTime);
	}

	protected void ExitSneakWithDynamicTransparentByDistance()
	{
		StopDynamicTransparent();
		SetSneakDisable();
	}

	protected void InterruptSneak()
	{
		StopDynamicTransparent();
		CommonUtils_MonsterAPI.InterruptSneak(_actor);
	}

	protected void SetHideOutEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetHideOutEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.HideOut);
		}
	}

	protected void SetHideOutDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetHideOutDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.HideOut);
		}
	}

	protected void InterruptHideOut()
	{
		CommonUtils_MonsterAPI.InterruptHideOut(_actor);
	}

	protected void SetBattleOutEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetBattleOutEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.BattleOut);
		}
	}

	protected void SetBattleOutDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetBattleOutDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.BattleOut);
		}
	}

	protected void InterruptBattleOut()
	{
		CommonUtils_MonsterAPI.InterruptBattleOut(_actor);
	}

	protected void SetUnparalleledEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Unparalleled);
		}
	}

	protected void SetUnparalleledDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetUnparalleledDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Unparalleled);
		}
	}

	protected void InterruptUnparalleled()
	{
		CommonUtils_MonsterAPI.InterruptUnparalleled(_actor);
	}

	protected void SetLockHpAbsEnable(bool isAbs, FP hp, bool autoDisableWhenSkillDisable = true)
	{
		if (isAbs)
		{
			CommonUtils_MonsterAPI.SetLockHpAbsEnable(_actor, hp.AsInt());
		}
		else
		{
			CommonUtils_MonsterAPI.SetLockHpPercentEnable(_actor, hp);
		}
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.LockHp);
		}
	}

	protected void SetLockHpDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetLockHpDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.LockHp);
		}
	}

	protected void SetLockToughnessEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetLockToughnessState(_actor as MonsterAdventureActor, iEnable: true);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.LockToughness);
		}
	}

	protected void SetLockToughnessDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetLockToughnessState(_actor as MonsterAdventureActor, iEnable: false);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.LockToughness);
		}
	}

	protected void InterruptLockToughness()
	{
		CommonUtils_MonsterAPI.SetLockToughnessState(_actor as MonsterAdventureActor, iEnable: false);
	}

	protected void SetBlockPriorityToStatic(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetBlockPriorityToStatic(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.BlockPriorityToStatic);
		}
	}

	protected void ResetBlockPriority(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.ResetBlockPriority(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.BlockPriorityToStatic);
		}
	}

	protected bool GetLogicTagToggleValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagToggleValue(entity, tagName);
	}

	protected string GetLogicTagStringValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagStringValue(entity, tagName);
	}

	protected FP GetLogicTagFpValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagFpValue(entity, tagName);
	}

	protected TSVector2 GetLogicTagTSVector2Value(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagTSVector2Value(entity, tagName);
	}

	protected void SetLogicTagToggleValue(LogicEntity entity, string tagName, bool value)
	{
		CommonUtils_MonsterAPI.SetLogicTagToggleValue(entity, tagName, value);
	}

	protected void SetLogicTagStringValue(LogicEntity entity, string tagName, string value)
	{
		CommonUtils_MonsterAPI.SetLogicTagStringValue(entity, tagName, value);
	}

	protected void SetLogicTagFpValue(LogicEntity entity, string tagName, FP value)
	{
		CommonUtils_MonsterAPI.SetLogicTagFpValue(entity, tagName, value);
	}

	protected void SetLogicTagTSVector2Value(LogicEntity entity, string tagName, TSVector2 value)
	{
		CommonUtils_MonsterAPI.SetLogicTagTSVector2Value(entity, tagName, value);
	}

	protected void SetLogicTagListTSVector2Value(LogicEntity entity, string tagName, List<TSVector2> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagListTSVector2Value(entity, tagName, value);
	}

	protected void SetLogicTagDicIntTSVector2Value(LogicEntity entity, string tagName, Dictionary<int, TSVector2> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagDicIntTSVector2Value(entity, tagName, value);
	}

	protected void SetLogicTagDicTSVector2LongValue(LogicEntity entity, string tagName, Dictionary<TSVector2, long> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagDicTSVector2LongValue(entity, tagName, value);
	}

	protected void SetLogicTagListLongValue(LogicEntity entity, string tagName, List<long> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagListLongValue(entity, tagName, value);
	}

	protected List<TSVector2> GetLogicTagListTSVector2Value(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagListTSVector2Value(entity, tagName);
	}

	protected Dictionary<int, TSVector2> GetLogicTagDicIntTSVector2Value(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagDicIntTSVector2Value(entity, tagName);
	}

	protected Dictionary<TSVector2, long> GetLogicTagDicTSVector2LongValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagDicTSVector2LongValue(entity, tagName);
	}

	protected List<long> GetLogicTagListLongValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagListLongValue(entity, tagName);
	}

	protected DeterministicShape GetShapeData(DeterministicShape.ShapeType shapeT = DeterministicShape.ShapeType.Circle, TSVector2 position = default(TSVector2), FP width = default(FP), FP length = default(FP), FP radius = default(FP), FP innerRadius = default(FP), FP angle = default(FP), FP rotation = default(FP))
	{
		return CommonUtils_MonsterAPI.GetShapeData(shapeT, position, width, length, radius, innerRadius, angle, rotation);
	}

	protected int randomWeight(int[] rdmWeights)
	{
		return CommonUtils_MonsterAPI.randomWeight(rdmWeights);
	}

	protected FP GetRandomValue(FP minValue, FP maxValue, bool isInt = false)
	{
		return CommonUtils_MonsterAPI.GetRandomValue(minValue, maxValue, isInt);
	}

	protected TSVector2 GetShapeRandomPoint(DeterministicShape shape, LogicEntity entity, bool isReachable = false)
	{
		return CommonUtils_MonsterAPI.GetShapeRandomPoint(shape, entity, isReachable);
	}

	protected FP Distance(TSVector2 value1, TSVector2 value2)
	{
		return CommonUtils_MonsterAPI.Distance(value1, value2);
	}

	protected TSVector2 GetTSVector2(FP x, FP y)
	{
		return CommonUtils_MonsterAPI.GetTSVector2(x, y);
	}

	protected FP GetTSVectToAngle(TSVector2 value, FP angle)
	{
		return CommonUtils_MonsterAPI.GetTSVectToAngle(value, angle);
	}

	protected TSVector2 TransLocalPosToWorldPos(TSVector2 csOrigin, TSVector2 csForward, TSVector2 relativePoint)
	{
		return CommonUtils_MonsterAPI.TransLocalPosToWorldPos(csOrigin, csForward, relativePoint);
	}

	protected TSVector2 RotateTo(TSVector2 from, FP angle)
	{
		return CommonUtils_MonsterAPI.RotateTo(from, angle);
	}

	protected FP AngleBetween2TSVector(TSVector2 from, TSVector2 to, bool signed)
	{
		return CommonUtils_MonsterAPI.AngleBetween2TSVector(from, to, signed);
	}

	protected void SetCanPerfectDodgeEnable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetCanPerfectDodgeEnable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.CanPerfectDodge);
		}
	}

	protected void SetCanPerfectDodgeDisable(bool autoEnableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetCanPerfectDodgeDisable(_actor);
		if (autoEnableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.CanPerfectDodge);
		}
	}

	protected void InterruptSkill()
	{
		CommonUtils_MonsterAPI.InterruptSkill(_skill);
	}

	protected void PlayWwiseSound(string _event, LogicEntity _owner = null)
	{
		CommonUtils_MonsterAPI.PlayWwiseSound(_actor, _event, _owner);
	}

	protected void TriggerOpLisener(string _triggerOpIDN)
	{
		CommonUtils_MonsterAPI.TriggerOpLisener(_triggerOpIDN);
	}

	protected bool MonsterInState(int state)
	{
		string[] array = _actor.logicVariable.GetLogicTagStringValue("Monster_In_State").Split(',');
		for (int i = 0; i < array.Length - 1; i++)
		{
			CommonUtils.TryParseStringParamToInt(array[i], out var intValue);
			if (intValue == state)
			{
				return true;
			}
		}
		return false;
	}

	protected void SendDeclareDeadEvent()
	{
		_actor.SendDeclareDeadEvent();
	}

	protected void DispatchCustomEvent(string eventName, bool isSelfEvent = true)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventName = eventName;
		if (isSelfEvent)
		{
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected void DispatchCustomEvent(int eventNameHash, bool isSelfEvent = true)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = eventNameHash;
		if (isSelfEvent)
		{
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected void DropItem(int itemId, TSVector2 position = default(TSVector2), FP posY = default(FP))
	{
		SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(_actor, itemId, position, posY);
	}

	protected void BossEnergyValueChage(int value, LogicEntity target)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BossEnergyValueChange", target.Id, value);
	}

	protected void EnergyHudShow(bool isShow, long showId, int initValue, int initState)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("EnergyHudShow", isShow, showId, initValue, initState);
	}

	protected CoroutineNode WaitTime(FP waitSeconds)
	{
		return StartCoroutine(_actor.WaitForSeconds(waitSeconds));
	}

	protected CoroutineNode WaitFrame(int frameCount)
	{
		FP seconds = (float)frameCount * 0.033f;
		return StartCoroutine(_actor.WaitForSeconds(seconds));
	}

	protected CoroutineNode WaitUntil(Func<bool> predicate)
	{
		return StartCoroutine(_actor.WaitUntil(predicate));
	}

	protected CoroutineNode BeginRotateAngle(FP angle, FP rotateSpeed)
	{
		CoroutineNode coroutineNode = StartCoroutine(beginRotateAngle(angle, rotateSpeed));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void BeginRotateAngle_NotWait(FP angle, FP rotateSpeed)
	{
		coroutineNodeList.Add(StartCoroutine(beginRotateAngle(angle, rotateSpeed)));
	}

	protected void BeginLookAtCameraDir_NotWait(DirectionType dirType, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		TSVector2 dir = TSVector2.zero;
		UnityEngine.Transform transform = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.transform;
		switch (dirType)
		{
		case DirectionType.UP:
			dir = new TSVector2(transform.up.x, transform.up.z);
			break;
		case DirectionType.Down:
			dir = new TSVector2(0f - transform.up.x, 0f - transform.up.z);
			break;
		case DirectionType.Left:
			dir = new TSVector2(0f - transform.right.x, 0f - transform.right.z);
			break;
		case DirectionType.Right:
			dir = new TSVector2(transform.right.x, transform.right.z);
			break;
		}
		coroutineNodeList.Add(StartCoroutine(beginLookAtByDir(dir, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle)));
	}

	protected CoroutineNode BeginLookAtCameraDir(DirectionType dirType, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		TSVector2 dir = TSVector2.zero;
		UnityEngine.Transform transform = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.transform;
		switch (dirType)
		{
		case DirectionType.UP:
			dir = new TSVector2(transform.up.x, transform.up.z);
			break;
		case DirectionType.Down:
			dir = new TSVector2(0f - transform.up.x, 0f - transform.up.z);
			break;
		case DirectionType.Left:
			dir = new TSVector2(0f - transform.right.x, 0f - transform.right.z);
			break;
		case DirectionType.Right:
			dir = new TSVector2(transform.right.x, transform.right.z);
			break;
		}
		CoroutineNode coroutineNode = StartCoroutine(beginLookAtByDir(dir, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void BeginLookAtByDir_NotWait(TSVector2 targetDir, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		coroutineNodeList.Add(StartCoroutine(beginLookAtByDir(targetDir, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle)));
	}

	protected CoroutineNode BeginLookAtByDir(TSVector2 targetDir, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		CoroutineNode coroutineNode = StartCoroutine(beginLookAtByDir(targetDir, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void BeginLookAtByPos_NotWait(TSVector2 targetPos, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		coroutineNodeList.Add(StartCoroutine(beginLookAtByPos(targetPos, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle)));
	}

	protected CoroutineNode BeginLookAtByPos(TSVector2 targetPos, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		CoroutineNode coroutineNode = StartCoroutine(beginLookAtByPos(targetPos, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected CoroutineNode BeginLookAt(LogicEntity target, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		CoroutineNode coroutineNode = StartCoroutine(beginLookAt(target, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void BeginLookAt_NotWait(LogicEntity target, FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		if (target != null)
		{
			coroutineNodeList.Add(StartCoroutine(beginLookAt(target, duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle)));
		}
	}

	protected CoroutineNode WaitLookAt(LogicEntity target, FP rotateTime, FP rotateSpd)
	{
		StartCoroutine(ref corRotate, waitLookAt(target, rotateTime, rotateSpd));
		coroutineNodeList.Add(corRotate);
		return corRotate;
	}

	protected void WaitLookAt_NoWait(LogicEntity target, FP rotateTime, FP rotateSpd)
	{
		if (!(target == null))
		{
			corRotate = StartCoroutine(waitLookAt(target, rotateTime, rotateSpd));
			coroutineNodeList.Add(corRotate);
		}
	}

	protected CoroutineNode BeginLookAtMonsterTarget(FP duration = default(FP), FP rotateSpeed = default(FP), FP stopAngle = default(FP))
	{
		CoroutineNode coroutineNode = StartCoroutine(beginLookAt(duration, rotateSpeed, ignoreActorTimeScale: false, stopAngle));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void StopWaitLookAt()
	{
		lookAtTarget?.StopLookAt();
		StopCoroutine(corRotate);
		corRotate = null;
	}

	protected void AimAtTarget(LogicEntity target, FP limtAngle = default(FP))
	{
		if (target != null)
		{
			_actor.AimAtTarget(target, limtAngle);
		}
	}

	protected void AimAtPosition(TSVector2 position, FP limitAngle = default(FP))
	{
		StartCoroutine(ref aimAtPositionCor, ContinueAimAtPosition(position, limitAngle));
	}

	private IEnumerator ContinueAimAtPosition(TSVector2 position, FP limitAngle)
	{
		while (true)
		{
			TSVector2 normalized = (position - _actor.tsTransform.Position).normalized;
			_actor.CancelAiming();
			_actor.Aim(normalized, limitAngle);
			yield return WaitFrame(1);
		}
	}

	protected void AimAtMonsterTarget(FP limitAngle = default(FP))
	{
		StartCoroutine(ref aimAtMonsterTargetCor, ContinueAimAtMonsterTarget(limitAngle));
	}

	private IEnumerator ContinueAimAtMonsterTarget(FP limitAngle)
	{
		while (_actor != null)
		{
			if ((_actor.monsterTarget != null || aimTarget != null) && aimTarget?.Id != _actor.monsterTarget?.Id)
			{
				_actor.CancelAiming();
				aimTarget = _actor.monsterTarget;
				if (aimTarget != null)
				{
					_actor.AimAtTarget(aimTarget, limitAngle);
				}
			}
			yield return WaitFrame(1);
		}
	}

	protected void AimDirection(TSVector2 direction, FP limitAngle = default(FP))
	{
		_actor.Aim(direction, limitAngle);
	}

	protected void CancelAim()
	{
		StopCoroutine(ref aimAtPositionCor);
		aimTarget = null;
		StopCoroutine(ref aimAtMonsterTargetCor);
		_actor.CancelAiming();
		_actor.SyncMovementLocation(clearPath: false);
	}

	protected void Blink_NotWait(ComboInputBuffer.ActionKey[] hideKeys, TSVector2 blinkPosition, FP blinkDuration, string blinkBeginFx, FP blinkHideDelay, string blinkFinishFx, FP blinkShowDelay, LogicEntity target = null, ComboInputBuffer.ActionKey[] showKeys = null, int showCombWaitIndex = 1, bool checkPositionReachable = true)
	{
		coroutineNodeList.Add(StartCoroutine(blink(hideKeys, blinkPosition, blinkDuration, blinkBeginFx, blinkHideDelay, blinkFinishFx, blinkShowDelay, target, showKeys, showCombWaitIndex, checkPositionReachable)));
	}

	protected CoroutineNode Blink(ComboInputBuffer.ActionKey[] hideKeys, TSVector2 blinkPosition, FP blinkDuration, string blinkBeginFx, FP blinkHideDelay, string blinkFinishFx, FP blinkShowDelay, LogicEntity target = null, ComboInputBuffer.ActionKey[] showKeys = null, int showCombWaitIndex = 1, bool checkPositionReachable = true)
	{
		CoroutineNode coroutineNode = StartCoroutine(blink(hideKeys, blinkPosition, blinkDuration, blinkBeginFx, blinkHideDelay, blinkFinishFx, blinkShowDelay, target, showKeys, showCombWaitIndex, checkPositionReachable));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void Teleport(TSVector2 targetPosition, bool checkPositionReachable = true)
	{
		if (!checkPositionReachable || QueryPositionReachable(_actor, targetPosition))
		{
			_actor.Teleport(targetPosition);
		}
	}

	protected Dash BeginDash(int index, TSVector2 direction, FP speed, FP distance, FP angleLimit, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, FP minDashTime = default(FP))
	{
		if (dashReq == null)
		{
			dashReq = new RequestDash();
		}
		dashReq.Reset(index);
		ref Dash reference = ref dash;
		AdventureActor actor = _actor;
		bool comboWithAttack2 = comboWithAttack;
		bool isAngle2 = isAngle;
		bool notChangeForward2 = notChangeForward;
		bool triggerObstacleStop2 = triggerObstacleStop;
		bool triggerEnemyStop2 = triggerEnemyStop;
		bool triggerFriendStop2 = triggerFriendStop;
		ILRuntimeAPI.BeginDash(ref reference, actor, direction, speed, distance, angleLimit, DashFinish, DashFinishByActor, DashFinishByObstacle, comboWithAttack2, isAngle2, notChangeForward2, triggerObstacleStop2, triggerEnemyStop2, triggerFriendStop2, checkStop: false, minDashTime);
		return dash;
	}

	protected Dash BeginDashActorForward(int index, FP speed, FP distance, FP angleLimit, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, FP minDashTime = default(FP))
	{
		if (dashReq == null)
		{
			dashReq = new RequestDash();
		}
		dashReq.Reset(index);
		ref Dash reference = ref dash;
		AdventureActor actor = _actor;
		bool comboWithAttack2 = comboWithAttack;
		bool isAngle2 = isAngle;
		bool notChangeForward2 = notChangeForward;
		bool triggerObstacleStop2 = triggerObstacleStop;
		bool triggerEnemyStop2 = triggerEnemyStop;
		bool triggerFriendStop2 = triggerFriendStop;
		ILRuntimeAPI.BeginDashActorForward(ref reference, actor, speed, distance, angleLimit, DashFinish, DashFinishByActor, DashFinishByObstacle, comboWithAttack2, isAngle2, notChangeForward2, triggerObstacleStop2, triggerEnemyStop2, triggerFriendStop2, minDashTime);
		return dash;
	}

	protected CoroutineNode BeginDashWithAcc(int index, string key, FP acceleration, FP initialVelocity, FP maxVelocity, bool useComboSpd, FP initialComboSpd, FP maxComboSpd, FP step, FP distance, FP angleLimit, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, FP minDashTime = default(FP))
	{
		CoroutineNode coroutineNode = StartCoroutine(LoopDashWithAcc(index, key, acceleration, initialVelocity, maxVelocity, useComboSpd, initialComboSpd, maxComboSpd, step, distance, angleLimit, comboWithAttack, isAngle, notChangeForward, triggerObstacleStop, triggerEnemyStop, triggerFriendStop, minDashTime));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected IEnumerator LoopDashWithAcc(int index, string key, FP acceleration, FP initialVelocity, FP maxVelocity, bool useComboSpd, FP initialComboSpd, FP maxComboSpd, FP step, FP distance, FP angleLimit, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, FP minDashTime = default(FP))
	{
		if (dashReq == null)
		{
			dashReq = new RequestDash();
		}
		dashReq.Reset(index);
		BeginAttack(1, key, flushInputedKeys: true, forceInterruptAttack: true);
		if (useComboSpd)
		{
			_actor.actorInfo.ComboSpdMultiplier = initialComboSpd;
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		FP totleTime = CommonUtils.GetDurationByAcc(acceleration, initialVelocity, maxVelocity, distance);
		_ = _actor.LogicTime;
		ILRuntimeAPI.BeginDashActorForward(ref dash, _actor, initialVelocity, distance, angleLimit, DashFinish, DashFinishByActor, DashFinishByObstacle, comboWithAttack, isAngle, notChangeForward, triggerObstacleStop, triggerEnemyStop, triggerFriendStop, minDashTime);
		FP elapsedTime = 0;
		FP stepTime = 0;
		bool interrupt = false;
		while (elapsedTime < totleTime)
		{
			if (dashReq.dashStatus != DashStatus.Running)
			{
				interrupt = true;
				break;
			}
			if (stepTime > step)
			{
				FP fP = initialVelocity + acceleration * elapsedTime;
				if (fP < maxVelocity)
				{
					dash.ChangeDashSpeed(acceleration * step);
				}
				fP = TSMath.Clamp(fP, initialVelocity, maxVelocity);
				if (useComboSpd)
				{
					FP value = initialComboSpd + (maxComboSpd - initialComboSpd) * (fP - initialVelocity) / (maxVelocity - initialVelocity);
					value = TSMath.Clamp(value, initialComboSpd, maxComboSpd);
					_actor.actorInfo.ComboSpdMultiplier = value;
				}
				stepTime = 0;
			}
			elapsedTime += _actor.LogicDeltaTime;
			stepTime += _actor.LogicDeltaTime;
			yield return null;
		}
		if (!interrupt)
		{
			StopDash();
		}
	}

	private void DashFinish()
	{
		_actor.actorInfo.ComboSpdMultiplier = 1;
		dashReq.dashStatus = DashStatus.Complete;
		OnDashFinish(dashReq.dashIndex);
	}

	private void DashFinishByActor()
	{
		_actor.actorInfo.ComboSpdMultiplier = 1;
		dashReq.dashStatus = DashStatus.DashActor;
		DashFinishByActor(dashReq.dashIndex);
		if (_actor.logicVariable != null && _actor.logicVariable.GetLogicTagValue("finishType") == 2)
		{
			DashFinishByFriend(dashReq.dashIndex);
		}
	}

	private void DashFinishByObstacle()
	{
		_actor.actorInfo.ComboSpdMultiplier = 1;
		dashReq.dashStatus = DashStatus.DashObstacle;
		DashFinishByObstacle(dashReq.dashIndex);
	}

	protected virtual void OnDashFinish(int index)
	{
	}

	protected virtual void DashFinishByActor(int index)
	{
	}

	protected virtual void DashFinishByFriend(int index)
	{
	}

	protected virtual void DashFinishByObstacle(int index)
	{
	}

	protected CoroutineNode WaitDashFinish(DashStatus dashStatus = DashStatus.Running)
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(_waitDash(dashStatus));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	private IEnumerator _waitDash(DashStatus dashStatus)
	{
		if (dashReq != null)
		{
			while (dashReq.dashStatus == dashStatus)
			{
				yield return null;
			}
			if (dashReq.dashStatus != DashStatus.Running)
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.eventHashCode = evt_DashEnd;
				adventureActorCustomEvent.boolParam = CheckHitPlayer();
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
	}

	protected void StopDash()
	{
		if (dash != null)
		{
			dash.Interrupte();
			dashReq.dashStatus = DashStatus.Cancel;
			OnDashFinish(dashReq.dashIndex);
			_actor.actorInfo.ComboSpdMultiplier = 1;
			ILRuntimeAPI.ClearDash(dash);
		}
	}

	protected bool CheckHitPlayer()
	{
		return _actor.GetLogicComponent<LogicVariable>()?.GetLogicTagToggle("hitPlayer") ?? false;
	}

	protected void MoveToPosition(TSVector2 position, FP stopDistance, AdventureActor.MovementMode moveMode = AdventureActor.MovementMode.Run, FP _maxDuration = default(FP), bool _stopDisIgnoreRadius = true)
	{
		if (!(_actor == null))
		{
			if (_maxDuration == default(FP))
			{
				_maxDuration = 5;
			}
			if (moveReq == null)
			{
				moveReq = new RequestDefaultState();
			}
			AdventureActor actor = _actor;
			Action onLeave = MoveFinish;
			bool stopDisIgnoreRadius = _stopDisIgnoreRadius;
			if (actor.MoveTo(position, stopDistance, enableNavigation: true, moveMode, null, randomMove: false, forceMove: false, default, onLeave, stayWhenReachTarget: false, stopDisIgnoreRadius))
			{
				moveReq.Reset();
				StartCor(ref waitDurationCorNode, waitMoveDuration(_maxDuration));
			}
			else
			{
				MoveFinish();
			}
		}
	}

	private IEnumerator waitMoveDuration(FP _maxDuration)
	{
		yield return WaitTime(_maxDuration);
		StopMove();
		MoveFinish();
	}

	private void MoveFinish()
	{
		moveReq.defalutStatus = BaseNormalStatus.Complete;
		StopCor(waitDurationCorNode);
	}

	protected void StopMove()
	{
		if (!(_actor == null) && _actor.movementState == ActorState.Move)
		{
			_actor.StandBy();
		}
	}

	protected CoroutineNode WaitMoveStatus(BaseNormalStatus moveStatus = BaseNormalStatus.Complete)
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(_waitMove(moveStatus));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	private IEnumerator _waitMove(BaseNormalStatus normalStatus)
	{
		if (moveReq != null)
		{
			while (moveReq.defalutStatus != normalStatus)
			{
				yield return null;
			}
		}
	}

	protected void BeginTrace(LogicEntity target, FP stopDistance, FP cancelDistance, FP cancelTime)
	{
		if (_traceTarget == null)
		{
			_traceTarget = new TraceTarget();
		}
		if (traceReq == null)
		{
			traceReq = new RequestTrace();
		}
		traceReq.Reset(0);
		_traceTarget.BeginTrace(_actor, target, stopDistance, cancelDistance, cancelTime, traceFinish, traceCancel);
	}

	protected void StopTrace()
	{
		if (_traceTarget != null)
		{
			_traceTarget.CancelTrace();
		}
	}

	private void traceFinish()
	{
		traceReq.traceStatus = TraceStatus.Complete;
	}

	private void traceCancel(bool targetDied, bool isInterrupt, bool isTimeout, bool isDistanceOut)
	{
		traceReq.traceStatus = TraceStatus.Cancel;
	}

	protected CoroutineNode WaitTraceFinish()
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(_waitTrace());
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	private IEnumerator _waitTrace()
	{
		if (traceReq != null)
		{
			while (traceReq.traceStatus == TraceStatus.Traceing)
			{
				yield return null;
			}
		}
	}

	public TraceStatus GetTraceStatus()
	{
		return traceReq.traceStatus;
	}

	protected CoroutineNode CrossJump(TSVector2 targetPosition, FP speed, FP duration, bool checkPositionReachable = true)
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(crossJump(targetPosition, speed, duration, comboWithAttack: true, forbiddenHeight: true, checkPositionReachable));
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void BeginBezierPathMove(int indexId, TSVector2 targetPosition, FP controlPointXOffsetRatio, FP controlPointYOffsetRatio, bool comboWithAttack = false, FP moveSpeedRatioAbsAmend = default(FP), AdventureActor.MovementMode movementMode = AdventureActor.MovementMode.Run, int moveStep = 80, FP _maxDuration = default(FP))
	{
		if (!(_actor == null))
		{
			if (_maxDuration == default(FP))
			{
				_maxDuration = 5;
			}
			if (_bezierPathMoveReq == null)
			{
				_bezierPathMoveReq = new RequestBezierPathMove();
			}
			_bezierPathMoveReq.Reset(indexId);
			ILRuntimeAPI.BeginBezierPathMove(ref _bezierPathMove, _actor, targetPosition, controlPointXOffsetRatio, controlPointYOffsetRatio, comboWithAttack, moveSpeedRatioAbsAmend, movementMode, moveStep, BezierPathMoveFinishCallback, _maxDuration);
		}
	}

	private void BezierPathMoveFinishCallback(bool reachTerminal)
	{
		_bezierPathMoveReq.status = BaseNormalStatus.Complete;
		OnBezierPathMoveFinish(_bezierPathMoveReq.index, reachTerminal);
	}

	protected virtual void OnBezierPathMoveFinish(int index, bool reachTerminal)
	{
	}

	protected void CancelBezierPathMove()
	{
		ILRuntimeAPI.CancelBezierPathMove(_bezierPathMove);
	}

	protected CoroutineNode WaitBezierPathMoveFinish()
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(WaitBezierPathMoveStatus());
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	private IEnumerator WaitBezierPathMoveStatus(BaseNormalStatus status = BaseNormalStatus.Complete)
	{
		if (_bezierPathMoveReq != null)
		{
			while (_bezierPathMoveReq.status != status)
			{
				yield return null;
			}
		}
	}

	protected void ShowBlood(bool isShow)
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			monsterAdventureActor.ShowBlood(isShow);
		}
	}

	protected void ShowCenterHpBar()
	{
		if (_actor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.ShowCenterHpBar(isShow: true);
			TriggerOpLisener("StartClock");
		}
	}

	protected void RefreshCenterHpBar()
	{
		ModuleController<AdventureModuleController>.Instance?.RefreshCenterHpBar();
	}

	protected void ModelNodeShow(string nodeName, bool isShow)
	{
		if (!(_actor == null))
		{
			UnityEngine.Transform transform = _actor.transform.Find(nodeName);
			if (transform != null)
			{
				transform.gameObject.SetActive(isShow);
			}
		}
	}

	protected void ReplaceAnimationGroup(int index = 0)
	{
		_actor.ReplaceAnimationGroup(index);
	}

	protected void PlayFeedbackEffect(string alias, TSVector2 blurPosition = default(TSVector2))
	{
		if (!string.IsNullOrEmpty(alias) && !(_actor.comboGroup == null))
		{
			AdventurePlayerFeedbackEffectConfigureData feedbackEffectConfigureDataByAlias = ModuleController<AdventureModuleController>.Instance.GetFeedbackEffectConfigureDataByAlias(_actor, alias);
			if (feedbackEffectConfigureDataByAlias != null)
			{
				Vector3 effectPosition = new Vector3((float)blurPosition.x, 0f, (float)blurPosition.y);
				int num = 0;
				feedbackEffectConfigureDataByAlias.Play(cameraShakeSort: (!(_actor is PlayerAdventureActor playerAdventureActor)) ? 2 : ((!playerAdventureActor.isAssist) ? 1 : (-1)), effectPosition: effectPosition, effectTarget: _actor.gameObject);
			}
			else
			{
				NovaLogger.Error(_actor.name + "的资源配置文件中未找到别名为:" + alias + "的反馈效果");
			}
		}
	}

	protected void PlayTimeline(int index = 0)
	{
		if (_isTimelinePlaying)
		{
			NovaLogger.Error("播放失败," + _actor.name + "已有正在播放的Timeline");
			return;
		}
		_isTimelinePlaying = true;
		ILRuntimeAPI.PlayMonsterTimeline(ref _playMonsterTimeline, _actor, () =>
		{
			_isTimelinePlaying = false;
		}, () =>
		{
			_isTimelinePlaying = false;
		}, index);
	}

	protected bool IsTimelineFinish()
	{
		return !_isTimelinePlaying;
	}

	protected void AttackHintShow()
	{
		(_actor as MonsterAdventureActor).AttackHintShow();
	}

	protected void AttackHintHide()
	{
		(_actor as MonsterAdventureActor).AttackHintHide();
	}

	protected void AttackHint()
	{
		(_actor as MonsterAdventureActor).AttackHint();
	}

	protected void AttackHintCancel()
	{
		(_actor as MonsterAdventureActor).AttackHintCancel();
	}

	protected void AttackHintEnd()
	{
		(_actor as MonsterAdventureActor).AttackHintEnd();
	}

	protected void SwitchCameraSetting(bool active, string cameraName)
	{
		if (active)
		{
			ModuleController<AdventureModuleController>.Instance.ActivePlayerCameraTrigger(cameraName);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.DeactivePlayerCameraTrigger(cameraName);
		}
	}

	protected void FireStateValueChange(int state)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("HotStateChange", _actor.Id, state);
	}

	protected void FireHotValueChange(int value)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("HotValueChange", _actor.Id, value);
	}

	protected void FireHudShow(bool isShow, long showId, int initValue, int initState)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("SpecialHudShow", isShow, showId, initValue, initState);
	}

	protected void TransparentFadeIn(float transparency, float duration)
	{
		_actor.TransparentFadeIn(transparency, duration);
	}

	protected void TransparentFadeOut(float transparency = -1f, float duration = 0.5f)
	{
		_actor.TransparentFadeOut(transparency, duration);
	}

	protected void ChangeModelScale(bool setAbsValue = false, FP value = default(FP), FP duration = default(FP))
	{
		if (_changeModelScaleCor != null)
		{
			StopCor(_changeModelScaleCor);
		}
		FP modelScale = _actor.actorScaleInfo.modelScale;
		FP fP = ((!setAbsValue) ? (modelScale + value) : value);
		fP = ((fP >= 0) ? fP : ((FP)0));
		if (duration > 0)
		{
			_changeModelScaleCor = StartCor(ChangeModelScale(fP, duration));
		}
		else
		{
			_actor.actorScaleInfo.modelScale = fP;
		}
	}

	protected void TransformByModelName(string modelName, bool changeColliderScale = false, FP colliderScale = default(FP), bool changeAnimationGroup = false, int animationGroupIndex = 0)
	{
		_actor.ActiveVariantModelGroup(modelName);
		if (changeColliderScale)
		{
			_actor.actorScaleInfo.colliderScale = colliderScale;
		}
		if (changeAnimationGroup)
		{
			ReplaceAnimationGroup(animationGroupIndex);
		}
	}

	protected void ReturnToDefaultModel()
	{
		_actor.ActiveDefaultModelGroup();
		_actor.actorScaleInfo.colliderScale = _actor.actorScaleInfo.originColliderScale;
		_actor.ResumeAnimationGroup();
	}

	protected void SetStrengthOverride(FP overrideValue)
	{
		_actor.strengthOverride = overrideValue;
	}

	protected long PlayEffect(string fxAlias, float playbackSpeed = 1f, FP fxPositionY = default(FP), TSVector2 position = default(TSVector2), FP angle = default(FP), float spawnSize = 1f, bool actorScale = false)
	{
		PlayFX playFX = GeneratePlayFX();
		playFX.Play(spawnRotation: Quaternion.Euler(0f, 0f - (float)angle, 0f), actor: _actor, fxAlias: fxAlias, playbackSpeed: playbackSpeed, fxPositionY: fxPositionY, position: position, parent: null, spawnSize: spawnSize, actorScale: actorScale);
		return playFX.GetFxPlayerToken();
	}

	protected long PlaySceneEffect(string fxAlias, float playbackSpeed = 1f, FP fxPositionY = default(FP), TSVector2 position = default(TSVector2), FP angle = default(FP), float spawnSize = 1f)
	{
		fxAlias = "Assets/AssetBundles/" + fxAlias + ".prefab";
		GameObject obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, fxAlias, typeof(GameObject)) as GameObject;
		if (obj == null)
		{
			Debug.LogError("play fx,path :" + fxAlias + " not exit");
		}
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)angle, 0f);
		Vector3 spawnPosition = new Vector3((float)position.x, (float)fxPositionY, (float)position.y);
		AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(obj, playbackSpeed, spawnPosition, spawnRotation, spawnSize);
		if (adventureFXPlayer != null)
		{
			_adFxList.Add(adventureFXPlayer);
			return adventureFXPlayer.token;
		}
		return 0L;
	}

	protected long PlayLinkEffect(string fxAlias, bool useCustomSource, LogicEntity source = null, TSVector2 sourcePosition = default(TSVector2), FP sourcePositionY = default(FP), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), bool breakWhenLostSourceOrTarget = true, float spawnSize = 1f, bool actorScale = false, float playbackSpeed = 1f)
	{
		if (playLinkFXList == null)
		{
			playLinkFXList = new List<PlayFX>(5);
		}
		PlayFX playFX = null;
		for (int i = 0; i < playLinkFXList.Count; i++)
		{
			if (playLinkFXList.get_Item(i).GetFxPlayerToken() == 0L)
			{
				playFX = playLinkFXList.get_Item(i);
				break;
			}
		}
		if (playFX == null)
		{
			playFX = new PlayFX();
			playLinkFXList.Add(playFX);
		}
		playFX.PlayLinFx(sourcePosition: new TSVector(sourcePosition.x, _actor.tsTransform.PositionY, sourcePosition.y), targetPosition: new TSVector(targetPosition.x, _actor.tsTransform.PositionY, targetPosition.y), actor: _actor, fxAlias: fxAlias, playbackSpeed: playbackSpeed, useCustSource: useCustomSource, source: source?.gameObject, sourcePositionY: sourcePositionY, targetObj: target?.gameObject, targetPositionY: targetPositionY, spawnSize: spawnSize, actorScale: actorScale, breakWhenLostSourceOrTarget: breakWhenLostSourceOrTarget);
		return playFX.GetFxPlayerToken();
	}

	protected long PlayEarlyWarningEffect(string fxAlias, float duration, FP fxPositionY = default(FP), TSVector2 position = default(TSVector2), FP angle = default(FP), float spawnSize = 1f, bool actorScale = false)
	{
		PlayFX playFX = GeneratePlayFX();
		playFX.PlayEarlyWarningFx(spawnRotation: Quaternion.Euler(0f, 0f - (float)angle, 0f), actor: _actor, skill: null, fxAlias: fxAlias, fxDuration: duration, fxPositionY: fxPositionY, position: position, spawnSize: spawnSize, actorScale: actorScale);
		return playFX.GetFxPlayerToken();
	}

	protected void CompleteEarlyWarningEffect(long id)
	{
		for (int i = 0; i < _playFXList.Count; i++)
		{
			if (_playFXList.get_Item(i).GetFxPlayerToken() == id)
			{
				_playFXList.get_Item(i).Complete();
				break;
			}
		}
	}

	protected void StopEffect(long id, bool stopSubFx = false)
	{
		for (int i = 0; i < _playFXList.Count; i++)
		{
			if (_playFXList.get_Item(i).GetFxPlayerToken() == id)
			{
				if (stopSubFx)
				{
					_playFXList.get_Item(i).StopSubFx();
				}
				_playFXList.get_Item(i).Stop();
				_playFXList.get_Item(i).Clear();
				break;
			}
		}
		if (playFXList != null && playFXList.Count > 0)
		{
			for (int j = 0; j < playFXList.Count; j++)
			{
				if (playFXList.get_Item(j).GetFxPlayerToken() == id)
				{
					if (stopSubFx)
					{
						playFXList.get_Item(j).StopSubFx();
					}
					playFXList.get_Item(j).Stop();
					playFXList.get_Item(j).Clear();
					break;
				}
			}
		}
		if (playLinkFXList != null && playLinkFXList.Count > 0)
		{
			for (int k = 0; k < playLinkFXList.Count; k++)
			{
				if (playLinkFXList.get_Item(k).GetFxPlayerToken() == id)
				{
					if (stopSubFx)
					{
						playLinkFXList.get_Item(k).StopSubFx();
					}
					playLinkFXList.get_Item(k).Stop();
					playLinkFXList.get_Item(k).Clear();
					break;
				}
			}
		}
		if (_adFxList == null || _adFxList.Count <= 0)
		{
			return;
		}
		for (int l = 0; l < _adFxList.Count; l++)
		{
			if (_adFxList.get_Item(l).token == id)
			{
				_adFxList.get_Item(l).Stop(stopSubFx);
				break;
			}
		}
	}

	protected void BeginRotateEffect(long id, FP rotateAngle, FP rotateSpeed)
	{
		if (id == 0L)
		{
			NovaLogger.Error("特效ID参数有误");
			return;
		}
		if (rotateAngle == 0 || rotateSpeed <= 0)
		{
			NovaLogger.Error("特效旋转角度、旋转速度参数有误");
			return;
		}
		if (_rotateFXCorDic.ContainsKey(id))
		{
			_actor.StopLogicCoroutine(_rotateFXCorDic.get_Item(id));
		}
		_rotateFXCorDic.set_Item(id, _actor.StartLogicCoroutine(RotatePlayFXCor(id, rotateAngle, rotateSpeed)));
	}

	protected void StopRotateEffect(long id)
	{
		if (_rotateFXCorDic.ContainsKey(id))
		{
			_actor.StopLogicCoroutine(_rotateFXCorDic.get_Item(id));
			_rotateFXCorDic.Remove(id);
		}
	}

	protected void ModifyEffectPosition(long id, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), LogicEntity targetEntity = null)
	{
		PlayFX playFXByToken = GetPlayFXByToken(id);
		if (playFXByToken == null || !playFXByToken.isPlaying)
		{
			return;
		}
		AdventureFXPlayer fxInstance = playFXByToken.fxInstance;
		if (targetEntity != null)
		{
			fxInstance.transform.position = targetEntity.transform.position;
			return;
		}
		float y = fxInstance.transform.position.y;
		if (targetPositionY != default(FP))
		{
			y = targetPositionY.AsFloat();
		}
		fxInstance.transform.position = new Vector3(targetPosition.x.AsFloat(), y, targetPosition.y.AsFloat());
	}

	public void PlayMovableFx(string fxAlias, Vector3 startPosition, Vector3 targetPosition, float speed, Action finishCallback = null)
	{
		_actor.PlayMovableFx(fxAlias, startPosition, targetPosition, speed, finishCallback);
	}

	private IEnumerator RotatePlayFXCor(long fxPlayerToken, FP rotateAngle, FP rotateSpeed)
	{
		PlayFX playFX = GetPlayFXByToken(fxPlayerToken);
		if (playFX == null)
		{
			yield break;
		}
		FP rotateTime = 0;
		if (rotateSpeed != 0)
		{
			rotateTime = TSMath.Abs(rotateAngle / rotateSpeed);
		}
		FP signRotateSpeed = TSMath.Sign(rotateAngle) * rotateSpeed;
		AdventureFXPlayer fx = playFX.fxInstance;
		Rot rot = new Rot((0f - fx.transform.rotation.eulerAngles.y) * FP.Deg2Rad);
		TSVector2 forward = new TSVector2(-rot.s, rot.c);
		TSVector2 targetForward = TSVector2.Rotate(forward, rotateAngle);
		while (playFX.isPlaying && rotateTime > 0)
		{
			if (rotateTime > _actor.LogicDeltaTime)
			{
				forward = TSVector2.Rotate(forward, signRotateSpeed * _actor.LogicDeltaTime);
				fx.transform.rotation = Quaternion.Euler(0f, 0f - forward.GetAngle().AsFloat(), 0f);
				rotateTime -= _actor.LogicDeltaTime;
				yield return null;
				continue;
			}
			fx.transform.rotation = Quaternion.Euler(0f, 0f - targetForward.GetAngle().AsFloat(), 0f);
			break;
		}
	}

	private PlayFX GetPlayFXByToken(long fxPlayerToken)
	{
		if (fxPlayerToken == 0L)
		{
			return null;
		}
		for (int i = 0; i < _playFXList.Count; i++)
		{
			if (_playFXList.get_Item(i).GetFxPlayerToken() == fxPlayerToken)
			{
				return _playFXList.get_Item(i);
			}
		}
		return null;
	}

	private PlayFX GeneratePlayFX()
	{
		PlayFX playFX = null;
		for (int i = 0; i < _playFXList.Count; i++)
		{
			if (_playFXList.get_Item(i).GetFxPlayerToken() == 0L)
			{
				playFX = _playFXList.get_Item(i);
				break;
			}
		}
		if (playFX == null)
		{
			playFX = new PlayFX();
			_playFXList.Add(playFX);
		}
		return playFX;
	}

	private void ClearFx()
	{
		foreach (CoroutineNode value in _rotateFXCorDic.Values)
		{
			_actor.StopLogicCoroutine(value);
		}
		_rotateFXCorDic.Clear();
		_adFxList.Clear();
		for (int i = 0; i < _playFXList.Count; i++)
		{
			if (_playFXList.get_Item(i).isPlaying && _playFXList.get_Item(i).isLoop)
			{
				_playFXList.get_Item(i).Stop();
			}
			_playFXList.get_Item(i).Clear();
		}
	}

	protected bool AreaCheckObstacle(DeterministicShape shape, bool checkHeight = false, HeightClass heightClass = HeightClass.Medium)
	{
		return CommonUtils_MonsterAPI.AreaCheckObstacle(shape, checkHeight, heightClass);
	}

	protected bool QueryPositionReachable(LogicEntity entity, TSVector2 position)
	{
		if (null == entity)
		{
			return false;
		}
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return false;
		}
		FP groundHeightByActorMoveType = CommonHelper.GetGroundHeightByActorMoveType(adventureActor, position, adventureActor.tsTransform.PositionY);
		return adventureActor.QueryPositionReachable(position, groundHeightByActorMoveType);
	}

	protected bool CheckTargetIsValid(LogicEntity target)
	{
		return CommonUtils_MonsterAPI.CheckTargetIsValid(target);
	}

	protected bool AreaCheckMonsterTarget(DeterministicShape shape)
	{
		return CommonUtils_MonsterAPI.AreaCheckMonsterTarget(_actor, shape);
	}

	protected bool CheckBossTag(LogicEntity target, string tag)
	{
		if (target is MonsterAdventureActor monsterAdventureActor)
		{
			return monsterAdventureActor.CheckTag(tag);
		}
		return false;
	}

	protected long GetTargetID(LogicEntity actor = null)
	{
		return CommonUtils_MonsterAPI.GetTargetID(actor);
	}

	[Obsolete("请使用GetEntityPosition(LogicEntity entity)")]
	protected TSVector2 GetEntityPositionObsoleted(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityPosition(entity);
	}

	protected TSVector2 GetEntityPosition(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityPosition(entity, _actor);
	}

	protected TSVector2 GetEntityForward(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityForward(entity);
	}

	protected FP GetEntityAngle(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityAngle(entity);
	}

	protected FP GetRotSpdInSkill()
	{
		return CommonUtils_MonsterAPI.GetRotSpdInSkill(_actor);
	}

	protected TSVector2 GetPosition()
	{
		return CommonUtils_MonsterAPI.GetPosition(_actor);
	}

	protected TSVector2 GetForward()
	{
		return CommonUtils_MonsterAPI.GetForward(_actor);
	}

	protected FP GetRotation()
	{
		return CommonUtils_MonsterAPI.GetRotation(_actor);
	}

	protected LogicEntity GetCurrentPlayer()
	{
		return CommonUtils_MonsterAPI.GetCurrentPlayer();
	}

	protected int GetMonsterSummonNum(LogicEntity actor, int monsterID = -1, bool iAlive = true)
	{
		return CommonUtils_MonsterAPI.GetMonsterSummonNum(actor, monsterID, iAlive);
	}

	protected FP GetDistanceWithTarget(bool calcDistanceWithoutEntityRadius)
	{
		return CommonUtils_MonsterAPI.GetDistanceWithTarget(_actor, calcDistanceWithoutEntityRadius);
	}

	protected LogicEntity GetAttackTarget(bool isUpToDate = false)
	{
		return CommonUtils_MonsterAPI.GetAttackTarget(_actor, isUpToDate);
	}

	protected LogicEntity GetAttackTargetWithOwnerTauntFrom(long ownerId)
	{
		return CommonUtils_MonsterAPI.GetAttackTargetWithOwnerTauntFrom(ownerId);
	}

	protected FP CalcAngleBetweenSelfAndAttackTarget(bool isSingleAngle = false)
	{
		return CommonUtils_MonsterAPI.CalcAngleBetweenSelfAndAttackTarget(_actor, isSingleAngle);
	}

	protected TSVector2 GetPlaceHolderPosition(string name)
	{
		return CommonUtils_MonsterAPI.GetPlaceHolderPosition(name);
	}

	protected int GetMonsterSummonNumWithTeammateIndex(LogicEntity actor, int teammateIndex = -1, bool iAlive = true)
	{
		int monsterID = teammateIndex;
		if (teammateIndex != -1)
		{
			monsterID = GetTeammateIdByIndex(teammateIndex);
		}
		return CommonUtils_MonsterAPI.GetMonsterSummonNum(actor, monsterID, iAlive);
	}

	protected int GetTeammateIdByIndex(int index)
	{
		return CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, index);
	}

	protected TSVector2 GetAreaEffectPosition(long areaEffectId)
	{
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(areaEffectId);
		if (!(areaEffect != null))
		{
			return TSVector2.zero;
		}
		return areaEffect.tsTransform.Position;
	}

	protected TSVector2 GetAreaEffectForward(long areaEffectId)
	{
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(areaEffectId);
		if (!(areaEffect != null))
		{
			return TSVector2.zero;
		}
		return areaEffect.tsTransform.Forward;
	}

	protected AdventureActor GetMonsterCloner()
	{
		if (_actor is MonsterCloneAdventureActor monsterCloneAdventureActor)
		{
			return monsterCloneAdventureActor.summoner;
		}
		return _actor;
	}

	protected int GetPlayerJobType(AdventureActor player)
	{
		if (player is PlayerAdventureActor)
		{
			return (int)player.actorInfo.attackType;
		}
		return 0;
	}

	protected string GetMonsterTagValue(AdventureActor actor, int tagIndex)
	{
		if (actor is MonsterAdventureActor monsterAdventureActor)
		{
			return tagIndex switch
			{
				1 => monsterAdventureActor.monsterInfo.Tag1, 
				2 => monsterAdventureActor.monsterInfo.Tag2, 
				3 => monsterAdventureActor.monsterInfo.Tag3, 
				4 => monsterAdventureActor.monsterInfo.Tag4, 
				5 => monsterAdventureActor.monsterInfo.Tag5, 
				_ => "", 
			};
		}
		return "";
	}

	protected bool EntityInSkill(LogicEntity entity = null, int skillId = 0)
	{
		return CommonUtils_MonsterAPI.EntityInSkill((entity != null) ? entity : _actor, skillId);
	}

	protected List<LogicEntity> GetTargetsByLogicTag(LogicTagType logicType, string logicStr, List<LogicEntity> entities = null, bool value1 = false, FP value2 = default(FP), string value3 = null, TSVector2 value4 = default(TSVector2))
	{
		return CommonUtils_MonsterAPI.GetTargetByLogicTag(logicType, logicStr, entities, value1, value2, value3, value4);
	}

	protected List<LogicEntity> GetTargetsFromShape(DeterministicShape shape, List<LogicEntity> entities = null, bool includeSelf = false, LogicEntity targetEntity = null)
	{
		return CommonUtils_MonsterAPI.GetTargetsFromShape(_actor, shape, entities, includeSelf, targetEntity);
	}

	protected LogicEntity GetTargetNearOrFar(bool iNear, List<LogicEntity> entities)
	{
		return CommonUtils_MonsterAPI.GetTargetNearOrFar(_actor, iNear, entities);
	}

	protected List<LogicEntity> GetTargetsByFaction(bool isFriend)
	{
		return CommonUtils_MonsterAPI.GetTargetsByFaction(_actor, isFriend);
	}

	protected LogicEntity GetTargetHp(bool hpMin, List<LogicEntity> entities, bool isAbs)
	{
		return CommonUtils_MonsterAPI.GetTargetHp(hpMin, entities, isAbs);
	}

	protected List<LogicEntity> GetTargetByDataID(int dataID, List<LogicEntity> entities = null)
	{
		return CommonUtils_MonsterAPI.GetTargetByDataID(dataID, entities);
	}

	protected LogicEntity GetTargetByID(long id, List<LogicEntity> entities = null)
	{
		return CommonUtils_MonsterAPI.GetTargetByID(id, entities);
	}

	protected List<LogicEntity> GetTargetByDataIDs(List<int> dataIDs)
	{
		return CommonUtils_MonsterAPI.GetTargetByDataIDs(dataIDs);
	}

	protected List<LogicEntity> GetTargetByBuffID(int BuffID, List<LogicEntity> entities = null)
	{
		return CommonUtils_MonsterAPI.GetTargetByBuffID(BuffID, entities);
	}

	protected List<LogicEntity> GetTargetByTeammateIndex(int index, List<LogicEntity> entities = null)
	{
		int dataID = 0;
		if (_actor != null && _actor is MonsterAdventureActor monsterAdventureActor)
		{
			dataID = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, index);
		}
		return GetTargetByDataID(dataID, entities);
	}

	protected List<LogicEntity> GetTargetByTeammateIndexes(List<int> indexes, List<LogicEntity> entities = null)
	{
		if (summonMonsterIds == null)
		{
			summonMonsterIds = new List<int>();
		}
		summonMonsterIds.Clear();
		if (_actor != null && _actor is MonsterAdventureActor monsterAdventureActor)
		{
			for (int i = 0; i < indexes.Count; i++)
			{
				int monsterTeammateId = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, indexes.get_Item(i));
				if (monsterTeammateId > 0)
				{
					summonMonsterIds.Add(monsterTeammateId);
				}
			}
		}
		return CommonUtils_MonsterAPI.GetTargetByDataIDs(summonMonsterIds, entities);
	}

	public void OnEnable()
	{
		_actor = _skill.actor;
		_isDisableByLostControl = false;
		_isReceiveSkillTakeEffect = false;
		_isTimelinePlaying = false;
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		}
		coroutineNodeList = new List<CoroutineNode>(10);
		OnSkillEnable();
	}

	public void OnDisable()
	{
		OnSkillDisable();
		_actor.actorInfo.ComboSpdMultiplier = 1;
		if (_actor is PlayerAdventureActor && _skill.checkCdRestore && !_isReceiveSkillTakeEffect)
		{
			ILRuntimeAPI.ReturnSkillResumeTime(_skill.skillId, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		}
		RemoveListenEvents();
		for (int i = 0; i < coroutineNodeList.Count; i++)
		{
			StopCoroutine(coroutineNodeList.get_Item(i));
		}
		coroutineNodeList.Clear();
		StopCoroutine(ref linkFXCoroutineNode);
		StopCoroutine(ref logicCoroutineNode);
		StopCoroutine(ref executeCoroutineNode);
		_hitFeatureData?.Clear();
		ClearWait();
		ClearAttack();
		ClearShoot();
		ClearLookAt();
		ClearPlayFx();
		ClearFx();
		ClearMove();
		ClearSearchTarget();
		CancelAim();
		OnClear();
		ClearSpecialState();
	}

	public void OnStart()
	{
		StartCoroutine(ref executeCoroutineNode, Execute());
		StartCoroutine(ref linkFXCoroutineNode, LinkFXAutoFinish());
	}

	private IEnumerator Execute()
	{
		StartCoroutine(ref logicCoroutineNode, DoMainLogic());
		yield return logicCoroutineNode;
		_skill.Clear();
	}

	private IEnumerator LinkFXAutoFinish()
	{
		while (true)
		{
			if (playLinkFXList != null)
			{
				for (int i = 0; i < playLinkFXList.Count; i++)
				{
					PlayFX playFX = playLinkFXList.get_Item(i);
					if (playFX.GetFxPlayerToken() != 0L && playFX.autoCheckLinkFXStop)
					{
						if (checkTargetLost(playFX.linkSource))
						{
							playFX.Stop();
							playFX.Clear();
						}
						else if (checkTargetLost(playFX.linkTarget))
						{
							playFX.Stop();
							playFX.Clear();
						}
					}
				}
			}
			yield return null;
		}
	}

	private bool checkTargetLost(GameObject target)
	{
		bool result = false;
		if (target != null)
		{
			bool flag = false;
			AdventureActor component = target.GetComponent<AdventureActor>();
			if (component != null)
			{
				if (_actor.IsConfrontWith(component) && component.IsSearchedImmunity())
				{
					flag = true;
				}
				ActorHealthInfo actorHealthInfo = component.actorHealthInfo;
				if ((actorHealthInfo != null && !actorHealthInfo.isAlive) | flag)
				{
					result = true;
				}
			}
		}
		return result;
	}

	protected virtual void OnSkillEnable()
	{
	}

	protected virtual IEnumerator DoMainLogic()
	{
		yield break;
	}

	protected virtual void OnSkillDisable()
	{
	}

	protected virtual void OnClear()
	{
	}

	private void onAnticipationEnd(int comboIndex)
	{
		OnAnticipationEnd(comboIndex);
	}

	private void onActivationEnd(int comboIndex)
	{
		OnActivationEnd(comboIndex);
	}

	private void onComboLoop(int comboIndex)
	{
		OnComboLoop(comboIndex);
	}

	private void onRecoveryBegin(int comboIndex)
	{
		OnRecoveryBegin(comboIndex);
	}

	private void onComboFinish(int comboIndex)
	{
		OnComboFinish(comboIndex);
	}

	private void onCustomEvent(int comboIndex, string eventName)
	{
		receiveCustomEventNames.Add(eventName);
		if ((waitComboIndex == comboIndex || waitComboIndex == -1) && string.Equals(waitEventName, eventName))
		{
			waitEvent = false;
		}
		OnCustomEvent(comboIndex, eventName);
	}

	private void onInterrupt(int comboIndex)
	{
		OnInterrupt(comboIndex);
	}

	private IEnumerator waitCustomEvent()
	{
		while (waitEvent)
		{
			yield return null;
		}
		ClearWaitEvent();
	}

	private void ClearWaitEvent()
	{
		if (receiveCustomEventNames.Contains(waitEventName))
		{
			receiveCustomEventNames.Remove(waitEventName);
		}
		waitComboIndex = -1;
		waitEventName = string.Empty;
		waitEvent = false;
	}

	private void ClearWait()
	{
		ClearWaitEvent();
		receiveCustomEventNames.Clear();
	}

	private void onAnticipationEnd()
	{
		requestComboAttack.isAnticipationEnd = true;
		requestComboAttack.comboAttackType = ComboAttackType.isAnticipationEnd;
		onAnticipationEnd(requestComboAttack.comboIndex);
	}

	private void onActivationEnd()
	{
		requestComboAttack.isActivationEnd = true;
		requestComboAttack.comboAttackType = ComboAttackType.isActivationEnd;
		onActivationEnd(requestComboAttack.comboIndex);
	}

	private void onComboLoop()
	{
		onComboLoop(requestComboAttack.comboIndex);
	}

	private void onRecoveryBegin()
	{
		requestComboAttack.isRecoveryBegin = true;
		requestComboAttack.comboAttackType = ComboAttackType.isRecoveryBegin;
		onRecoveryBegin(requestComboAttack.comboIndex);
	}

	private void onCustomEvent(string eventName)
	{
		onCustomEvent(requestComboAttack.comboIndex, eventName);
	}

	private void onSendSkillTakeEffect()
	{
		_isReceiveSkillTakeEffect = true;
	}

	private void onComboFinish()
	{
		requestComboAttack.isComboFinish = true;
		requestComboAttack.comboAttackType = ComboAttackType.isComboFinish;
		onComboFinish(requestComboAttack.comboIndex);
	}

	private void onInterrupt()
	{
		requestComboAttack.isComboFinish = true;
		onInterrupt(requestComboAttack.comboIndex);
	}

	private void ClearAttack()
	{
		ILRuntimeAPI.ClearComboAttack(comboAttack);
		requestComboAttack?.Reset();
	}

	private IEnumerator beginRotateAngle(FP angle, FP rotateSpeed)
	{
		inLookAtState = true;
		_actor.Rotate(angle, TSMath.Abs(angle) / rotateSpeed, useShortAngle: false, onLookAtComplete, onLookAtClear);
		while (inLookAtState)
		{
			yield return null;
		}
	}

	private IEnumerator beginLookAtByDir(TSVector2 dir, FP duration = default(FP), FP rotateSpeed = default(FP), bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		inLookAtState = true;
		ILRuntimeAPI.BeginLookAtByDir(ref lookAtTarget, _actor, dir, duration, rotateSpeed, onLookAtComplete, onLookAtClear, ignoreActorTimeScale, stopAngle);
		while (inLookAtState)
		{
			yield return null;
		}
	}

	private IEnumerator beginLookAt(LogicEntity target, FP duration = default(FP), FP rotateSpeed = default(FP), bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		inLookAtState = true;
		ILRuntimeAPI.BeginLookAtForMonster(ref lookAtTarget, _actor, target, duration, rotateSpeed, stopAngle, ignoreActorTimeScale, onLookAtComplete, onLookAtClear);
		while (inLookAtState)
		{
			yield return null;
		}
	}

	private IEnumerator beginLookAt(FP duration = default(FP), FP rotateSpeed = default(FP), bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		LogicEntity lastTarget = null;
		FP curTime = duration;
		ILRuntimeAPI.BeginLookAtForMonster(ref lookAtTarget, _actor, _actor.monsterTarget, curTime, rotateSpeed, stopAngle, ignoreActorTimeScale);
		while (curTime > 0)
		{
			if (_actor.monsterTarget != null)
			{
				if (lastTarget != null && lastTarget.Id != _actor.monsterTarget.Id)
				{
					lookAtTarget.StopLookAt();
					lookAtTarget.BeginLookAtForMonster(_actor, _actor.monsterTarget, curTime, rotateSpeed, stopAngle, ignoreActorTimeScale);
				}
			}
			else
			{
				lookAtTarget.StopLookAt();
			}
			lastTarget = _actor.monsterTarget;
			curTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		lookAtTarget.StopLookAt();
	}

	private IEnumerator beginLookAtByPos(TSVector2 targetPos, FP duration = default(FP), FP rotateSpeed = default(FP), bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		inLookAtState = true;
		ILRuntimeAPI.BeginLookAtByPos(ref lookAtTarget, _actor, targetPos, duration, rotateSpeed, onLookAtComplete, onLookAtClear, ignoreActorTimeScale, stopAngle);
		while (inLookAtState)
		{
			yield return null;
		}
	}

	private IEnumerator waitLookAt(LogicEntity target, FP rotateTime, FP rotateSpd)
	{
		if (rotateSpd <= 0)
		{
			yield break;
		}
		bool lookAtActivedPlayerActor = target == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (rotateTime < 0)
		{
			while (true)
			{
				target = (lookAtActivedPlayerActor ? SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor : target);
				RotateToTargetBySpeed(target, rotateSpd);
				yield return null;
			}
		}
		FP curTime = rotateTime;
		while (curTime > 0)
		{
			curTime -= _actor.LogicDeltaTime;
			target = (lookAtActivedPlayerActor ? SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor : target);
			RotateToTargetBySpeed(target, rotateSpd);
			yield return null;
		}
	}

	private void RotateToTargetBySpeed(LogicEntity target, FP rotateSpd)
	{
		if (!(target != null))
		{
			return;
		}
		FP angle = (target.tsTransform.Position - _actor.tsTransform.Position).normalized.GetAngle();
		angle = (angle + 360f) % 360f;
		FP rotation = _actor.tsTransform.Rotation360;
		FP fP = rotateSpd * _actor.LogicDeltaTime;
		FP fP2 = angle - rotation;
		FP fP3 = ((fP2 > 0f) ? fP2 : (-fP2));
		if (fP3 > 180f)
		{
			fP2 = ((fP2 > 0f) ? (-(360f - fP3)) : (360f - fP3));
		}
		if (fP2 > 0)
		{
			if (fP >= fP2)
			{
				_actor.RotateToAngle(angle);
			}
			else
			{
				_actor.RotDelta(fP);
			}
		}
		else if (fP >= -fP2)
		{
			_actor.RotateToAngle(angle);
		}
		else
		{
			_actor.RotDelta(-fP);
		}
	}

	private void onLookAtComplete()
	{
		inLookAtState = false;
		OnLookAtComplete();
	}

	private void onLookAtClear()
	{
		inLookAtState = false;
		OnLookAtClear();
	}

	protected void ClearLookAt()
	{
		ILRuntimeAPI.ClearLookAt(lookAtTarget);
		inLookAtState = false;
		corRotate = null;
	}

	private void ClearPlayFx()
	{
		playFx?.Clear();
		if (playFXList != null && playFXList.Count > 0)
		{
			for (int i = 0; i < playFXList.Count; i++)
			{
				playFXList.get_Item(i).Stop();
				playFXList.get_Item(i).Clear();
			}
		}
		if (playLinkFXList != null && playLinkFXList.Count > 0)
		{
			for (int j = 0; j < playLinkFXList.Count; j++)
			{
				playLinkFXList.get_Item(j).Stop();
				playLinkFXList.get_Item(j).Clear();
			}
		}
	}

	protected IEnumerator blink(ComboInputBuffer.ActionKey[] hideKeys, TSVector2 blinkPosition, FP blinkDuration, string blinkBeginFx, FP blinkHideDelay, string blinkFinishFx, FP blinkShowDelay, LogicEntity target = null, ComboInputBuffer.ActionKey[] showKeys = null, int showCombWaitIndex = 1, bool checkPositionReachable = true)
	{
		if (hideKeys != null && hideKeys.Length != 0)
		{
			BeginAttack(100, hideKeys, flushInputedKeys: true, forceInterruptAttack: true);
		}
		if (!string.IsNullOrEmpty(blinkBeginFx))
		{
			PlayFx(blinkBeginFx, (float)_actor.logicTimeScale, 0, _actor.tsTransform.Position, default, _actor.transform);
		}
		yield return WaitTime(blinkHideDelay);
		HideSelf();
		Teleport(blinkPosition, checkPositionReachable);
		yield return WaitTime(blinkDuration);
		if (target != null)
		{
			yield return BeginLookAt(target, 0, 0);
		}
		if (!string.IsNullOrEmpty(blinkFinishFx))
		{
			PlayFx(blinkFinishFx, (float)_actor.logicTimeScale, 0, _actor.tsTransform.Position, default, _actor.transform);
		}
		yield return WaitTime(blinkShowDelay);
		if (showKeys != null && showKeys.Length != 0)
		{
			BeginAttack(101, showKeys, flushInputedKeys: true, forceInterruptAttack: true);
			_actor.Visible();
			yield return WaitFrame(showCombWaitIndex);
			_actor.DisableInvincible();
			_actor.DisableSearchedImmunity();
		}
		else
		{
			ShowSelf();
		}
	}

	private IEnumerator crossJump(TSVector2 targetPosition, FP speed, FP duration, bool comboWithAttack = false, bool forbiddenHeight = false, bool checkPositionReachable = true)
	{
		if (_inCrossJump)
		{
			yield break;
		}
		_inCrossJump = true;
		if (!_actor.ToJump(targetPosition, speed, duration, onCrossJumpFinish, comboWithAttack, forbiddenHeight, checkPositionReachable))
		{
			_inCrossJump = false;
			yield break;
		}
		while (_inCrossJump)
		{
			yield return null;
		}
		_inCrossJump = false;
	}

	private void onCrossJumpFinish()
	{
		_inCrossJump = false;
	}

	protected void ClearMove()
	{
		if (_traceTarget != null)
		{
			_traceTarget.Clear();
			_traceTarget = null;
		}
		_inCrossJump = false;
	}

	protected void HideSelf()
	{
		_actor.EnableUnparalleled();
		_actor.EnableSearchedImmunity();
		_actor.Hide();
	}

	protected void ShowSelf()
	{
		_actor.DisableUnparalleled();
		_actor.DisableSearchedImmunity();
		_actor.Visible();
	}

	private void MultipleShoot(HitBox.Shape shape, string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, FP angle, FP width, FP length, FP radius, FP innerRadius, bool isTryShootAgain = false)
	{
		if (string.IsNullOrEmpty(bulletAlias) || bulletCount <= 0)
		{
			return;
		}
		GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, bulletAlias);
		if (bulletByAlias == null)
		{
			NovaLogger.Error(_actor.name + "子弹资源不存在：" + bulletAlias);
			return;
		}
		if (multiShootDirection.Equals(TSVector2.zero) || multiShootDirection.Equals(default))
		{
			multiShootDirection = _actor.tsTransform.Forward;
		}
		needTryShootAgain = (shape == HitBox.Shape.Circle || shape == HitBox.Shape.Fan) && bulletByAlias.GetComponent<AdventureProjectile>() != null;
		onceShootSuccessCount = 0;
		if (!isTryShootAgain && needTryShootAgain)
		{
			tryShootAgainFinish = false;
			currentTryShootTimes = 0;
			switch (shape)
			{
			case HitBox.Shape.Circle:
				tryShootTimes = (int)(long)(360 / tryAnglePerStep);
				break;
			case HitBox.Shape.Fan:
				tryShootTimes = (int)(long)(angle / tryAnglePerStep);
				break;
			}
			tShootParams = new TempMultiShootParams
			{
				shape = shape,
				bulletAlias = bulletAlias,
				multipleShootStyle = multipleShootStyle,
				alignShoot = alignShoot,
				alignShootDelay = alignShootDelay,
				bulletCount = bulletCount,
				duration = duration,
				shootPosition = shootPosition,
				shootPositionY = shootPositionY,
				multiShootDirection = multiShootDirection,
				bulletDirectionOffset = bulletDirectionOffset,
				aimType = aimType,
				bulletDirectionType = bulletDirectionType,
				targetPosition = targetPosition,
				target = target,
				angle = angle,
				width = width,
				length = length,
				radius = radius,
				innerRadius = innerRadius
			};
		}
		if (shootReq == null)
		{
			shootReq = new RequestDefaultState();
		}
		shootReq.Reset();
		if (duration > 0f)
		{
			CoroutineNode item = StartCoroutine(_actor.shootBehaviour.MultipleShoot(shape, bulletByAlias, bulletCount, width, length, angle, radius, innerRadius, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, multipleShootStyle, duration, alignShoot, alignShootDelay, aimType, bulletDirectionType, targetPosition, target, ShootFinish, useRef: false, OnShootBulletBorn));
			coroutineNodeList.Add(item);
			return;
		}
		int num = _actor.shootBehaviour.QueryMultipleShootWaveCount(shape, multipleShootStyle, bulletCount);
		int waveIndex = 0;
		while (waveIndex < num)
		{
			_actor.shootBehaviour.MultipleShoot(shape, bulletByAlias, bulletCount, width, length, angle, radius, innerRadius, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, multipleShootStyle, ref waveIndex, 0f, alignShoot, alignShootDelay, aimType, bulletDirectionType, targetPosition, target, OnShootBulletBorn);
		}
		ShootFinish();
	}

	private void OnShootBulletBorn(long bulletId)
	{
		if (bulletId > 0)
		{
			onceShootSuccessCount++;
			_bulletIdList.Add(bulletId);
		}
	}

	private IEnumerator _waitShoot(BaseNormalStatus normalStatus)
	{
		if (shootReq != null)
		{
			while (shootReq.defalutStatus != normalStatus)
			{
				yield return null;
			}
		}
	}

	private void ShootFinish()
	{
		if (needTryShootAgain && !tryShootAgainFinish && onceShootSuccessCount <= 0)
		{
			TSVector2 multiShootDirection = TSVector2.Rotate(tShootParams.multiShootDirection, tryAnglePerStep);
			currentTryShootTimes++;
			if (currentTryShootTimes >= tryShootTimes)
			{
				tryShootAgainFinish = true;
			}
			tShootParams.multiShootDirection = multiShootDirection;
			MultipleShoot(tShootParams.shape, tShootParams.bulletAlias, tShootParams.multipleShootStyle, tShootParams.alignShoot, tShootParams.alignShootDelay, tShootParams.bulletCount, tShootParams.duration, tShootParams.shootPosition, tShootParams.shootPositionY, tShootParams.multiShootDirection, tShootParams.bulletDirectionOffset, tShootParams.aimType, tShootParams.bulletDirectionType, tShootParams.targetPosition, tShootParams.target, tShootParams.angle, tShootParams.width, tShootParams.length, tShootParams.radius, tShootParams.innerRadius, isTryShootAgain: true);
		}
		else
		{
			shootReq.defalutStatus = BaseNormalStatus.Complete;
		}
	}

	private void ClearShoot()
	{
		_bulletIdList?.Clear();
	}

	private void ClearSearchTarget()
	{
		_searchTargets?.Clear();
	}

	private void StartDynamicTransparent(FP minDistance, FP maxDistance, FP durationTransparent, FP fadeTime)
	{
		if (durationTransparent <= 0 || durationTransparent >= 1)
		{
			NovaLogger.Error("区间透明度参数有误");
		}
		else
		{
			_dynamicTransparentCor = StartCor(DynamicTransparentCor(minDistance, maxDistance, durationTransparent, fadeTime));
		}
	}

	private IEnumerator DynamicTransparentCor(FP minDistance, FP maxDistance, FP durationTransparent, FP fadeTime)
	{
		int type = -1;
		while (true)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null)
			{
				FP fP = _actor.DistanceWithRadius(activedPlayerActor);
				if (fP <= minDistance)
				{
					if (type != 0)
					{
						TransparentFade(durationTransparent, 1, fadeTime);
						type = 0;
					}
				}
				else if (fP <= maxDistance)
				{
					if (type != 1)
					{
						int num = ((type != 2) ? 1 : 0);
						TransparentFade(num, durationTransparent, fadeTime);
						type = 1;
					}
				}
				else if (type != 2)
				{
					TransparentFade(durationTransparent, 0, fadeTime);
					type = 2;
				}
			}
			yield return null;
		}
	}

	private void TransparentFade(FP from, FP to, FP duration)
	{
		float currentTransparency = _actor.currentTransparency;
		FP fP = TSMath.Clamp01(TSMath.Abs((to - currentTransparency) / (to - from)));
		duration *= fP;
		_actor.TransparentFade(currentTransparency, to.AsFloat(), duration.AsFloat());
	}

	private void StopDynamicTransparent()
	{
		if (_dynamicTransparentCor != null)
		{
			StopCor(_dynamicTransparentCor);
		}
	}

	private IEnumerator ChangeModelScale(FP targetValue, FP duration)
	{
		if (duration <= 0)
		{
			_actor.actorScaleInfo.modelScale = targetValue;
			yield break;
		}
		FP fP = targetValue - _actor.actorScaleInfo.modelScale;
		FP changeSpeed = fP / duration;
		while (duration > 0)
		{
			_actor.actorScaleInfo.modelScale += changeSpeed * _actor.LogicDeltaTime;
			duration -= _actor.LogicDeltaTime;
			yield return null;
		}
		_actor.actorScaleInfo.modelScale = targetValue;
	}

	protected CoroutineNode StartCor(IEnumerator enumerator)
	{
		CoroutineNode coroutineNode = StartCoroutine(enumerator);
		coroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void StartCor(ref CoroutineNode cor, IEnumerator enumerator)
	{
		if (cor != null)
		{
			StopCoroutine(cor);
		}
		cor = StartCoroutine(enumerator);
		coroutineNodeList.Add(cor);
	}

	protected void StopCor(CoroutineNode cor)
	{
		if (cor != null)
		{
			StopCoroutine(cor);
			coroutineNodeList.Remove(cor);
		}
	}

	public void DirectDamage(AdventureActor toActor, int damage, string tag, bool showHud = true)
	{
		if (!(toActor == null))
		{
			toActor.DirectDamage(damage, tag, _actor.Id, showHud);
		}
	}

	protected virtual void OnActorDied(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorDiedEvent adventureActorDiedEvent && _actor == adventureActorDiedEvent.actor && _skill != null)
		{
			_skill.Clear();
		}
	}

	protected virtual void OnActorLostControl(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorLostControlEvent adventureActorLostControlEvent && _actor == adventureActorLostControlEvent.actor && _skill != null)
		{
			_isDisableByLostControl = true;
			_skill.Clear();
		}
	}

	protected virtual void OnActorBeControlled(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorBeControlledEvent adventureActorBeControlledEvent && _actor == adventureActorBeControlledEvent.actor && _skill != null)
		{
			_isDisableByLostControl = true;
			_skill.Clear();
		}
	}

	protected virtual void OnAnticipationEnd(int comboIndex)
	{
	}

	protected virtual void OnActivationEnd(int comboIndex)
	{
	}

	protected virtual void OnRecoveryBegin(int comboIndex)
	{
	}

	protected virtual void OnComboFinish(int comboIndex)
	{
	}

	protected virtual void OnInterrupt(int comboIndex)
	{
	}

	protected virtual void OnLookAtComplete()
	{
	}

	protected virtual void OnLookAtClear()
	{
	}

	protected void StopLookAt()
	{
		lookAtTarget?.StopLookAt();
	}

	protected int AreaHit(DeterministicShape shape, HitBox.FeatureFlag hitFlags, HitBox.HitBoxFeatureData hitFeatureData, string hittedEffectPrefabAlias, float fxPositionY, float fxPlaybackSpeed, float fxScale, bool actorScale, TSVector2 fxPosition, TSVector2 fxDirection, HitBox.HurtAnimType hurtAnimType, int hitDamageId, FP damageImmuneDuration)
	{
		_actor.hitBox.hitDamageId = hitDamageId;
		_actor.hitBox.featureFlags = hitFlags;
		_actor.hitBox.featureData = hitFeatureData;
		_actor.hitBox.hurtAnimType = hurtAnimType;
		GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, hittedEffectPrefabAlias);
		int hittedCount = 0;
		int damageCount;
		if (shape.shapeType == DeterministicShape.ShapeType.Circle)
		{
			_actor.hitBox.CircleAreaHit(shape.radius, shape.innerRadius, shape.position, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), bulletByAlias, isHittedEffectScale: true, -5, damageImmuneDuration);
		}
		else if (shape.shapeType == DeterministicShape.ShapeType.Fan)
		{
			_actor.hitBox.FanAreaHit(shape.angle, shape.radius, shape.innerRadius, shape.position, shape.rotation, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), bulletByAlias, isHittedEffectScale: true, damageImmuneDuration);
		}
		else if (shape.shapeType == DeterministicShape.ShapeType.Rectangle)
		{
			_actor.hitBox.RectangleAreaHit(shape.width, shape.length, shape.position, shape.rotation, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), bulletByAlias, isHittedEffectScale: true, -5, damageImmuneDuration);
		}
		return hittedCount;
	}

	protected virtual void SetListenEvents()
	{
	}

	protected void InitListenEvent(MonsterEventType type, bool active, Action<IEvent> operation)
	{
		if (_monsterEventDict == null)
		{
			_monsterEventDict = new Dictionary<MonsterEventType, MonsterEventParams>();
		}
		if (!_monsterEventDict.ContainsKey(type))
		{
			_monsterEventDict.set_Item(type, new MonsterEventParams(type, active, operation));
			if (active)
			{
				AddListenEvent(_monsterEventDict.get_Item(type));
			}
		}
	}

	protected void InitListenEvent(MonsterEventType type, bool active, Action<IEvent> operation, params int[] eventParams)
	{
		if (_monsterEventDict == null)
		{
			_monsterEventDict = new Dictionary<MonsterEventType, MonsterEventParams>();
		}
		if (!_monsterEventDict.ContainsKey(type))
		{
			_monsterEventDict.set_Item(type, new MonsterEventParams(type, active, operation, eventParams.ToList()));
			if (active)
			{
				AddListenEvent(_monsterEventDict.get_Item(type));
			}
		}
	}

	protected void InitListenEvent(MonsterEventType type, bool active, Action<IEvent> operation, params string[] eventParams)
	{
		if (_monsterEventDict == null)
		{
			_monsterEventDict = new Dictionary<MonsterEventType, MonsterEventParams>();
		}
		if (!_monsterEventDict.ContainsKey(type))
		{
			MonsterEventParams value = new MonsterEventParams(type, active, operation, eventParams.ToList());
			_monsterEventDict.set_Item(type, value);
			if (active)
			{
				AddListenEvent(_monsterEventDict.get_Item(type));
			}
		}
	}

	private void AddListenEvent(MonsterEventParams eventParams)
	{
		if (eventParams.type == MonsterEventType.SelfReceiveDamage)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
		else if (eventParams.type == MonsterEventType.MonsterDie)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		}
		else if (eventParams.type == MonsterEventType.MonsterSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_ENTER_BATTLE", OnMonsterSpawnFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfLostControl)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnMonsterBeControlled);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_BORN", OnBulletSpawn);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletFinish)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfToughnessBroken)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		}
		else if (eventParams.type == MonsterEventType.SelfHpChanged)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		else if (eventParams.type == MonsterEventType.DamageToOthers)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		else if (eventParams.type == MonsterEventType.BattleLevelChange)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChanged);
		}
	}

	private void RemoveListenEvent(MonsterEventParams eventParams)
	{
		if (eventParams.type == MonsterEventType.SelfReceiveDamage)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
		else if (eventParams.type == MonsterEventType.MonsterDie)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		}
		else if (eventParams.type == MonsterEventType.MonsterSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ENTER_BATTLE", OnMonsterSpawnFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfLostControl)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnMonsterBeControlled);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletSpawn);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletFinish)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfToughnessBroken)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		}
		else if (eventParams.type == MonsterEventType.SelfHpChanged)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		else if (eventParams.type == MonsterEventType.DamageToOthers)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		else if (eventParams.type == MonsterEventType.BattleLevelChange)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChanged);
		}
	}

	private void RemoveListenEvents()
	{
		if (_monsterEventDict == null)
		{
			return;
		}
		foreach (MonsterEventParams value in _monsterEventDict.Values)
		{
			if (value.active)
			{
				RemoveListenEvent(value);
			}
		}
	}

	private void OnReceiveDamage(IEvent iEvt)
	{
		if (iEvt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.to.Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfReceiveDamage).operation?.Invoke(iEvt);
		}
	}

	private void OnDamage(IEvent iEvt)
	{
		if (iEvt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from.Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.DamageToOthers).operation?.Invoke(iEvt);
		}
	}

	private void OnMonsterDie(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterDiedEvent adventureMonsterDiedEvent)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.MonsterDie);
			if (monsterEventParams.intParams != null && monsterEventParams.intParams.Contains(adventureMonsterDiedEvent.monsterID))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnMonsterSpawnFinish(IEvent iEvt)
	{
		if (iEvt is AdventureActorEnterBattle adventureActorEnterBattle)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.MonsterSpawn);
			if (monsterEventParams.intParams != null && monsterEventParams.intParams.Contains((adventureActorEnterBattle.sender as AdventureActor).dataID))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnMonsterBeControlled(IEvent iEvt)
	{
		if (iEvt is AdventureActorBeControlledEvent adventureActorBeControlledEvent && adventureActorBeControlledEvent.actor.Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfLostControl).operation?.Invoke(iEvt);
		}
	}

	private void OnBulletSpawn(IEvent iEvt)
	{
		if (iEvt is AdventureBulletBornEvent adventureBulletBornEvent && adventureBulletBornEvent.owner.Id == _actor.Id)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.SelfBulletSpawn);
			if (monsterEventParams.stringParams.Contains(adventureBulletBornEvent.tag))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnBulletFinish(IEvent iEvt)
	{
		if (iEvt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.owner.Id == _actor.Id)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.SelfBulletFinish);
			if (monsterEventParams.stringParams.Contains(adventureBulletFinishEvent.tag))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnToughnessStateChange(IEvent iEvt)
	{
		if (iEvt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && monsterToughnessStateChangeEvent.actor.Id == _actor.Id && monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfToughnessBroken).operation?.Invoke(iEvt);
		}
	}

	private void OnHpChange(IEvent iEvt)
	{
		if (iEvt is AdventureActorHpChangedEvent adventureActorHpChangedEvent && (adventureActorHpChangedEvent.sender as AdventureActor).Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfHpChanged).operation?.Invoke(iEvt);
		}
	}

	private void OnBattleLevelChanged(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterBattleLevelChangedEvent adventureMonsterBattleLevelChangedEvent && (adventureMonsterBattleLevelChangedEvent.sender as AdventureActor).Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.BattleLevelChange).operation?.Invoke(iEvt);
		}
	}

	protected void PlayFx(string fxAlias, float playbackSpeed, FP fxPositionY, TSVector2 position, FP angle, UnityEngine.Transform parent = null, float spawnSize = 1f, bool actorScale = false)
	{
		if (playFx == null)
		{
			playFx = new PlayFX();
		}
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)angle, 0f);
		playFx.Play(_actor, fxAlias, playbackSpeed, fxPositionY, position, spawnRotation, parent, spawnSize, actorScale);
	}

	protected PlayFX PlayFxForNeedStop(string fxAlias, float playbackSpeed, FP fxPositionY, TSVector2 position, FP angle, UnityEngine.Transform parent = null, float spawnSize = 1f, bool actorScale = false)
	{
		PlayFX playFX = new PlayFX();
		playFX.Play(spawnRotation: Quaternion.Euler(0f, 0f - (float)angle, 0f), actor: _actor, fxAlias: fxAlias, playbackSpeed: playbackSpeed, fxPositionY: fxPositionY, position: position, parent: parent, spawnSize: spawnSize, actorScale: actorScale);
		return playFX;
	}

	protected PlayFX PlayLinkFX(string fxAlias, bool useCustomSource, GameObject source, TSVector sourcePosition, FP sourcePositionY, GameObject targetObj, TSVector targetPosition, FP targetPositionY, bool breakWhenLostSourceOrTarget = true, float spawnSize = 1f, bool actorScale = false, float playbackSpeed = 1f)
	{
		if (playLinkFXList == null)
		{
			playLinkFXList = new List<PlayFX>(5);
		}
		PlayFX playFX = null;
		for (int i = 0; i < playLinkFXList.Count; i++)
		{
			if (playLinkFXList.get_Item(i).GetFxPlayerToken() == 0L)
			{
				playFX = playLinkFXList.get_Item(i);
				break;
			}
		}
		if (playFX == null)
		{
			playFX = new PlayFX();
			playLinkFXList.Add(playFX);
		}
		playFX.PlayLinFx(_actor, fxAlias, playbackSpeed, useCustomSource, source, sourcePosition, sourcePositionY, targetObj, targetPosition, targetPositionY, spawnSize, actorScale, breakWhenLostSourceOrTarget);
		return playFX;
	}

	protected long PlayLoopFx(string fxAlias, float playbackSpeed, Vector3 spawnPosition, Quaternion spawnRotation, UnityEngine.Transform parent = null, float spawnSize = 1f)
	{
		if (playFXList == null)
		{
			playFXList = new List<PlayFX>(5);
		}
		int num = -1;
		for (int i = 0; i < playFXList.Count; i++)
		{
			if (playFXList.get_Item(i).GetFxPlayerToken() == 0L)
			{
				num = i;
				break;
			}
		}
		long fxPlayerToken;
		if (num >= 0)
		{
			playFXList.get_Item(num).Play(_actor, fxAlias, playbackSpeed, spawnPosition, spawnRotation, parent, spawnSize);
			fxPlayerToken = playFXList.get_Item(num).GetFxPlayerToken();
		}
		else
		{
			PlayFX playFX = new PlayFX();
			playFX.Play(_actor, fxAlias, playbackSpeed, spawnPosition, spawnRotation, parent, spawnSize);
			fxPlayerToken = playFX.GetFxPlayerToken();
			playFXList.Add(playFX);
		}
		return fxPlayerToken;
	}

	protected void StopLoopFx(long token, bool dontPlaySubFX = false)
	{
		if (playFXList == null)
		{
			return;
		}
		for (int i = 0; i < playFXList.Count; i++)
		{
			if (playFXList.get_Item(i).GetFxPlayerToken() == token)
			{
				playFXList.get_Item(i).Stop(dontPlaySubFX);
				playFXList.get_Item(i).Clear();
				break;
			}
		}
	}
}
