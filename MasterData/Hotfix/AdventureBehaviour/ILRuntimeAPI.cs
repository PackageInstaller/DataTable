#define LOG_ERROR
#define LOG_DEBUG
using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.SceneManagement;

namespace AdventureBehaviour;

public static class ILRuntimeAPI
{
	public class HitBoxContext : IHitBoxContext
	{
		public LogicEntity owner;

		public HitBoxContext(LogicEntity owner)
		{
			this.owner = owner;
		}

		public FP QueryHitBoxContextTime()
		{
			return owner.LogicTime;
		}

		public TSVector2 QueryHitBoxContextPosition()
		{
			return owner.tsTransform.Position;
		}

		public TSVector2 QueryHitBoxContextDirection()
		{
			return owner.tsTransform.Forward;
		}

		public bool QueryActorHitedTimeout(long entityId, FP timeout)
		{
			return true;
		}

		public void SetActorHitedTime(long entityId, FP time)
		{
		}

		public bool CheckHitable(HitBox hitBox, LogicEntity entity)
		{
			if (!(owner == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !owner.IsConfrontWith(entity))
			{
				return owner.IsNeutralWith(entity);
			}
			return true;
		}

		public void ClearActorHitedTime()
		{
		}

		public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
		{
			damaged = false;
			if (owner is AdventureActor { isDead: not false })
			{
				return false;
			}
			ActorHealthInfo logicComponent = entity.GetLogicComponent<ActorHealthInfo>();
			if (logicComponent != null && !logicComponent.isAlive)
			{
				return true;
			}
			(damaged, _, _) = entity.GetComponent<AdventureActor>().Damage(owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
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

		public bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
		{
			damaged = false;
			if (owner is AdventureActor { isDead: not false })
			{
				return false;
			}
			AdventureActor component = entity.GetComponent<AdventureActor>();
			if (!component.CurrentStepCanbeHurt())
			{
				return true;
			}
			(damaged, _, _) = component.Damage(owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
			return true;
		}
	}

	private static GameObject transNode;

	private static List<int> randomWeights;

	private static TSVector2 LAST_RANDOM_POINT = TSVector2.zero;

	private static List<AdventureActor> _tempTargets = new List<AdventureActor>();

	private static readonly Queue<HitBox> _hitBoxPool = new Queue<HitBox>(5);

	private static readonly Dictionary<long, HitBoxContext> _hitBoxContextPool = new Dictionary<long, HitBoxContext>(5);

	private static List<DeterministicCollider> deterministicColliders;

	public static List<SearchData> searchDataPool = new List<SearchData>(10);

	private static List<DeterministicCollider> _deterministicColliders;

	public static TSVector2 TransLocalPosToWorldPos(AdventureActor actor, TSVector2 relativePoint = default(TSVector2))
	{
		if (null == transNode)
		{
			transNode = new GameObject("TransNode");
			transNode.SetActive(value: false);
		}
		Vector2 vector = actor.tsTransform.Position.ToVector2();
		transNode.transform.position = new Vector3(vector.x, 0f, vector.y);
		Vector2 vector2 = actor.tsTransform.Forward.ToVector2();
		transNode.transform.forward = new Vector3(vector2.x, 0f, vector2.y);
		Vector2 vector3 = relativePoint.ToVector2();
		Vector3 vector4 = transNode.transform.TransformPoint(new Vector3(vector3.x, 0f, vector3.y));
		return new TSVector2(vector4.x, vector4.z);
	}

	public static TSVector2 TransLocalPosToWorldPosByPos(TSVector2 pos, TSVector2 dir, TSVector2 relativePoint = default(TSVector2))
	{
		if (null == transNode)
		{
			transNode = new GameObject("TransNode");
			transNode.SetActive(value: false);
		}
		Vector2 vector = pos.ToVector2();
		transNode.transform.position = new Vector3(vector.x, 0f, vector.y);
		Vector2 vector2 = dir.ToVector2();
		transNode.transform.forward = new Vector3(vector2.x, 0f, vector2.y);
		Vector2 vector3 = relativePoint.ToVector2();
		Vector3 vector4 = transNode.transform.TransformPoint(new Vector3(vector3.x, 0f, vector3.y));
		return new TSVector2(vector4.x, vector4.z);
	}

	public static FP CalcDistanceBetweenMonsterAndPlayer(AdventureActor actor, bool calcDistanceWithoutEntityRadius = true)
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (null == activedPlayerActor)
		{
			return 0f;
		}
		if (!calcDistanceWithoutEntityRadius)
		{
			return actor.DistanceWithRadius(activedPlayerActor);
		}
		return TSVector2.Distance(actor.tsTransform.Position, activedPlayerActor.tsTransform.Position);
	}

	public static FP CalcDistanceBetweenTwoActor(AdventureActor actorA, AdventureActor actorB, bool calcDistanceWithoutEntityRadius = true)
	{
		if (actorA == null || actorB == null)
		{
			return 0f;
		}
		if (!calcDistanceWithoutEntityRadius)
		{
			return actorA.DistanceWithRadius(actorB);
		}
		return TSVector2.Distance(actorA.tsTransform.Position, actorB.tsTransform.Position);
	}

	public static FP CalcDistanceBetweenActorAndPosition(LogicEntity actor, TSVector2 position, bool calcDistanceWithoutEntityRadius = false)
	{
		FP result = TSVector2.Distance(actor.tsTransform.Position, position);
		if (!calcDistanceWithoutEntityRadius)
		{
			FP fP = FP.Zero;
			DeterministicCollider logicComponent = actor.GetLogicComponent<DeterministicCollider>();
			if (logicComponent != null)
			{
				fP = logicComponent.Radius;
			}
			result -= fP;
		}
		return result;
	}

	public static TSVector2 GetRandomPointInShape(AdventureActor actor, DeterministicShape _shape, bool isReachable = true, int maxCheckCount = 15)
	{
		TSVector2 result = TSVector2.zero;
		if (isReachable)
		{
			result = actor.RandomActorReachablePointInsideShape(_shape, maxCheckCount);
		}
		else
		{
			switch (_shape.shapeType)
			{
			case DeterministicShape.ShapeType.Circle:
				result = TrueSyncExtensions.RandomPointInsideRing(_shape.position, _shape.innerRadius, _shape.radius);
				break;
			case DeterministicShape.ShapeType.Fan:
				result = TrueSyncExtensions.RandomPointInsideFan(_shape.position, _shape.innerRadius, _shape.radius, _shape.rotation, _shape.angle);
				break;
			case DeterministicShape.ShapeType.Rectangle:
				result = TrueSyncExtensions.RandomPointInsideRectangle(_shape.position, _shape.width, _shape.length, _shape.rotation);
				break;
			}
		}
		return result;
	}

	public static void SortByDistance(TSVector2 point, ref List<TSVector2> _list)
	{
		_list.Sort((TSVector2 x, TSVector2 y) => TSVector2.Distance(y, point).CompareTo(TSVector2.Distance(x, point)));
	}

	public static TSVector2 GetGameobjectPosition(GameObject obj)
	{
		if (obj == null)
		{
			return TSVector2.zero;
		}
		LogicEntity logicEntity = obj.GetComponent<LogicEntity>();
		AdventureSkill component = obj.GetComponent<AdventureSkill>();
		if (component != null)
		{
			logicEntity = component.actor;
		}
		if (!(null == logicEntity))
		{
			return logicEntity.tsTransform.Position;
		}
		return new TSVector2(obj.transform.position.x, obj.transform.position.y);
	}

	public static FP GetObjAngle(GameObject obj)
	{
		if (obj == null)
		{
			return 0;
		}
		LogicEntity logicEntity = obj.GetComponent<LogicEntity>();
		AdventureSkill component = obj.GetComponent<AdventureSkill>();
		if (component != null)
		{
			logicEntity = component.actor;
		}
		if (!(null == logicEntity))
		{
			return logicEntity.tsTransform.Rotation360;
		}
		return new TSVector2(obj.transform.position.x, obj.transform.position.z).GetAngle();
	}

	public static FP CalcAngleBetweenSelfAndAttackTarget(LogicEntity entity, bool isSingleAngle = false)
	{
		LogicEntity logicEntity;
		if (entity is PlayerAdventureActor playerAdventureActor)
		{
			logicEntity = playerAdventureActor.attackTarget;
		}
		else
		{
			logicEntity = ((!(entity is MonsterAdventureActor monsterAdventureActor)) ? null : monsterAdventureActor.monsterTarget);
		}
		LogicEntity logicEntity2 = logicEntity;
		if (null == logicEntity2)
		{
			return 0f;
		}
		TSVector2 normalized = entity.tsTransform.Forward.normalized;
		TSVector2 normalized2 = (logicEntity2.tsTransform.Position - entity.tsTransform.Position).normalized;
		if (!isSingleAngle)
		{
			return TSVector2.Angle(normalized, normalized2);
		}
		return TSVector2.SignedAngle(normalized, normalized2);
	}

	public static int randomWeight(int[] rdmWeights)
	{
		if (rdmWeights.Length <= 1)
		{
			return 0;
		}
		if (randomWeights == null)
		{
			randomWeights = new List<int>(50);
		}
		randomWeights.Clear();
		int num = 0;
		for (int i = 0; i < rdmWeights.Length; i++)
		{
			num += rdmWeights[i];
			randomWeights.Add(num);
		}
		int num2 = MonoSingleton<GameController>.Instance.Random_Roguelike(1, num + 1);
		for (int j = 0; j < randomWeights.Count; j++)
		{
			if (num2 <= randomWeights.get_Item(j))
			{
				return j;
			}
		}
		return 0;
	}

	public static TSVector2 GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(AdventureActor actor, List<FP> angles, FP distance, FP distanceNear, bool excludeLastPoint = false)
	{
		List<TSVector2> list = new List<TSVector2>();
		LogicEntity logicEntity = actor.monsterTarget;
		if (logicEntity == null)
		{
			logicEntity = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		}
		if (logicEntity == null)
		{
			return TSVector2.zero;
		}
		Vector3 position = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(logicEntity.transform.position) + new Vector3(0f, 1f, 0f);
		Vector3 normalized = (MonoSingleton<GameCameraStackManager>.Instance.mainCamera.ScreenToWorldPointAsHFOV(position) - logicEntity.transform.position).normalized;
		for (int i = 0; i < angles.Count; i++)
		{
			FP fP = distance;
			if (angles.get_Item(i) > 135 && angles.get_Item(i) < 225)
			{
				fP = distanceNear;
			}
			Vector3 vector = Quaternion.AngleAxis((float)angles.get_Item(i), Vector3.up) * normalized;
			Vector3 vector2 = logicEntity.transform.position + vector * (float)fP;
			list.Add(new TSVector2(vector2.x, vector2.z));
		}
		return GetRandomPoint(actor, list, distance, excludeLastPoint);
	}

	private static TSVector2 GetRandomPoint(AdventureActor actor, List<TSVector2> points, FP distance, bool excludeLastPoint = false)
	{
		TSVector2 zero = TSVector2.zero;
		List<TSVector2> list = new List<TSVector2>();
		for (int i = 0; i < points.Count; i++)
		{
			if (!actor.QueryPositionReachable(points.get_Item(i)))
			{
				continue;
			}
			if (excludeLastPoint)
			{
				if (LAST_RANDOM_POINT != points.get_Item(i))
				{
					list.Add(points.get_Item(i));
				}
			}
			else
			{
				list.Add(points.get_Item(i));
			}
		}
		if (list.Count == 0)
		{
			zero = actor.RandomActorReachablePointInsideRing(actor.tsTransform.Position, distance - 0.5, distance + 0.5);
		}
		else
		{
			int index = MonoSingleton<GameController>.Instance.Random_Roguelike(0, list.Count);
			zero = list.get_Item(index);
		}
		LAST_RANDOM_POINT = zero;
		return zero;
	}

	public static bool Raycast(Vector3 startPosition, Vector3 dir, float maxDistance)
	{
		RaycastHit hitInfo;
		return Physics.Raycast(startPosition, dir, out hitInfo, maxDistance, 2048, QueryTriggerInteraction.Ignore);
	}

	public static bool IsObstacleBetweenActorAndTargetAndPreventNormalAttack(AdventureActor actor)
	{
		if (actor.attackTarget == null)
		{
			return false;
		}
		TSVector2 origin = actor.tsTransform.Position;
		TSVector2 tSVector = actor.attackTarget.tsTransform.Position - origin;
		TSVector2 direction = tSVector.normalized;
		if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var hitInfo, tSVector.magnitude, 4096))
		{
			AdventureObstacle component = hitInfo.collider.GetComponent<AdventureObstacle>();
			if (component != null && component.preventNormalAttack)
			{
				return true;
			}
		}
		return false;
	}

	public static void AddShieldFromSelf(AdventureActor actor, int shieldID)
	{
		if (!(null == actor))
		{
			ActorShield actorShield = actor.actorShield;
			if (actorShield == null)
			{
				Debug.LogError("actorShield is null==" + actor.name);
			}
			else
			{
				actorShield.AddShield(shieldID, actor);
			}
		}
	}

	public static void RemoveShieldByShieldID(AdventureActor actor, int shieldID)
	{
		if (!(null == actor))
		{
			ActorShield actorShield = actor.actorShield;
			if (actorShield == null)
			{
				Debug.LogError("actorShield is null==" + actor.name);
			}
			else
			{
				actorShield.RemoveShieldByShieldID(shieldID);
			}
		}
	}

	public static void Aim(ref AimTarget aimTarget, AdventureActor actor, AdventureActor target = null, TSVector2 direction = default(TSVector2), bool playStartAnim = false, Action onAimAnimEnd = null, Action onAnimInterrupted = null, int aimIndex = -1)
	{
		if (aimTarget == null)
		{
			aimTarget = new AimTarget();
		}
		aimTarget.Aim(actor, target, direction, playStartAnim, onAimAnimEnd, onAnimInterrupted, aimIndex);
	}

	public static void AimTargetEntity(ref AimTarget aimTarget, AdventureActor actor, LogicEntity target = null, int aimIndex = -1)
	{
		if (aimTarget == null)
		{
			aimTarget = new AimTarget();
		}
		aimTarget.AimTargetEntity(actor, target, aimIndex);
	}

	public static void CancelAim(AimTarget aimTarget)
	{
		aimTarget?.Cancel();
	}

	public static void ClearAim(AimTarget aimTarget)
	{
		aimTarget?.Clear();
	}

	public static long PlayAreaEffect(AdventureActor actor, string fxAlias, TSVector2 position = default(TSVector2), FP rotation = default(FP), Action<AreaEffectEntity> onBeforeSetup = null, AdventureActor resActor = null, Action<AreaEffectEntity> onAfterSetup = null)
	{
		if (string.IsNullOrEmpty(fxAlias))
		{
			return 0L;
		}
		GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetAreaEffectByAlias(resActor ?? actor, fxAlias);
		if (gameObject == null)
		{
			gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, fxAlias);
		}
		if (gameObject == null)
		{
			Debug.Log("area effect Alias:" + fxAlias + " not exit");
			fxAlias = "Assets/AssetBundles/" + fxAlias + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, fxAlias, typeof(GameObject)) as GameObject;
		}
		if (gameObject == null)
		{
			Debug.LogError(actor.name + "的区域效果资源不存在:" + fxAlias);
			return 0L;
		}
		Vector3 spawnPosition = new Vector3((float)position.x, (float)actor.tsTransform.PositionY, (float)position.y);
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)rotation, 0f);
		return SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(actor, gameObject, spawnPosition, spawnRotation, isAssemble: false, onBeforeSetup, onAfterSetup);
	}

	public static long PlayAreaEffect(AdventureActor actor, GameObject prefab, TSVector2 position = default(TSVector2), FP rotation = default(FP), Action<AreaEffectEntity> onBeforeSetup = null, Action<AreaEffectEntity> onAfterSetup = null)
	{
		if (prefab == null)
		{
			return 0L;
		}
		Vector3 spawnPosition = new Vector3((float)position.x, (float)actor.tsTransform.PositionY, (float)position.y);
		Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)rotation, 0f);
		return SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(actor, prefab, spawnPosition, spawnRotation, isAssemble: false, onBeforeSetup, onAfterSetup);
	}

	public static void StopAreaEffect(long id)
	{
		SceneSingleton<AreaEffectManager>.Instance.StopAreaEffect(id);
	}

	public static void StopAreaEffectByTag(string tag)
	{
		int tagHashCode = CommonHelper.StringToHash(tag);
		SceneSingleton<AreaEffectManager>.Instance.StopAreaEffectByTag(tagHashCode);
	}

	public static void StopAreaEffectByTag(int areaHashCode)
	{
		SceneSingleton<AreaEffectManager>.Instance.StopAreaEffectByTag(areaHashCode);
	}

	public static AreaEffectEntity GetAreaEffect(long id)
	{
		return SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(id);
	}

	public static List<AreaEffectEntity> GetAreaEffectByTag(string tag)
	{
		int tagHashCode = CommonHelper.StringToHash(tag);
		return SceneSingleton<AreaEffectManager>.Instance.GetAreaEffectsByTag(tagHashCode);
	}

	public static List<AreaEffectEntity> GetAreaEffectByTag(int areaHashCode)
	{
		return SceneSingleton<AreaEffectManager>.Instance.GetAreaEffectsByTag(areaHashCode);
	}

	public static T GetAreaEffectComponent<T>(long id, int index = 0) where T : AreaEffect_Component
	{
		AreaEffectEntity areaEffect = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(id);
		if (!(areaEffect != null))
		{
			return null;
		}
		return areaEffect.GetAreaEffectComponent<T>(index);
	}

	public static bool CheckAreaEffectAlive(long id)
	{
		AreaEffectEntity areaEffect = SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(id);
		if (areaEffect == null)
		{
			return false;
		}
		return areaEffect.ActiveSelf;
	}

	public static void AddAreaEffectLeftTime(long id, FP fixedTime)
	{
		SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(id)?.AddLeftTime(fixedTime);
	}

	public static void ModifyAreaEffectLeftTime(long id, FP leftTime)
	{
		SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(id)?.ModifyLeftTime(leftTime);
	}

	public static void ModifyAreaEffectScale(long id, FP scale)
	{
		SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(id)?.ModifyScale(scale);
	}

	public static void ResetAreaEffectScale(long id)
	{
		SceneSingleton<AreaEffectManager>.Instance.GetAreaEffect(id)?.ResetScale();
	}

	public static void FixAreaEffectMaxCountByTag(string tag, int fixCount)
	{
		int areaHashCode = CommonHelper.StringToHash(tag);
		SceneSingleton<AreaEffectManager>.Instance.FixMaxCountByTag(areaHashCode, fixCount);
	}

	public static void FixAreaEffectMaxCountByHashCode(int areaHashCode, int fixCount)
	{
		SceneSingleton<AreaEffectManager>.Instance.FixMaxCountByTag(areaHashCode, fixCount);
	}

	public static void BeginBezierPathMove(ref BezierPathMove bezierPathMove, AdventureActor actor, TSVector2 targetPosition, FP controlPointXOffsetRatio, FP controlPointYOffsetRatio, bool comboWithAttack = false, FP moveSpeedRatioAbsAmend = default(FP), AdventureActor.MovementMode movementMode = AdventureActor.MovementMode.Run, int moveStep = 20, Action<bool> completeCallback = null, FP maxDuration = default(FP))
	{
		if (bezierPathMove == null)
		{
			bezierPathMove = new BezierPathMove();
		}
		bezierPathMove.BeginMove(actor, targetPosition, controlPointXOffsetRatio, controlPointYOffsetRatio, comboWithAttack, moveSpeedRatioAbsAmend, movementMode, moveStep, completeCallback, maxDuration);
	}

	public static void CancelBezierPathMove(BezierPathMove bezierPathMove)
	{
		bezierPathMove?.CancelMove();
	}

	public static void ClearBezierPathMove(BezierPathMove bezierPathMove)
	{
		bezierPathMove?.Clear();
	}

	public static void Clear()
	{
		searchDataPool?.Clear();
		_deterministicColliders?.Clear();
		_hitBoxPool?.Clear();
		_hitBoxContextPool?.Clear();
		_tempTargets?.Clear();
	}

	public static void BeginComboAttack(ref ComboAttack comboAttack, AdventureActor actor, AdventureSkill skill, ComboInputBuffer.ActionKey[] actionKeys, bool flushInputedKeys = false, int skillId = 0, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null, LogicEntity aimTarget = null, TSVector2 aimTargetPosition = default(TSVector2), Action onAnticipationEnd = null, Action onRecoveryBegin = null, Action onComboLoop = null, Action onComboFinish = null, Action onInterrupt = null, Action<string> onCustomEvent = null, Action onActivationEnd = null, bool fadeOutAnim = true, Action onSendSkillTakeEffect = null, bool keyPerfectMatch = false, string actionTag = "")
	{
		if (comboAttack == null)
		{
			comboAttack = new ComboAttack();
		}
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys, skillId, forceInterruptAttack, autoLookAtTarget, attackTarget, aimTarget, aimTargetPosition, onAnticipationEnd, onRecoveryBegin, onComboLoop, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd, fadeOutAnim, onSendSkillTakeEffect, keyPerfectMatch, actionTag);
	}

	public static void CancelComboAttack(ComboAttack comboAttack)
	{
		comboAttack?.CancelAttack();
	}

	public static void InterruptComboAttack(ComboAttack comboAttack)
	{
		comboAttack?.InterruptAttack();
	}

	public static void ClearComboAttack(ComboAttack comboAttack)
	{
		comboAttack?.Clear();
	}

	public static bool CreateSkill(int skillId, AdventureActor actor, SkillPhaseFeatureFlag skillCastBehaviourType = SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType skillLauncherType = SkillLauncherType.Character, bool isInterruptAttack = true, bool isBreakable = true, SkillCountdownTiming countdownTiming = SkillCountdownTiming.Start, Action<bool> finishCallback = null, Action<FP> beginCDForMonsterCallback = null, bool ingoreCDAndEnergy = false, bool isRushJoinDodge = true)
	{
		if (actor == null || actor.isDead)
		{
			finishCallback?.Invoke(obj: false);
			return false;
		}
		AdventureSkill adventureSkill = null;
		bool flag = false;
		PlayerAdventureActor playerAdventureActor = actor as PlayerAdventureActor;
		if (playerAdventureActor != null)
		{
			playerAdventureActor.isPreventNormalAttackByObstacle = false;
		}
		if (skillLauncherType == SkillLauncherType.Character && skillCastBehaviourType == SkillPhaseFeatureFlag.Normal)
		{
			if (!(actor.attackTarget != null))
			{
				finishCallback?.Invoke(obj: false);
				return false;
			}
			TSVector2 origin = actor.tsTransform.Position;
			TSVector2 tSVector = actor.attackTarget.tsTransform.Position - origin;
			TSVector2 direction = tSVector.normalized;
			if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var hitInfo, tSVector.magnitude, 4096))
			{
				AdventureObstacle component = hitInfo.collider.GetComponent<AdventureObstacle>();
				if (!(component != null))
				{
					finishCallback?.Invoke(obj: false);
					return false;
				}
				if (component.preventNormalAttack)
				{
					if (playerAdventureActor != null)
					{
						playerAdventureActor.isPreventNormalAttackByObstacle = true;
					}
					finishCallback?.Invoke(obj: false);
					return false;
				}
			}
			if (actor.attackState == ActorState.AttackReload)
			{
				finishCallback?.Invoke(obj: false);
				return false;
			}
		}
		if (actor is MonsterAdventureActor { testSkillId: >0 } monsterAdventureActor)
		{
			skillId = monsterAdventureActor.testSkillId;
		}
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId);
		if (skill == null)
		{
			NovaLogger.Error($"can not find skill config, skillId:{skillId}");
			finishCallback?.Invoke(obj: false);
			return false;
		}
		if (playerAdventureActor != null)
		{
			if (skillCastBehaviourType == SkillPhaseFeatureFlag.Ultimate && AdventureFXManager.IsPlayingTimeline)
			{
				finishCallback?.Invoke(obj: false);
				return false;
			}
			if (playerAdventureActor.IsInCannotUseSkillStates())
			{
				finishCallback?.Invoke(obj: false);
				return false;
			}
			switch (skillCastBehaviourType)
			{
			case SkillPhaseFeatureFlag.Normal:
				if (playerAdventureActor.disableCastNormal)
				{
					NovaLogger.Debug("Normal attack can not use");
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillCannotUseTips", actor.Id, skill.Id);
					finishCallback?.Invoke(obj: false);
					return false;
				}
				break;
			case SkillPhaseFeatureFlag.Skill1:
				if (playerAdventureActor.disableCastSkill)
				{
					NovaLogger.Debug("skill can not use");
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillCannotUseTips", actor.Id, skill.Id);
					finishCallback?.Invoke(obj: false);
					return false;
				}
				break;
			case SkillPhaseFeatureFlag.Dodge:
				if (playerAdventureActor.disableCastDodge)
				{
					NovaLogger.Debug("dodge can not use");
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillCannotUseTips", actor.Id, skill.Id);
					finishCallback?.Invoke(obj: false);
					return false;
				}
				break;
			case SkillPhaseFeatureFlag.Ultimate:
				if (playerAdventureActor.disableCastUltra)
				{
					NovaLogger.Debug("Ultimate can not use");
					MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillCannotUseTips", actor.Id, skill.Id);
					finishCallback?.Invoke(obj: false);
					return false;
				}
				break;
			}
			if (skillCastBehaviourType == SkillPhaseFeatureFlag.Skill2 && !isRushJoinDodge)
			{
				adventureSkill = playerAdventureActor.actorSkillManage.GetDodgeSkill();
				if (adventureSkill != null)
				{
					if (!adventureSkill.isActivationEnd)
					{
						finishCallback?.Invoke(obj: false);
						return false;
					}
					isInterruptAttack = false;
					flag = true;
				}
			}
		}
		if (actor is MonsterAdventureActor && (actor.inChaos || actor.isSilence))
		{
			NovaLogger.Debug("skill can not use: inChaos/isSilence");
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillCannotUseTips", actor.Id, skill.Id);
			finishCallback?.Invoke(obj: false);
			return false;
		}
		if (actor.actorSkillManage != null && !actor.actorSkillManage.CheckIsSkillExecutable(skillCastBehaviourType, skill.Id))
		{
			if (skillCastBehaviourType == SkillPhaseFeatureFlag.Skill1 || skillCastBehaviourType == SkillPhaseFeatureFlag.Dodge)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("SkillUnExecutableTips", (int)skillCastBehaviourType, AdventureModuleController.Config.skillUnExecutableTipDuration);
			}
			finishCallback?.Invoke(obj: false);
			return false;
		}
		if (skillLauncherType == SkillLauncherType.Character)
		{
			bool flag2 = false;
			if (skillCastBehaviourType != SkillPhaseFeatureFlag.CertainSkillId && (skillCastBehaviourType != SkillPhaseFeatureFlag.Skill2 || !isRushJoinDodge) && !ingoreCDAndEnergy && !flag2)
			{
				PlayerSkillCd logicComponent = actor.GetLogicComponent<PlayerSkillCd>();
				if (logicComponent != null)
				{
					SkillInfo skillCD = logicComponent.GetSkillCD(skillId);
					if (skillCD != null)
					{
						if (skillCastBehaviourType != SkillPhaseFeatureFlag.Ultimate)
						{
							FP currentUseInterval = skillCD.currentUseInterval;
							if (currentUseInterval > 0)
							{
								NovaLogger.Debug($"skill in the cooling, skillId:{skillId}, cd:{currentUseInterval}");
								MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillInCoolingTips", actor.Id, skill.Id);
								finishCallback?.Invoke(obj: false);
								return false;
							}
						}
						if (skillCD.locking)
						{
							NovaLogger.Debug($"skill at locking state, skillId:{skillId}");
							MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillLockingTips", actor.Id, skill.Id);
							finishCallback?.Invoke(obj: false);
							return false;
						}
						int currentSectionAmount = skillCD.currentSectionAmount;
						if (currentSectionAmount <= 0)
						{
							NovaLogger.Debug($"skill has no can use section, skillId:{skillId}, sectionAmount:{currentSectionAmount}");
							MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillNoSectionTips", actor.Id, skill.Id);
							finishCallback?.Invoke(obj: false);
							return false;
						}
					}
				}
			}
			if (skillCastBehaviourType == SkillPhaseFeatureFlag.Ultimate && !SceneSingleton<AdventurePlayerController>.Instance.ultimateIgnoreEnergy && !ingoreCDAndEnergy && !flag2)
			{
				PlayerSkillCd logicComponent2 = actor.GetLogicComponent<PlayerSkillCd>();
				if (logicComponent2 != null)
				{
					FDP energy = logicComponent2.GetEnergy();
					int totalEnergy = logicComponent2.GetTotalEnergy();
					if ((int)(long)energy < totalEnergy)
					{
						NovaLogger.Debug($"ultra skill has no enough energy, skillId:{skillId}, energy:{energy}, total:{totalEnergy}");
						MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillEnergyNotEnoughTips", actor.Id, skill.Id);
						finishCallback?.Invoke(obj: false);
						return false;
					}
				}
			}
			if (actor.isInteractive)
			{
				if (skillCastBehaviourType != SkillPhaseFeatureFlag.Ultimate && skillCastBehaviourType != SkillPhaseFeatureFlag.Dodge)
				{
					finishCallback?.Invoke(obj: false);
					return false;
				}
				actor.ExitInteractive();
			}
		}
		AdventureSkill adventureSkill2 = ModuleController<AdventureModuleController>.Instance.SpawnSkill(skillId);
		if (null != adventureSkill2)
		{
			adventureSkill2.name = actor.name + "_skill" + skillId;
			adventureSkill2.InitSkill(skillId, actor.gameObject, null, skillLauncherType, isInterruptAttack, isBreakable, skillCastBehaviourType, countdownTiming, finishCallback, beginCDForMonsterCallback, ingoreCDAndEnergy);
			if (skillCastBehaviourType == SkillPhaseFeatureFlag.Dodge)
			{
				((PlayerAdventureActor)actor).dodgeButtonHold = true;
			}
			if (actor is PlayerAdventureActor playerAdventureActor2)
			{
				playerAdventureActor2.playerSkillCd.AddSkillEnergyPool(skillId);
			}
			if (flag)
			{
				adventureSkill?.Clear();
			}
			return true;
		}
		finishCallback?.Invoke(obj: false);
		return false;
	}

	public static void ReturnSkillResumeTime(int skillId, AdventureActor actor)
	{
		if (actor is PlayerAdventureActor { playerSkillCd: { } playerSkillCd })
		{
			playerSkillCd.ReturnSkillResumeTime(skillId);
		}
	}

	public static void BeginDash(ref Dash dash, AdventureActor actor, TSVector2 direction, FP speed, FP distance, FP angleLimit, Action finishCallback = null, Action finishByActorCallback = null, Action finishByObstacleCallback = null, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, bool checkStop = false, FP minDashTime = default(FP), bool playAnim = true)
	{
		if (dash == null)
		{
			dash = new Dash();
		}
		dash.BeginDash(actor, direction, speed, distance, angleLimit, finishCallback, finishByActorCallback, finishByObstacleCallback, comboWithAttack, isAngle, notChangeForward, triggerObstacleStop, triggerEnemyStop, triggerFriendStop, checkStop, minDashTime, playAnim);
	}

	public static void BeginDashActorForward(ref Dash dash, AdventureActor actor, FP speed, FP distance, FP angleLimit, Action finishCallback = null, Action finishByActorCallback = null, Action finishByObstacleCallback = null, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, FP minDashTime = default(FP))
	{
		if (dash == null)
		{
			dash = new Dash();
		}
		dash.BeginDashActorForward(actor, speed, distance, angleLimit, finishCallback, finishByActorCallback, finishByObstacleCallback, comboWithAttack, isAngle, notChangeForward, triggerObstacleStop, triggerEnemyStop, triggerFriendStop, minDashTime);
	}

	public static void ChangeDashSpeed(Dash dash, FP speed)
	{
		dash?.ChangeDashSpeed(speed);
	}

	public static void SetDashInputDirection(Dash dash)
	{
		dash?.SetInputDirection();
	}

	public static void InterruptDash(Dash dash)
	{
		dash?.Interrupte();
	}

	public static void ClearDash(Dash dash)
	{
		dash?.Clear();
	}

	public static void BeginDodge(ref Dodge dodge, AdventureActor actor, TSVector2 direction, FP duration, FP distance, Action onComplete = null, bool comboWithAttack = false, bool notChangeForward = false, Action onLeave = null)
	{
		if (dodge == null)
		{
			dodge = new Dodge();
		}
		dodge.Begin(actor, direction, duration, distance, onComplete, comboWithAttack, notChangeForward, onLeave);
	}

	public static void InterruptDodge(Dodge dodge)
	{
		dodge?.Interrupte();
	}

	public static void LoadConfigPrefab(string scenePath, string configPrefabName)
	{
		if (ModuleController<AdventureModuleController>.Instance?.levelInstance == null)
		{
			return;
		}
		string[] array = scenePath.Split('/');
		string text = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(text);
		string assetName = scenePath + "/" + configPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			gameObject2.transform.localScale = Vector3.one;
			gameObject2.name = configPrefabName;
			SceneManager.MoveGameObjectToScene(gameObject2, sceneByName);
		}
		else
		{
			Debug.LogError("策划配置预制体加载失败：" + configPrefabName);
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject3 in rootGameObjects)
		{
			if (gameObject3.name.Equals(configPrefabName))
			{
				Transform transform = gameObject3.transform.Find("==== Triggers ====");
				if (transform != null)
				{
					TriggerCom[] componentsInChildren = transform.GetComponentsInChildren<TriggerCom>();
					Singleton<TriggerManager>.Instance.AddTriggers(componentsInChildren, -1, -1);
				}
				ModuleController<AdventureModuleController>.Instance.levelInstance.teleporters = gameObject3.GetComponentsInChildren<AdventureLevelTeleporter>().ToList();
				if (ModuleController<AdventureModuleController>.Instance.levelInstance.teleporters != null)
				{
					for (int j = 0; j < ModuleController<AdventureModuleController>.Instance.levelInstance.teleporters.Count; j++)
					{
						ModuleController<AdventureModuleController>.Instance.levelInstance.teleporters.get_Item(j).SetPosition(-1, -1);
					}
				}
			}
			if (gameObject3.name.Equals("==== Navigation ===="))
			{
				ModuleController<AdventureModuleController>.Instance.levelInstance.HandleNavigation(gameObject3, text);
			}
		}
	}

	public static void HandleSpawnGizmos()
	{
		if (ModuleController<AdventureModuleController>.Instance?.levelInstance == null)
		{
			return;
		}
		ModuleController<AdventureModuleController>.Instance.levelInstance.HandleSpawnGizmos();
		for (int i = 0; i < ModuleController<AdventureModuleController>.Instance.levelInstance.monsterSpawnWaves.Count; i++)
		{
			ModuleController<AdventureModuleController>.Instance.levelInstance.monsterSpawnWaves.get_Item(i).Initialize(-1, -1);
		}
		for (int j = 0; j < ModuleController<AdventureModuleController>.Instance.levelInstance.virtualMonsterSpawnWaves.Count; j++)
		{
			ModuleController<AdventureModuleController>.Instance.levelInstance.virtualMonsterSpawnWaves.get_Item(j).Initialize(-1, -1);
		}
		for (int k = 0; k < ModuleController<AdventureModuleController>.Instance.levelInstance.trapGroups.Count; k++)
		{
			ModuleController<AdventureModuleController>.Instance.levelInstance.trapGroups.get_Item(k).Initialize(-1, -1);
		}
		ModuleController<AdventureModuleController>.Instance.levelInstance.PreloadAssets();
		for (int l = 0; l < ModuleController<AdventureModuleController>.Instance.levelInstance.monsterSpawnWaves.Count; l++)
		{
			if (!ModuleController<AdventureModuleController>.Instance.levelInstance.monsterSpawnWaves.get_Item(l).isTriggerActived)
			{
				ModuleController<AdventureModuleController>.Instance.levelInstance.monsterSpawnWaves.get_Item(l).EnableSpawnLogic();
			}
		}
		for (int m = 0; m < ModuleController<AdventureModuleController>.Instance.levelInstance.trapGroups.Count; m++)
		{
			ModuleController<AdventureModuleController>.Instance.levelInstance.trapGroups.get_Item(m).EnableSpawnLogic();
		}
	}

	public static void ForceMove(AdventureActor actor, List<AdventureActor> targets, FP moveSpeed, List<FP> distances, bool isCoExist, bool isChangeForward, int moveLevel, FP strength)
	{
		for (int i = 0; i < targets.Count; i++)
		{
			TSVector2 normalized = (actor.tsTransform.Position - targets.get_Item(i).tsTransform.Position).normalized;
			FP fP = distances.get_Item(i);
			if (fP > 0)
			{
				targets.get_Item(i).EnterForceMove(strength, moveSpeed, fP, normalized, isCoExist, isChangeForward, moveLevel, actor);
			}
		}
	}

	public static void ForceMoveToPosition(TSVector2 position, List<LogicEntity> targets, FP moveSpeed, List<FP> distances, bool isCoExist, bool isChangeForward, int moveLevel, FP strength)
	{
		for (int i = 0; i < targets.Count; i++)
		{
			AdventureActor adventureActor = targets.get_Item(i) as AdventureActor;
			if (!(adventureActor == null))
			{
				TSVector2 normalized = (position - targets.get_Item(i).tsTransform.Position).normalized;
				FP fP = distances.get_Item(i);
				if (fP > 0)
				{
					adventureActor.EnterForceMove(strength, moveSpeed, fP, normalized, isCoExist, isChangeForward, moveLevel);
				}
			}
		}
	}

	public static void ForceMoveByDistance(AdventureActor actor, List<LogicEntity> targets, FP distance, FP moveSpeed, bool isCoExist, bool isChangeForward, int moveLevel, FP strength, bool isPull = false)
	{
		ForceMoveByDistanceToPosition(actor, actor.tsTransform.Position, targets, distance, moveSpeed, strength, moveLevel, isPull, withRadius: true, isCoExist, isChangeForward);
	}

	public static int ForceMoveByDistanceToPosition(AdventureActor actor, TSVector2 position, List<LogicEntity> targets, FP distance, FP moveSpeed, FP strength, int moveLevel = 99, bool isPull = false, bool withRadius = false, bool isCoExist = true, bool isChangeForward = true, FP stopDistance = default(FP))
	{
		int num = 0;
		if (actor == null)
		{
			return num;
		}
		if (targets == null || targets.Count <= 0)
		{
			return num;
		}
		stopDistance = ((stopDistance > 0) ? stopDistance : ((FP)0));
		for (int i = 0; i < targets.Count; i++)
		{
			AdventureActor adventureActor = targets.get_Item(i) as AdventureActor;
			if (adventureActor == null || adventureActor is DestructibleStateSingle)
			{
				continue;
			}
			TSVector2 normalized = (position - targets.get_Item(i).tsTransform.Position).normalized;
			FP fP = TSVector2.Distance(position, targets.get_Item(i).tsTransform.Position);
			if (withRadius)
			{
				fP -= actor.GetRadius() + adventureActor.GetRadius();
			}
			fP -= stopDistance;
			if (distance > fP)
			{
				distance = fP;
			}
			if (distance <= 0)
			{
				continue;
			}
			if (isPull)
			{
				if (adventureActor.EnterPull(strength, moveSpeed, distance, normalized, isCoExist, isChangeForward, moveLevel, actor))
				{
					num++;
				}
			}
			else if (adventureActor.EnterForceMove(strength, moveSpeed, distance, normalized, isCoExist, isChangeForward, moveLevel, actor))
			{
				num++;
			}
		}
		return num;
	}

	public static bool ForceMoveByDistanceToPosition(AdventureActor actor, TSVector2 position, LogicEntity entity, FP distance, FP moveSpeed, FP strength, int moveLevel = 99, bool isPull = false, bool withRadius = false, bool isCoExist = true, bool isChangeForward = true)
	{
		if (actor == null)
		{
			return false;
		}
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null || adventureActor is DestructibleStateSingle)
		{
			return false;
		}
		TSVector2 normalized = (position - adventureActor.tsTransform.Position).normalized;
		FP fP = TSVector2.Distance(position, adventureActor.tsTransform.Position);
		if (withRadius)
		{
			fP -= actor.GetRadius() + adventureActor.GetRadius();
		}
		if (fP < distance)
		{
			distance = fP;
		}
		if (distance <= 0)
		{
			return false;
		}
		if (isPull)
		{
			if (adventureActor.EnterPull(strength, moveSpeed, distance, normalized, isCoExist, isChangeForward, moveLevel, actor))
			{
				return true;
			}
		}
		else if (adventureActor.EnterForceMove(strength, moveSpeed, distance, normalized, isCoExist, isChangeForward, moveLevel, actor))
		{
			return true;
		}
		return false;
	}

	public static List<AdventureActor> GetAllPlayerActors(AdventureActor player, bool includeSelf = true)
	{
		_tempTargets.Clear();
		if (player is PlayerAdventureActor)
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (includeSelf || !(actorL == player))
				{
					_tempTargets.Add(actorL);
				}
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetAssistantPlayers()
	{
		_tempTargets.Clear();
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (!(actorL == SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor))
			{
				_tempTargets.Add(actorL);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetFriendFactionMinions(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
		{
			AdventureActor adventureActor = monsterActor as AdventureActor;
			if (!(adventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor)) && actor.IsFriendlyWith(adventureActor) && adventureActor.IsMinion(out var _))
			{
				_tempTargets.Add(adventureActor);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetConfrontFactionMinions(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
		{
			AdventureActor adventureActor = monsterActor as AdventureActor;
			if (!(adventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor)) && actor.IsConfrontWith(adventureActor) && adventureActor.IsMinion(out var _))
			{
				_tempTargets.Add(adventureActor);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetFriendAndConfrontFactionMinions(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
		{
			AdventureActor adventureActor = monsterActor as AdventureActor;
			if (!(adventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor)) && !actor.IsNeutralWith(adventureActor) && adventureActor.IsMinion(out var _))
			{
				_tempTargets.Add(adventureActor);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetFriendFactionActors(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (LogicEntity playerActor in ModuleController<AdventureModuleController>.Instance.playerActors)
		{
			PlayerAdventureActor playerAdventureActor = playerActor as PlayerAdventureActor;
			if (!(playerAdventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(playerAdventureActor)) && actor.IsFriendlyWith(playerAdventureActor))
			{
				_tempTargets.Add(playerAdventureActor);
			}
		}
		foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
		{
			AdventureActor adventureActor = monsterActor as AdventureActor;
			if (!(adventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor)) && actor.IsFriendlyWith(adventureActor))
			{
				_tempTargets.Add(adventureActor);
			}
		}
		foreach (LogicEntity dynamicActor in ModuleController<AdventureModuleController>.Instance.dynamicActors)
		{
			AdventureActor adventureActor2 = dynamicActor as AdventureActor;
			if (!(adventureActor2 == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor2)) && actor.IsFriendlyWith(adventureActor2))
			{
				_tempTargets.Add(adventureActor2);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetConfrontFactionActors(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (LogicEntity playerActor in ModuleController<AdventureModuleController>.Instance.playerActors)
		{
			PlayerAdventureActor playerAdventureActor = playerActor as PlayerAdventureActor;
			if (!(playerAdventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(playerAdventureActor)) && actor.IsConfrontWith(playerAdventureActor))
			{
				_tempTargets.Add(playerAdventureActor);
			}
		}
		foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
		{
			AdventureActor adventureActor = monsterActor as AdventureActor;
			if (!(adventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor)) && actor.IsConfrontWith(adventureActor))
			{
				_tempTargets.Add(adventureActor);
			}
		}
		foreach (LogicEntity dynamicActor in ModuleController<AdventureModuleController>.Instance.dynamicActors)
		{
			AdventureActor adventureActor2 = dynamicActor as AdventureActor;
			if (!(adventureActor2 == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor2)) && actor.IsConfrontWith(adventureActor2))
			{
				_tempTargets.Add(adventureActor2);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetFriendAndConfrontFactionActors(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (LogicEntity playerActor in ModuleController<AdventureModuleController>.Instance.playerActors)
		{
			PlayerAdventureActor playerAdventureActor = playerActor as PlayerAdventureActor;
			if (!(playerAdventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(playerAdventureActor)) && !actor.IsNeutralWith(playerAdventureActor))
			{
				_tempTargets.Add(playerAdventureActor);
			}
		}
		foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
		{
			AdventureActor adventureActor = monsterActor as AdventureActor;
			if (!(adventureActor == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor)) && !actor.IsNeutralWith(adventureActor))
			{
				_tempTargets.Add(adventureActor);
			}
		}
		foreach (LogicEntity dynamicActor in ModuleController<AdventureModuleController>.Instance.dynamicActors)
		{
			AdventureActor adventureActor2 = dynamicActor as AdventureActor;
			if (!(adventureActor2 == null) && (!aliveOnly || CommonHelper.IsEntityAlive(adventureActor2)) && !actor.IsNeutralWith(adventureActor2))
			{
				_tempTargets.Add(adventureActor2);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetSelfMinions(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (AdventureModuleController.MonsterSummonData monsterSummonInfo in ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos)
		{
			if ((!aliveOnly || CommonHelper.IsEntityAlive(monsterSummonInfo.monster)) && monsterSummonInfo.SummonActorID == actor.Id && monsterSummonInfo.monster.IsMinion(out var _))
			{
				_tempTargets.Add(monsterSummonInfo.monster);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetFactionMinionsExceptSelf(AdventureActor actor, bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (AdventureModuleController.MonsterSummonData monsterSummonInfo in ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos)
		{
			if ((!aliveOnly || CommonHelper.IsEntityAlive(monsterSummonInfo.monster)) && monsterSummonInfo.SummonActorID != actor.Id && monsterSummonInfo.monster.IsPlayerMinion(out var _))
			{
				_tempTargets.Add(monsterSummonInfo.monster);
			}
		}
		return _tempTargets;
	}

	public static List<AdventureActor> GetAllPlayerActorAndMinion(bool aliveOnly = true)
	{
		_tempTargets.Clear();
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			_tempTargets.Add(actorL);
		}
		foreach (AdventureModuleController.MonsterSummonData monsterSummonInfo in ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos)
		{
			if ((!aliveOnly || CommonHelper.IsEntityAlive(monsterSummonInfo.monster)) && monsterSummonInfo.monster.IsPlayerMinion(out var _))
			{
				_tempTargets.Add(monsterSummonInfo.monster);
			}
		}
		return _tempTargets;
	}

	public static HitBox GetHitBox(LogicEntity owner, GameObject hurtEffectSource = null)
	{
		HitBoxContext hitBoxContext = GetHitBoxContext(owner);
		HitBox hitBox = default;
		if (!_hitBoxPool.TryDequeue(ref hitBox))
		{
			hitBox = HitBox.Setup(new GameObject("OnceHitBox"), owner, hitBoxContext);
		}
		else
		{
			hitBox.owner = owner;
			hitBox.context = hitBoxContext;
		}
		hitBox.hurtEffectSource = hurtEffectSource;
		return hitBox;
	}

	private static HitBoxContext GetHitBoxContext(LogicEntity owner)
	{
		if (!_hitBoxContextPool.TryGetValue(owner.Id, out var value) && !TryRecycleHitContext(owner, out value))
		{
			value = new HitBoxContext(owner);
			_hitBoxContextPool.Add(owner.Id, value);
		}
		return value;
	}

	private static bool TryRecycleHitContext(LogicEntity owner, out HitBoxContext context)
	{
		context = null;
		long key = 0L;
		if (_hitBoxContextPool.Count > 0)
		{
			foreach (long key2 in _hitBoxContextPool.Keys)
			{
				if (ModuleController<AdventureModuleController>.Instance.QueryEntityByID(key2) == null)
				{
					context = _hitBoxContextPool.get_Item(key2);
					key = key2;
					break;
				}
			}
		}
		if (context != null)
		{
			context.owner = owner;
			context.ClearActorHitedTime();
			_hitBoxContextPool.Remove(key);
			_hitBoxContextPool.Add(owner.Id, context);
			return true;
		}
		return false;
	}

	private static void RecycleHitBox(HitBox hitBox)
	{
		if (!(hitBox == null))
		{
			hitBox.context = null;
			_hitBoxPool.Enqueue(hitBox);
		}
	}

	public static void DirectDamage(AdventureActor actor, AdventureActor target, int damage, string damageTag = null, string hittedFxPath = null, bool showHud = true, bool isHurtEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		GameObject gameObject = null;
		if (!string.IsNullOrEmpty(hittedFxPath))
		{
			gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, hittedFxPath);
			if (gameObject == null)
			{
				Debug.Log("DirectDamage Hitted fxAlias:" + hittedFxPath + " not exit");
				hittedFxPath = "Assets/AssetBundles/" + hittedFxPath + ".prefab";
				gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, hittedFxPath, typeof(GameObject)) as GameObject;
			}
			if (gameObject == null)
			{
				Debug.LogError("DirectDamage Hitted fxAlias:" + hittedFxPath + " not exit");
			}
		}
		target.DirectDamage(damage, damageTag, actor.Id, showHud, null, gameObject, isHurtEffectScale, effectIgnoreTimeScale);
	}

	public static bool HitActor(AdventureActor actor, AdventureActor target, int hitDamageId, string hittedFxPath = null, string attackFxPath = null, bool attackFxPlayOnTarget = false, HitBox.FeatureFlag hitboxFeatureFlags = HitBox.FeatureFlag.None, HitBox.HitBoxFeatureData hitboxFeatureData = null, FP damageImmuneDuration = default(FP), HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small, int uniqueAttackId = 0, GameObject hurtEffectSource = null, bool isHittedEffectScale = true)
	{
		HitBox hitBox = GetHitBox(actor, hurtEffectSource);
		hitBox.hitDamageId = hitDamageId;
		hitBox.featureFlags = hitboxFeatureFlags;
		hitBox.featureData = hitboxFeatureData;
		hitBox.hurtAnimType = hurtAnimType;
		GameObject gameObject = null;
		if (!string.IsNullOrEmpty(hittedFxPath))
		{
			gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, hittedFxPath);
			if (gameObject == null)
			{
				Debug.Log("HitActor Hitted fxAlias:" + hittedFxPath + " not exit");
				hittedFxPath = "Assets/AssetBundles/" + hittedFxPath + ".prefab";
				gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, hittedFxPath, typeof(GameObject)) as GameObject;
			}
			if (gameObject == null)
			{
				Debug.LogError("HitActor Hitted fxAlias:" + hittedFxPath + " not exit");
			}
		}
		if (!string.IsNullOrEmpty(attackFxPath))
		{
			GameObject gameObject2 = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, attackFxPath);
			if (gameObject2 == null)
			{
				attackFxPath = "Assets/AssetBundles/" + attackFxPath + ".prefab";
				gameObject2 = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, attackFxPath, typeof(GameObject)) as GameObject;
			}
			if (gameObject2 == null)
			{
				Debug.LogError("HitActor Attack fxAlias:" + attackFxPath + " not exit");
			}
			Vector3 position;
			if (attackFxPlayOnTarget)
			{
				position = target.transform.position;
				position.y = (float)target.dtCollider.HeightCenter;
			}
			else
			{
				position = actor.transform.position;
				position.y = (float)actor.dtCollider.HeightCenter;
			}
			Transform transform = actor.transform;
			if (hitBox.hurtEffectSource != null)
			{
				transform = hitBox.hurtEffectSource.transform;
			}
			GameObject fxPrefab = gameObject2;
			float playbackSpeed = (float)actor.logicTimeScale;
			Vector3 spawnPosition = position;
			Quaternion identity = Quaternion.identity;
			float spawnSize = (float)actor.actorScaleInfo.modelScale;
			Transform source = transform;
			Transform transform2 = target.transform;
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(fxPrefab, playbackSpeed, spawnPosition, identity, spawnSize, source, default, transform2);
			if (attackFxPlayOnTarget)
			{
				adventureFXPlayer?.Bind(target.gameObject);
			}
		}
		DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
		{
			isValid = false
		};
		if (uniqueAttackId <= 0)
		{
			uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		}
		hitBox.HitSingleTarget(uniqueAttackId, target.dtCollider, out var _, out var damaged, ref raycastHit, gameObject, isHittedEffectScale, damageImmuneDuration);
		RecycleHitBox(hitBox);
		return damaged;
	}

	public static int HitActors(AdventureActor actor, List<LogicEntity> hitTargets, CommomAreaHitConfig commonAreaHitConfig)
	{
		int damageCount = 0;
		if (hitTargets == null || hitTargets.Count == 0)
		{
			return damageCount;
		}
		HitBox hitBox = GetHitBox(actor);
		hitBox.hitDamageId = commonAreaHitConfig.hitDamageId;
		hitBox.featureFlags = commonAreaHitConfig.hitFlags;
		hitBox.featureData = commonAreaHitConfig.hitFeatureData;
		hitBox.hurtAnimType = commonAreaHitConfig.hurtAnimType;
		GameObject gameObject = null;
		if (!string.IsNullOrEmpty(commonAreaHitConfig.fxAlias))
		{
			gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, commonAreaHitConfig.fxAlias);
			if (gameObject == null)
			{
				Debug.LogError("HitActor fxAlias:" + commonAreaHitConfig.fxAlias + " not exit");
			}
		}
		if (deterministicColliders == null)
		{
			deterministicColliders = new List<DeterministicCollider>();
		}
		else
		{
			deterministicColliders.Clear();
		}
		foreach (LogicEntity hitTarget in hitTargets)
		{
			deterministicColliders.Add(hitTarget.GetComponent<AdventureActor>().dtCollider);
		}
		DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
		{
			isValid = false
		};
		int uniqueAttackId = commonAreaHitConfig.uniqueAttackId;
		if (uniqueAttackId <= 0)
		{
			uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		}
		hitBox.HitTargets(uniqueAttackId, deterministicColliders, out var _, out damageCount, ref raycastHit, gameObject, isHittedEffectScale: true, commonAreaHitConfig.damageImmuneDuration);
		RecycleHitBox(hitBox);
		return damageCount;
	}

	public static int FanAreaHit(AdventureActor actor, CommomAreaHitConfig commonAreaHitConfig, FP angle, FP radius, FP innerRadius)
	{
		HitBox hitBox = GetHitBox(actor);
		if (!string.IsNullOrEmpty(commonAreaHitConfig.fxAlias))
		{
			GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, commonAreaHitConfig.fxAlias);
			if (gameObject == null)
			{
				string assetName = "Assets/AssetBundles/" + commonAreaHitConfig.fxAlias + ".prefab";
				gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
			}
			if (gameObject != null)
			{
				AdventureFXPlayer.PlayFX(spawnPosition: new Vector3((float)commonAreaHitConfig.position.x, commonAreaHitConfig.fxPositionY, (float)commonAreaHitConfig.position.y), spawnRotation: Quaternion.LookRotation(new Vector3((float)commonAreaHitConfig.direction.x, 0f, (float)commonAreaHitConfig.direction.y), Vector3.up), callerEntity: actor.gameObject, useActorSizeScale: commonAreaHitConfig.actorScale, useTransformSync: true, fxPrefab: gameObject, playbackSpeed: commonAreaHitConfig.fxPlaybackSpeed, spawnSize: commonAreaHitConfig.fxScale).ownerActor = actor;
			}
		}
		commonAreaHitConfig.direction.Normalize();
		FP angle2 = commonAreaHitConfig.direction.GetAngle();
		hitBox.hitDamageId = commonAreaHitConfig.hitDamageId;
		hitBox.featureFlags = commonAreaHitConfig.hitFlags;
		hitBox.featureData = commonAreaHitConfig.hitFeatureData;
		hitBox.hurtAnimType = commonAreaHitConfig.hurtAnimType;
		GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, commonAreaHitConfig.hittedEffectAlias);
		int uniqueAttackId = commonAreaHitConfig.uniqueAttackId;
		if (uniqueAttackId <= 0)
		{
			uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		}
		hitBox.FanAreaHit(angle, radius, innerRadius, commonAreaHitConfig.position, angle2, out var _, out var damageCount, uniqueAttackId, fxByAlias, isHittedEffectScale: true, commonAreaHitConfig.damageImmuneDuration);
		RecycleHitBox(hitBox);
		return damageCount;
	}

	public static int CircleAreaHit(AdventureActor actor, CommomAreaHitConfig commonAreaHitConfig, FP radius, FP innerRadius)
	{
		HitBox hitBox = GetHitBox(actor);
		if (!string.IsNullOrEmpty(commonAreaHitConfig.fxAlias))
		{
			GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, commonAreaHitConfig.fxAlias);
			if (gameObject == null)
			{
				string assetName = "Assets/AssetBundles/" + commonAreaHitConfig.fxAlias + ".prefab";
				gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
			}
			if (gameObject != null)
			{
				AdventureFXPlayer.PlayFX(spawnPosition: new Vector3((float)commonAreaHitConfig.position.x, commonAreaHitConfig.fxPositionY, (float)commonAreaHitConfig.position.y), spawnRotation: (commonAreaHitConfig.direction == TSVector2.zero) ? Quaternion.identity : Quaternion.LookRotation(new Vector3((float)commonAreaHitConfig.direction.x, 0f, (float)commonAreaHitConfig.direction.y), Vector3.up), callerEntity: actor.gameObject, useActorSizeScale: commonAreaHitConfig.actorScale, useTransformSync: true, fxPrefab: gameObject, playbackSpeed: commonAreaHitConfig.fxPlaybackSpeed, spawnSize: commonAreaHitConfig.fxScale).ownerActor = actor;
			}
		}
		hitBox.hitDamageId = commonAreaHitConfig.hitDamageId;
		hitBox.featureFlags = commonAreaHitConfig.hitFlags;
		hitBox.featureData = commonAreaHitConfig.hitFeatureData;
		hitBox.hurtAnimType = commonAreaHitConfig.hurtAnimType;
		GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, commonAreaHitConfig.hittedEffectAlias);
		int uniqueAttackId = commonAreaHitConfig.uniqueAttackId;
		if (uniqueAttackId <= 0)
		{
			uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		}
		hitBox.CircleAreaHit(radius, innerRadius, commonAreaHitConfig.position, out var _, out var damageCount, uniqueAttackId, fxByAlias, isHittedEffectScale: true, -5, commonAreaHitConfig.damageImmuneDuration);
		RecycleHitBox(hitBox);
		return damageCount;
	}

	public static int RectangleAreaHit(AdventureActor actor, CommomAreaHitConfig commonAreaHitConfig, FP width, FP length)
	{
		HitBox hitBox = GetHitBox(actor);
		if (!string.IsNullOrEmpty(commonAreaHitConfig.fxAlias))
		{
			GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, commonAreaHitConfig.fxAlias);
			if (fxByAlias != null)
			{
				AdventureFXPlayer.PlayFX(spawnPosition: new Vector3((float)commonAreaHitConfig.position.x, commonAreaHitConfig.fxPositionY, (float)commonAreaHitConfig.position.y), spawnRotation: Quaternion.LookRotation(new Vector3((float)commonAreaHitConfig.direction.x, 0f, (float)commonAreaHitConfig.direction.y), Vector3.up), callerEntity: actor.gameObject, useActorSizeScale: commonAreaHitConfig.actorScale, useTransformSync: true, fxPrefab: fxByAlias, playbackSpeed: commonAreaHitConfig.fxPlaybackSpeed, spawnSize: commonAreaHitConfig.fxScale).ownerActor = actor;
			}
		}
		commonAreaHitConfig.direction.Normalize();
		FP angle = commonAreaHitConfig.direction.GetAngle();
		hitBox.hitDamageId = commonAreaHitConfig.hitDamageId;
		hitBox.featureFlags = commonAreaHitConfig.hitFlags;
		hitBox.featureData = commonAreaHitConfig.hitFeatureData;
		hitBox.hurtAnimType = commonAreaHitConfig.hurtAnimType;
		GameObject fxByAlias2 = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, commonAreaHitConfig.hittedEffectAlias);
		int uniqueAttackId = commonAreaHitConfig.uniqueAttackId;
		if (uniqueAttackId <= 0)
		{
			uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		}
		hitBox.RectangleAreaHit(width, length, commonAreaHitConfig.position, angle, out var _, out var damageCount, uniqueAttackId, fxByAlias2, isHittedEffectScale: true, -5, commonAreaHitConfig.damageImmuneDuration);
		RecycleHitBox(hitBox);
		return damageCount;
	}

	public static void BeginLookAt(ref LookAtTarget lookAtTarget, AdventureActor actor, LogicEntity target, FP duration, FP rotateSpeed, Action onComplete, bool ignoreActorTimeScale = false, Action onRotateClear = null, FP stopAngle = default(FP))
	{
		if (lookAtTarget == null)
		{
			lookAtTarget = new LookAtTarget();
		}
		lookAtTarget.BeginLookAt(actor, target, duration, rotateSpeed, onComplete, ignoreActorTimeScale, onRotateClear, stopAngle);
	}

	public static void BeginLookAtByPos(ref LookAtTarget lookAtTarget, AdventureActor actor, TSVector2 targetPos, FP duration, FP rotateSpeed, Action onComplete, Action onClear = null, bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		if (lookAtTarget == null)
		{
			lookAtTarget = new LookAtTarget();
		}
		lookAtTarget.BeginLookAtByPos(actor, targetPos, duration, rotateSpeed, onComplete, onClear, ignoreActorTimeScale, stopAngle);
	}

	public static void BeginLookAtByDir(ref LookAtTarget lookAtTarget, AdventureActor actor, TSVector2 targetDir, FP duration, FP rotateSpeed, Action onComplete, Action onClear = null, bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		if (lookAtTarget == null)
		{
			lookAtTarget = new LookAtTarget();
		}
		lookAtTarget.BeginLookAtByDir(actor, targetDir, duration, rotateSpeed, onComplete, onClear, ignoreActorTimeScale, stopAngle);
	}

	public static void BeginLookAtForMonster(ref LookAtTarget lookAtTarget, AdventureActor actor, LogicEntity target, FP duration, FP rotateSpeed, FP stopAngle = default(FP), bool ignoreActorTimeScale = false, Action onComplete = null, Action onRotateClear = null)
	{
		if (lookAtTarget == null)
		{
			lookAtTarget = new LookAtTarget();
		}
		lookAtTarget.BeginLookAtForMonster(actor, target, duration, rotateSpeed, stopAngle, ignoreActorTimeScale, onComplete, onRotateClear);
	}

	public static void StopLookAt(LookAtTarget lookAtTarget)
	{
		lookAtTarget?.StopLookAt();
	}

	public static void ClearLookAt(LookAtTarget lookAtTarget)
	{
		lookAtTarget?.Clear();
	}

	public static void BeginNavigationMove(ref NavigationMove navigationMove, AdventureActor actor, TSVector2 targetPosition, FP stopDistance, Action onComplete = null, AdventureActor.MovementMode movementMode = AdventureActor.MovementMode.Run)
	{
		if (navigationMove == null)
		{
			navigationMove = new NavigationMove();
		}
		navigationMove.MoveTo(actor, targetPosition, stopDistance, onComplete, movementMode);
	}

	public static void BreakNavigationMove(NavigationMove navigationMove)
	{
		navigationMove?.Break();
	}

	public static void ClearNavigationMove(NavigationMove navigationMove)
	{
		navigationMove?.Clear();
	}

	public static long PlayDrop(AdventureActor actor, string fxAlias, TSVector2 spwanPos = default(TSVector2), FP posY = default(FP))
	{
		if (string.IsNullOrEmpty(fxAlias))
		{
			return 0L;
		}
		GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetDropByAlias(actor, fxAlias);
		if (gameObject == null)
		{
			gameObject = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(actor, fxAlias);
		}
		if (gameObject == null)
		{
			Debug.Log("drop Alias:" + fxAlias + " not exit");
			fxAlias = "Assets/AssetBundles/" + fxAlias + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, fxAlias, typeof(GameObject)) as GameObject;
		}
		if (gameObject == null)
		{
			Debug.LogError(actor.name + "的掉落物资源不存在:" + fxAlias);
			return 0L;
		}
		return SceneSingleton<DropsManager>.Instance.PlayDrops(actor, gameObject, spwanPos, posY);
	}

	public static DropEntity GetDropEntity(long id)
	{
		return SceneSingleton<DropsManager>.Instance.GetDropsEntity(id);
	}

	public static void PlayFX(ref PlayFX playFX, AdventureActor actor, AdventureSkill skill, string fxAlias, FP fxPositionY, TSVector2 position, TSVector2 direction, Action<long, AdventureFXPlayer> callback = null, float fxPlaybackSpeed = 1f, float fxScale = 1f, bool actorScale = false, AdventurePlayerFeedbackEffectConfigureData playerFeedbackEffectConfigureData = null, Transform target = null)
	{
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		playFX.Play(actor, skill, fxAlias, fxPositionY, position, direction, callback, fxPlaybackSpeed, fxScale, actorScale, playerFeedbackEffectConfigureData, target);
	}

	public static void PlayFX(ref PlayFX playFX, AdventureActor actor, AdventureActor bindActor, string fxAlias, TSVector2 position, FP fxPositionY, TSVector2 direction, Action<long, AdventureFXPlayer> callback = null, float fxPlaybackSpeed = 1f, float fxScale = 1f, bool actorScale = false, AdventurePlayerFeedbackEffectConfigureData playerFeedbackEffectConfigureData = null, Transform target = null)
	{
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		playFX.Play(actor, bindActor, fxAlias, position, fxPositionY, direction, callback, fxPlaybackSpeed, fxScale, actorScale, playerFeedbackEffectConfigureData, target);
	}

	public static AdventureFXPlayer PlayFX(ref PlayFX playFX, AdventureActor actor, string fxAlias, float playbackSpeed, Vector3 spawnPosition, Quaternion spawnRotation, Transform parent = null, float spawnSize = 1f, Action<long, AdventureFXPlayer> callback = null, bool actorScale = false)
	{
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		return playFX.Play(actor, fxAlias, playbackSpeed, spawnPosition, spawnRotation, parent, spawnSize, callback, actorScale);
	}

	public static void PlayFX(ref PlayFX playFX, AdventureActor actor, string fxAlias, float playbackSpeed, Transform parent, Vector3 localPosition, Vector3 localRotation, float spawnSize = 1f, Action<long, AdventureFXPlayer> callback = null)
	{
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		playFX.Play(actor, fxAlias, playbackSpeed, parent, localPosition, localRotation, spawnSize, callback);
	}

	public static void PlayLinFx(ref PlayFX playFX, AdventureActor actor, string fxAlias, float playbackSpeed, bool useCustSource, GameObject source, TSVector sourcePosition, FP sourcePositionY, GameObject targetObj, TSVector targetPosition, FP targetPositionY, float spawnSize = 1f, bool actorScale = false, bool breakWhenLostSourceOrTarget = false, Transform parent = null, Action<long, AdventureFXPlayer> callback = null)
	{
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		playFX.PlayLinFx(actor, fxAlias, playbackSpeed, useCustSource, source, sourcePosition, sourcePositionY, targetObj, targetPosition, targetPositionY, spawnSize, actorScale, breakWhenLostSourceOrTarget, parent, callback);
	}

	public static void PlayEarlyWarningFx(ref PlayFX playFX, AdventureActor actor, AdventureSkill skill, string fxAlias, float fxDuration, FP fxPositionY, TSVector2 position, Quaternion spawnRotation, float spawnSize = 1f, bool actorScale = false)
	{
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		playFX.PlayEarlyWarningFx(actor, skill, fxAlias, fxDuration, fxPositionY, position, spawnRotation, spawnSize, actorScale);
	}

	public static void CompleteWarningFx(PlayFX playFX)
	{
		playFX?.Complete();
	}

	public static void StopFx(PlayFX playFX, bool dontPlaySubFX = false)
	{
		playFX?.Stop(dontPlaySubFX);
	}

	public static void StopSubFx(PlayFX playFX)
	{
		playFX?.StopSubFx();
	}

	public static void ClearPlayFX(PlayFX playFX)
	{
		playFX?.Clear();
	}

	public static void PlayMonsterTimeline(ref PlayMonsterTimeline playMonsterTimeline, AdventureActor actor, Action onNormalComplete = null, Action onCannotPlay = null, int phaseIndex = 0)
	{
		if (playMonsterTimeline == null)
		{
			playMonsterTimeline = new PlayMonsterTimeline();
		}
		playMonsterTimeline.Play(actor, onNormalComplete, onCannotPlay, phaseIndex);
	}

	public static void PlayPlayerTimeline(ref PlayTimeline playTimeline, AdventureActor actor, Action onNormalComplete = null, Action onCannotPlay = null, int phaseIndex = 1, bool addPlayTime = true)
	{
		if (playTimeline == null)
		{
			playTimeline = new PlayTimeline();
		}
		playTimeline.Play(actor, onNormalComplete, onCannotPlay, phaseIndex, addPlayTime);
	}

	public static void ClearPlayPlayerTimeline(PlayTimeline playTimeline)
	{
		playTimeline?.Clear();
	}

	public static List<LogicEntity> GetSearchData()
	{
		if (searchDataPool.Count > 0)
		{
			for (int i = 0; i < searchDataPool.Count; i++)
			{
				if (searchDataPool.get_Item(i).frameCount != LockStepManager.frameCount)
				{
					searchDataPool.get_Item(i).ResetData();
					return searchDataPool.get_Item(i).searchResult;
				}
			}
		}
		SearchData searchData = new SearchData();
		searchDataPool.Add(searchData);
		return searchData.searchResult;
	}

	public static void SearchActorConfront(AdventureActor actor, List<LogicEntity> actors, bool onlyAlive = true, bool includeSelf = false)
	{
		SearchActors(actor, actors, onlyAlive, includeSelf);
		actor.SearchEntityConfront(actors);
	}

	public static void SearchActorFriend(AdventureActor actor, List<LogicEntity> actors, bool onlyAlive = true, bool includeSelf = false)
	{
		SearchActors(actor, actors, onlyAlive, includeSelf);
		actor.SearchEntityFriendly(actors);
	}

	public static void SearchActors(AdventureActor actor, List<LogicEntity> actors, bool onlyAlive = true, bool includeSelf = false)
	{
		if (actors == null || actors.Count == 0)
		{
			return;
		}
		for (int num = actors.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = actors.get_Item(num);
			if (!includeSelf && logicEntity == actor)
			{
				actors.RemoveAt(num);
			}
			else if (onlyAlive && !CommonHelper.IsEntityAlive(logicEntity))
			{
				actors.RemoveAt(num);
			}
		}
	}

	public static void RangeSearch(AdventureActor actor, Action<List<LogicEntity>> resultCallback, bool onlyAlive = true, bool includeSelf = false)
	{
		List<LogicEntity> searchData = GetSearchData();
		ActorSearchTarget logicComponent = actor.GetLogicComponent<ActorSearchTarget>();
		if (logicComponent == null)
		{
			return;
		}
		searchData.AddRange(logicComponent.GetEnterVisionAlertActors(useInputDirection: false, includeSelf));
		searchData.AddRange(logicComponent.GetEnterHearingAlertActors(includeSelf));
		for (int num = searchData.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = searchData.get_Item(num);
			if (onlyAlive && !CommonHelper.IsEntityAlive(logicEntity))
			{
				searchData.RemoveAt(num);
			}
			else if (!actor.IsEntityConfrontAndSearchable(logicEntity))
			{
				searchData.RemoveAt(num);
			}
		}
		resultCallback(searchData);
	}

	public static List<LogicEntity> GetHearRangeSearch(AdventureActor actor, bool onlyAlive = true, bool includeSelf = false)
	{
		List<LogicEntity> searchData = GetSearchData();
		ActorSearchTarget logicComponent = actor.GetLogicComponent<ActorSearchTarget>();
		if (logicComponent != null)
		{
			searchData.AddRange(logicComponent.GetEnterHearingAlertActors(includeSelf));
			for (int num = searchData.Count - 1; num >= 0; num--)
			{
				LogicEntity logicEntity = searchData.get_Item(num);
				if (onlyAlive && !CommonHelper.IsEntityAlive(logicEntity))
				{
					searchData.RemoveAt(num);
				}
				else if (!actor.IsEntityConfrontAndSearchable(logicEntity))
				{
					searchData.RemoveAt(num);
				}
			}
			return searchData;
		}
		return null;
	}

	public static LogicEntity GetTargetNearByRange(AdventureActor actor, FP range)
	{
		LogicEntity target = null;
		SearchByRange(actor, range, (List<LogicEntity> listValues) =>
		{
			if (listValues.Count > 0)
			{
				actor.SearchEntitySortByDistance(listValues);
				target = listValues.get_Item(0);
			}
		}, isConfront: true);
		return target;
	}

	public static List<LogicEntity> SearchByRange(AdventureActor actor, FP range, Action<List<LogicEntity>> resultCallback = null, bool isConfront = false, bool onlyAlive = true, bool includeSelf = false, Predicate<LogicEntity> customFilter = null)
	{
		List<LogicEntity> searchData = GetSearchData();
		searchData = SearchByRangeAndPosition(actor, actor.tsTransform.Position, range + actor.GetRadius(), null, isConfront, onlyAlive, includeSelf, customFilter);
		resultCallback?.Invoke(searchData);
		return searchData;
	}

	public static List<LogicEntity> SearchByRangeAndPosition(AdventureActor actor, TSVector2 center, FP range, Action<List<LogicEntity>> resultCallback = null, bool isConfront = false, bool onlyAlive = true, bool includeSelf = false, Predicate<LogicEntity> customFilter = null)
	{
		List<LogicEntity> searchData = GetSearchData();
		for (int i = 0; i < ModuleController<AdventureModuleController>.Instance.searchables.Count; i++)
		{
			Searchable searchable = ModuleController<AdventureModuleController>.Instance.searchables.get_Item(i);
			if (searchable != null && !(searchable.entity == null) && !(searchable.entity is TrapAdventureActor) && !(searchable.entity is DestructibleStateSingle) && !(searchable.entity is PlayerAdventureActor { state: not ActorState.Action }) && (includeSelf || !(searchable.entity == actor)) && (!onlyAlive || CommonHelper.IsEntityAlive(searchable.entity)) && (!isConfront || actor.IsEntityConfrontAndSearchable(searchable.entity)) && (customFilter == null || customFilter(searchable.entity)))
			{
				FP radius = searchable.entity.GetRadius();
				if (!(TSVector2.Distance(center, searchable.entity.tsTransform.Position) - radius > range))
				{
					searchData.Add(searchable.entity);
				}
			}
		}
		resultCallback?.Invoke(searchData);
		return searchData;
	}

	public static List<LogicEntity> GetMonstersFromShape(AdventureActor actor, DeterministicShape shape, bool isConfront = true, bool onlyAlive = true)
	{
		List<LogicEntity> searchData = GetSearchData();
		if (_deterministicColliders == null)
		{
			_deterministicColliders = new List<DeterministicCollider>();
		}
		else
		{
			_deterministicColliders.Clear();
		}
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_deterministicColliders, shape, 256);
		if (_deterministicColliders.Count > 0)
		{
			for (int i = 0; i < _deterministicColliders.Count; i++)
			{
				if (_deterministicColliders.get_Item(i).Entity is MonsterAdventureActor && (!onlyAlive || CommonHelper.IsEntityAlive(_deterministicColliders.get_Item(i).Entity)) && (!isConfront || actor.IsEntityConfrontAndSearchable(_deterministicColliders.get_Item(i).Entity)))
				{
					searchData.Add(_deterministicColliders.get_Item(i).Entity);
				}
			}
		}
		return searchData;
	}

	public static List<LogicEntity> GetTargetsFromShape(DeterministicShape shape, List<LogicEntity> entities = null)
	{
		List<LogicEntity> searchData = GetSearchData();
		if (_deterministicColliders == null)
		{
			_deterministicColliders = new List<DeterministicCollider>();
		}
		else
		{
			_deterministicColliders.Clear();
		}
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_deterministicColliders, shape, 256);
		if (_deterministicColliders.Count > 0)
		{
			for (int i = 0; i < _deterministicColliders.Count; i++)
			{
				searchData.Add(_deterministicColliders.get_Item(i).Entity);
			}
		}
		if (entities != null && searchData.Count > 0)
		{
			for (int num = entities.Count - 1; num >= 0; num--)
			{
				if (!searchData.Contains(entities.get_Item(num)))
				{
					entities.RemoveAt(num);
				}
			}
			return entities;
		}
		return searchData;
	}

	public static LogicEntity GetTargetNearOrFar(AdventureActor actor, bool iNear, List<LogicEntity> entities)
	{
		if (entities == null || entities.Count < 1)
		{
			return null;
		}
		FP fP = (iNear ? 9999 : 0);
		int index = 0;
		for (int i = 0; i < entities.Count; i++)
		{
			FP fP2 = TSVector2.Distance(actor.tsTransform.Position, entities.get_Item(i).tsTransform.Position);
			if (iNear)
			{
				if (fP2 < fP)
				{
					fP = fP2;
					index = i;
				}
			}
			else if (fP2 > fP)
			{
				fP = fP2;
				index = i;
			}
		}
		return entities.get_Item(index);
	}

	public static LogicEntity GetTargetHp(bool hpMin, List<LogicEntity> entities, bool isAbs)
	{
		if (entities == null || entities.Count == 0)
		{
			return null;
		}
		int num = 0;
		int index = 0;
		for (int i = 0; i < entities.Count; i++)
		{
			AdventureActor adventureActor = entities.get_Item(i) as AdventureActor;
			int num2 = (int)(isAbs ? adventureActor.actorHealthInfo.hp : ((long)(adventureActor.actorHealthInfo.hpPercentage * 100)));
			if (i == 0)
			{
				num = num2;
			}
			if (hpMin)
			{
				if (num2 <= num)
				{
					num = num2;
					index = i;
				}
			}
			else if (num2 >= num)
			{
				num = num2;
				index = i;
			}
		}
		return entities.get_Item(index);
	}

	public static List<LogicEntity> SearchAllConfrontActors(AdventureActor actor)
	{
		List<LogicEntity> searchData = GetSearchData();
		List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (playerActors != null && playerActors.Count > 0)
		{
			searchData.AddRange(playerActors);
		}
		if (monsterActors != null && monsterActors.Count > 0)
		{
			searchData.AddRange(monsterActors);
		}
		SearchActorConfront(actor, searchData);
		return searchData;
	}

	public static List<LogicEntity> SearchAllFriendActors(AdventureActor actor, bool includeSelf = false)
	{
		List<LogicEntity> searchData = GetSearchData();
		List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (playerActors != null && playerActors.Count > 0)
		{
			searchData.AddRange(playerActors);
		}
		if (monsterActors != null && monsterActors.Count > 0)
		{
			searchData.AddRange(monsterActors);
		}
		SearchActorFriend(actor, searchData, onlyAlive: true, includeSelf);
		return searchData;
	}

	public static AdventureWeapon Shoot(string weaponAlias, AdventureActor actor, TSVector2 position = default(TSVector2), TSVector2 dirction = default(TSVector2), FP positionY = default(FP), LogicEntity target = null, Action<GameObject> onGetObj = null)
	{
		if (string.IsNullOrEmpty(weaponAlias))
		{
			return null;
		}
		GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(actor, weaponAlias);
		if (gameObject == null)
		{
			Debug.Log("shoot weapon Alias:" + weaponAlias + " not exit");
			weaponAlias = "Assets/AssetBundles/" + weaponAlias + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, weaponAlias, typeof(GameObject)) as GameObject;
		}
		onGetObj?.Invoke(gameObject);
		return actor.shootBehaviour.Shoot(gameObject, position, dirction, positionY, target);
	}

	public static AdventureBulletBase Shoot(string bulletAlias, AdventureActor actor, FP range, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 targetPosition = default(TSVector2), LogicEntity target = null, AimType aimType = AimType.Default, BulletDirectionType bulletDirectionType = BulletDirectionType.ActorToBullet, Action<GameObject> onGetObj = null)
	{
		if (string.IsNullOrEmpty(bulletAlias))
		{
			return null;
		}
		GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(actor, bulletAlias);
		if (gameObject == null)
		{
			Debug.Log("shoot bullet Alias:" + bulletAlias + " not exit");
			bulletAlias = "Assets/AssetBundles/" + bulletAlias + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, bulletAlias, typeof(GameObject)) as GameObject;
		}
		onGetObj?.Invoke(gameObject);
		if (gameObject == null)
		{
			Debug.LogError(actor.name + "子弹资源不存在：" + bulletAlias);
			return null;
		}
		TSVector2 tSVector = TSVector2.zero;
		if (position == default(TSVector2))
		{
			position = actor.tsTransform.Position;
		}
		switch (aimType)
		{
		case AimType.Default:
			tSVector = ((position == actor.tsTransform.Position) ? actor.tsTransform.Forward : (position - actor.tsTransform.Position).normalized);
			targetPosition = position + tSVector * range;
			break;
		case AimType.Forward:
			tSVector = actor.tsTransform.Forward;
			targetPosition = position + tSVector * range;
			break;
		case AimType.Position:
			switch (bulletDirectionType)
			{
			case BulletDirectionType.BulletToTarget:
				tSVector = (targetPosition - position).normalized;
				break;
			case BulletDirectionType.ActorToBullet:
				tSVector = (position - actor.tsTransform.Position).normalized;
				break;
			}
			break;
		case AimType.Target:
			if (target == null)
			{
				Debug.LogError("瞄准模式为'攻击目标'时，目标不能为空");
				return null;
			}
			tSVector = bulletDirectionType switch
			{
				BulletDirectionType.BulletToTarget => (target.tsTransform.Position - position).normalized, 
				BulletDirectionType.ActorToBullet => (position - actor.tsTransform.Position).normalized, 
				_ => tSVector, 
			};
			targetPosition = target.tsTransform.Position;
			break;
		}
		return actor.shootBehaviour.Shoot(gameObject, position, positionY, tSVector, targetPosition, target, useShootDeviationCalcScatteringRadius: false, default, aimType);
	}

	public static AdventureBulletBase ShootByDirection(string bulletAlias, AdventureActor actor, FP range, TSVector2 shootDir, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 targetPosition = default(TSVector2), LogicEntity target = null, AimType aimType = AimType.Default, Action<GameObject> onGetObj = null, Action<LogicEntity> onInit = null)
	{
		if (string.IsNullOrEmpty(bulletAlias))
		{
			return null;
		}
		GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(actor, bulletAlias);
		if (gameObject == null)
		{
			Debug.Log("shoot bullet Alias:" + bulletAlias + " not exit");
			bulletAlias = "Assets/AssetBundles/" + bulletAlias + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, bulletAlias, typeof(GameObject)) as GameObject;
		}
		onGetObj?.Invoke(gameObject);
		if (gameObject == null)
		{
			Debug.LogError(actor.name + "子弹资源不存在：" + bulletAlias);
			return null;
		}
		if (position == default(TSVector2))
		{
			position = actor.tsTransform.Position;
		}
		switch (aimType)
		{
		case AimType.Default:
			targetPosition = position + shootDir * range;
			break;
		case AimType.Target:
			if (target == null)
			{
				Debug.LogError("瞄准模式为'攻击目标'时，目标不能为空");
				return null;
			}
			targetPosition = target.tsTransform.Position;
			break;
		}
		ShootBehaviour shootBehaviour = actor.shootBehaviour;
		GameObject bulletPrefab = gameObject;
		TSVector2? position2 = position;
		FP? positionY2 = positionY;
		TSVector2? direction = shootDir;
		TSVector2? targetPosition2 = targetPosition;
		AimType aimType2 = aimType;
		return shootBehaviour.Shoot(bulletPrefab, position2, positionY2, direction, targetPosition2, target, useShootDeviationCalcScatteringRadius: false, default, aimType2, onInit);
	}

	public static AdventureRotateWeapon ShootRotateWepon(string bulletAlias, AdventureActor actor, AdventureActor resActor = null, TSVector2 direction = default(TSVector2))
	{
		if (string.IsNullOrEmpty(bulletAlias))
		{
			return null;
		}
		GameObject gameObject = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(resActor ?? actor, bulletAlias);
		if (gameObject == null)
		{
			Debug.Log("shoot bullet Alias:" + bulletAlias + " not exit");
			bulletAlias = "Assets/AssetBundles/" + bulletAlias + ".prefab";
			gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, bulletAlias, typeof(GameObject)) as GameObject;
		}
		if (gameObject == null)
		{
			Debug.LogError(actor.name + "子弹资源不存在：" + bulletAlias);
			return null;
		}
		gameObject.TryGetComponent<AdventureWeapon>(out var component);
		if (component != null && component.isEquipableWeapon)
		{
			return actor.EquipWeapon(gameObject, dCheck: true, direction) as AdventureRotateWeapon;
		}
		return null;
	}

	public static void FanMultipleShoot(AdventureActor actor, string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, FP angle, FP radius, FP innerRadius, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null, Action onFinish = null, bool useRef = false, FP shootOffset = default(FP))
	{
		MultipleShoot(actor, HitBox.Shape.Fan, bulletAlias, multipleShootStyle, alignShoot, alignShootDelay, bulletCount, duration, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target, angle, 0, 0, radius, innerRadius, onFinish, useRef, shootOffset);
	}

	private static void MultipleShoot(AdventureActor actor, HitBox.Shape shape, string bulletAlias, AdventureWeapon.MultipleShootStyle multipleShootStyle, bool alignShoot, FP alignShootDelay, int bulletCount, FP duration, TSVector2 shootPosition, FP shootPositionY, TSVector2 multiShootDirection, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, FP angle, FP width, FP length, FP radius, FP innerRadius, Action onFinish, bool useRef = false, FP shootOffset = default(FP))
	{
		if (!string.IsNullOrEmpty(bulletAlias) && bulletCount > 0)
		{
			GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(actor, bulletAlias);
			if (bulletByAlias == null)
			{
				Debug.LogError(actor.name + "子弹资源不存在：" + bulletAlias);
			}
			else
			{
				actor.StartLogicCoroutine(actor.shootBehaviour.MultipleShoot(shape, bulletByAlias, bulletCount, width, length, angle, radius, innerRadius, shootPosition, shootPositionY, multiShootDirection, bulletDirectionOffset, multipleShootStyle, duration, alignShoot, alignShootDelay, aimType, bulletDirectionType, targetPosition, target, onFinish, useRef, null, shootOffset));
			}
		}
	}

	public static void BeginSpecialDodge(ref SpecialDodge specialDodge, AdventureActor actor, TSVector2 direction, FP duration, FP distance, Action onComplete = null, Action onLeave = null)
	{
		if (specialDodge == null)
		{
			specialDodge = new SpecialDodge();
		}
		specialDodge.Begin(actor, direction, duration, distance, onComplete, onLeave);
	}

	public static void InterruptSpecialDodge(SpecialDodge specialDodge)
	{
		specialDodge?.Interrupte();
	}

	public static void ClearSpecialDodge(SpecialDodge specialDodge)
	{
		specialDodge?.Clear();
	}

	public static void SummonMonster(AdventureActor actor, int groupId, int monsterId, TSVector2 pos, TSVector2 dir, SummonCfg cfg = null, string summonGroupSuffix = null, Action<MonsterAdventureActor> finishCallback = null, bool useTerrainHeight = false)
	{
		if (!(actor is PlayerAdventureActor) && (ModuleController<AdventureModuleController>.Instance.isMonsterCleared || ModuleController<AdventureModuleController>.Instance.adventureLevelState == AdventureLevelState.BattleEnd))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower)
		{
			if (groupId > 0)
			{
				AdventureModuleLevelLoadParams levelLoadParams = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
				if (levelLoadParams == null)
				{
					return;
				}
				List<StarTowerMonsterBornGroup> monsterBornGroups = MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.GetMonsterBornGroups(groupId);
				if (monsterBornGroups == null || monsterBornGroups.Count == 0)
				{
					return;
				}
				int index = TSRandom.Range(0, monsterBornGroups.Count);
				int monsterId2 = monsterBornGroups.get_Item(index).MonsterId;
				monsterId = monsterId2;
			}
			Spawn(isStarTower: true);
		}
		else
		{
			Spawn(isStarTower: false);
		}
		void Spawn(bool isStarTower)
		{
			FP fP = actor.tsTransform.PositionY;
			if (useTerrainHeight)
			{
				fP = CommonHelper.GetTerrainHeight(pos, fP, out var _);
			}
			ActorSpawnInfo spawnInfo = new ActorSpawnInfo(monsterId)
			{
				position = pos,
				positionY = fP,
				rotation = dir.GetAngle(),
				summoner = actor,
				summonGroupSuffix = summonGroupSuffix,
				isRoguelikeMonster = isStarTower,
				callbackImmediately = true,
				monsterLevel = 1
			};
			if (cfg != null && cfg.maxCount > 0)
			{
				spawnInfo.maxCout = cfg.maxCount;
			}
			if (actor is MonsterAdventureActor)
			{
				MonsterSpawnerInfo logicComponent = actor.GetLogicComponent<MonsterSpawnerInfo>();
				spawnInfo.monsterLevel = logicComponent.level;
			}
			ModuleController<AdventureModuleController>.Instance.SpawnMonster(spawnInfo, (AdventureLevelObjPoolMgr.PoolObj obj, bool isRoguelikeMonster) =>
			{
				if (obj != null)
				{
					MonsterAdventureActor component = obj.gameObject.GetComponent<MonsterAdventureActor>();
					if (!(null == component))
					{
						if (!isRoguelikeMonster)
						{
							AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = AdventureMonsterSpawnedEvent.Generate();
							adventureMonsterSpawnedEvent.sender = component;
							adventureMonsterSpawnedEvent.id = component.Id;
							adventureMonsterSpawnedEvent.dataID = component.dataID;
							ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSpawnedEvent);
						}
						AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent = AdventureMonsterSummonerSpawnedEvent.Generate();
						adventureMonsterSummonerSpawnedEvent.sender = component;
						adventureMonsterSummonerSpawnedEvent.id = component.Id;
						adventureMonsterSummonerSpawnedEvent.dataId = component.dataID;
						adventureMonsterSummonerSpawnedEvent.summonerId = component.monsterSummonInfo.SummonActor.Id;
						ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSummonerSpawnedEvent);
						finishCallback?.Invoke(component);
					}
				}
			}, cfg);
		}
	}

	public static void BeginTraceTarget(ref TraceTarget traceTarget, AdventureActor actor, LogicEntity target, FP stopDistance, FP cancelDistance, FP cancelTime, Action finishCallback, Action<bool, bool, bool, bool> cancelCallback, NavAgentTypeNames.NavigationUpdateQualityLevel navigationUpdateQualityLevel = NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode movmentMode = AdventureActor.MovementMode.Run, Action leaveCallBack = null, Action updateCb = null)
	{
		if (traceTarget == null)
		{
			traceTarget = new TraceTarget();
		}
		traceTarget.BeginTrace(actor, target, stopDistance, cancelDistance, cancelTime, finishCallback, cancelCallback, navigationUpdateQualityLevel, movmentMode, leaveCallBack, updateCb);
	}

	public static void CancelTraceTarget(TraceTarget traceTarget, bool isDie = false, bool isInterrupt = false)
	{
		traceTarget?.CancelTrace(isDie, isInterrupt);
	}

	public static void ClearTraceTarget(TraceTarget traceTarget)
	{
		traceTarget?.Clear();
	}
}
