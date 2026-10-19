using System;
using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Creat自适应实体", "Action", new string[] { "creat", "flexible", "entity", "state", "status", "tag" })]
public class ActionCreatFlexibleEntity : ConfigAction
{
	public Shape shape;

	[Tooltip("对于子弹来说，他就是Collider，只有X有意义,Y可以不填")]
	public Vector2 size;

	public Vector3 boxSize;

	[Tooltip("子弹的攻击盒与生成位置的偏移量")]
	public Vector3 offest;

	[Tooltip("命中的环境Collider所在GameObject使用该Unity Tag时，完全跳过该碰撞；为空时不过滤")]
	public string ignoreEnvironmentCollisionTag;

	[Tooltip("子弹不同的类型会有不同的额外功能")]
	public AbilityEntityType type;

	public TrajectoryTag tag;

	[HideInInspector]
	[Obsolete]
	public bool ignoreEnviroment = true;

	public bool checkEnvAndResolve;

	[Tooltip("子弹能受击就必须要有血量")]
	public int hp;

	[Tooltip("子弹ui")]
	public bool showUI = true;

	public bool cantBeAttack;

	public FilterEntityType beHitFilter = GameUtility.defaultFilterEntityType;

	public bool destroyOtherBulletOnBeHit;

	public ConfigFunction<Vector3> aimPos;

	public BulletAimRotationType aimRotationType;

	public ConfigFunction<Vector3> aimRotation;

	public ConfigFunction<Quaternion> customRotation;

	public ConfigTrajectory trajectory = new GeneralTrajectory
	{
		hitPattern = new GeneralHitPattern(),
		lifePattern = new GeneralLifePattern()
	};

	public ConfigTrajectoryObject configTrajectoryObject;

	public TrajectoryMovementPattern movementPattern;

	[NonSerialized]
	public UnityAction<Entity> onCreate;

	private const float OverlapThreshold = 0.05f;

	private const float VelocityOverlapDistance = 0.5f;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		trajectory?.CacheActionList(list, ab);
		configTrajectoryObject?.configTrajectory?.CacheActionList(list, ab);
		movementPattern?.CacheActionList(list, ab);
	}

	public override void Do(ActionMemory memory)
	{
		Vector3 vector = aimPos.Return(memory);
		quaternion identity = quaternion.identity;
		identity = aimRotationType switch
		{
			BulletAimRotationType.bytargetPos => (quaternion)((aimRotation == null) ? memory.target.entity.GetFaceRotation() : Quaternion.LookRotation(aimRotation.Return(memory) - vector)), 
			BulletAimRotationType.byCustomRotation => (customRotation == null) ? quaternion.identity : ((quaternion)customRotation.Return(memory)), 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		MonoECS.instance.SpawnFlexibleEntity(GetParams(vector, identity), memory.target.entity, memory.ability);
	}

	public MonoECS.FlexibleParams GetParams(Vector3 pos, Quaternion rot)
	{
		UnityAction<Entity> unityAction = null;
		UnityAction<Entity> userOnCreate = onCreate;
		unityAction = (Entity entity) =>
		{
			userOnCreate?.Invoke(entity);
			if (shape == Shape.CustomPart)
			{
				GameObject root = entity.GetRoot();
				if ((object)root != null)
				{
					MonoCustomBulletCollider monoCustomBulletCollider = root.GetComponent<MonoCustomBulletCollider>();
					if (monoCustomBulletCollider == null)
					{
						monoCustomBulletCollider = root.GetComponentInChildren<MonoCustomBulletCollider>();
					}
					monoCustomBulletCollider.ownerEntity = entity;
					if (monoCustomBulletCollider.myCollider == null)
					{
						monoCustomBulletCollider.myCollider = root.GetComponent<Collider>();
						if (monoCustomBulletCollider.myCollider == null)
						{
							monoCustomBulletCollider.myCollider = root.GetComponentInChildren<Collider>();
						}
					}
					if (monoCustomBulletCollider.myCollider != null)
					{
						monoCustomBulletCollider.myCollider.isTrigger = true;
					}
				}
			}
		};
		return new MonoECS.FlexibleParams
		{
			shape = shape,
			size = size,
			boxSize = boxSize,
			offest = offest,
			type = type,
			tag = tag,
			ignoreEnvironmentCollisionTag = ignoreEnvironmentCollisionTag,
			checkEnvAndResolve = checkEnvAndResolve,
			hp = hp,
			showUI = showUI,
			cantBeAttack = cantBeAttack,
			beHitFilter = beHitFilter,
			destroyOtherBulletOnBeHit = destroyOtherBulletOnBeHit,
			aimPos = pos,
			aimRotation = rot,
			trajectory = trajectory,
			configTrajectoryObject = configTrajectoryObject,
			movementPattern = movementPattern,
			OverlapThreshold = 0.05f,
			VelocityOverlapDistance = 0.5f,
			onCreate = unityAction
		};
	}
}
