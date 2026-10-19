using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class GeneralHitPattern : TrajectoryHitPattern
{
	public class VirtualPlane
	{
		public ConfigFunction<Vector3> originPoint;

		public ConfigFunction<Vector3> normalVector;
	}

	[Tooltip("默认都可以打到dummy，交互物生成的子弹不可以，交互物生成的子弹打到dummy不会造成完美闪避，所以需要勾选不能打到dummy")]
	public bool cantFindDummy;

	[Tooltip("OwnerEnemy保持旧逻辑，Owner可命中与子弹同阵营的目标")]
	public AllianceCondition allianceCondition;

	[Tooltip("不勾选时沿用WhereTargets的系统默认类型，保持旧配置行为；勾选后使用下方类型配置")]
	public bool useCustomFilterEntityType;

	[Tooltip("仅在启用自定义命中目标类型时生效，未勾选的Entity类型不会被子弹命中")]
	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	public ConfigAction[] onHitEntity;

	public bool useHitEntityDestroy;

	[Tooltip("负值表示只判定一次,单位为秒")]
	public float hitCd = -1f;

	[Tooltip("负值，0，1表示可以造成无限次判定")]
	public int hitCount = -1;

	[Tooltip("负值，0，1表示只判定一次")]
	public int maxHitCountPerTarget;

	public bool useHitCountZeroLifeEnd;

	public bool ignoreEnviroment;

	public ConfigAction[] onHitEnviroment;

	public ConfigAction[] onHitTagEnviroment;

	public string ignoreOnHitEnviromentTag;

	public bool useHitEnviromentDestroy;

	[Space(15f)]
	[SerializeField]
	private float ignoreEnvironmentTime;

	[Space(15f)]
	public bool rebound;

	public float reboundCoefficient = 1f;

	public float reboundThresholds = 1f;

	[Tooltip("达到最大反弹次数时碰到环境将结束生命周期。设置为-1表示无限制")]
	public int maxReboundCount = -1;

	public bool hitWallSlideDown;

	public VirtualPlane[] virtualPlanes;

	public ConfigAction[] onHitVirtualPlane;

	public bool useHitPanelDestroy;

	public bool onDieExecuteOnForceDestroy;

	private const float SlideAngle = 45f;

	public override VirtualPlane[] VirtualPlanes => virtualPlanes;

	public override bool IgnoreEnvironment(Entity bullet)
	{
		if (!ignoreEnviroment)
		{
			return bullet.GetCompTrajectory().life < ignoreEnvironmentTime;
		}
		return true;
	}

	public override WhereTargets CreateWhereTargets(Entity bullet, bool canBeAttack = false)
	{
		WhereTargets result = new WhereTargets
		{
			alliance = GameUtility.GetAlliance(allianceCondition, bullet.GetAlliance()),
			canBeAttack = canBeAttack,
			cantFindDummy = cantFindDummy
		};
		if (useCustomFilterEntityType)
		{
			result.FilterEntityType = filterEntityType;
		}
		return result;
	}

	public override void OnHitEntity(Entity bullet, FindTargetResult target, Ability ability)
	{
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		if (target.Collider != null && target.Collider.gameObject.CompareTag(BattleConsts.BULLET_DESTROY_TAG))
		{
			compTrajectory.forceDestroy = !onDieExecuteOnForceDestroy;
			compTrajectory.trajectory.SetLifeEnd(bullet);
		}
		bool flag = false;
		if ((hitCount > 0 && compTrajectory.hitCount < hitCount) || hitCount <= 0)
		{
			bullet.GetCompAbility().SetHited(target, hitCd, null, maxHitCountPerTarget);
			if (onHitEntity != null)
			{
				if (ability != null)
				{
					ability.skillLevelInfo = compTrajectory.mpSkill;
				}
				SystemAbility.DoActions(bullet.GetCompProduct().actionSource, bullet, target, null, ability, onHitEntity);
			}
			compTrajectory.hitCount++;
		}
		if ((useHitEntityDestroy && !flag) || (useHitCountZeroLifeEnd && hitCount == compTrajectory.hitCount))
		{
			compTrajectory.trajectory.SetLifeEnd(bullet);
		}
	}

	public override void OnHitEnvironment(Entity bullet, Ability ability, Collider collider, Vector3 normal)
	{
		if (string.IsNullOrEmpty(ignoreOnHitEnviromentTag) || (collider != null && !collider.CompareTag(ignoreOnHitEnviromentTag)))
		{
			SystemAbility.DoActions(bullet.GetCompProduct().actionSource, bullet, FindTargetResult.EntityOnly(bullet), null, ability, onHitEnviroment);
		}
		else if (collider != null && collider.CompareTag(ignoreOnHitEnviromentTag))
		{
			SystemAbility.DoActions(bullet.GetCompProduct().actionSource, bullet, FindTargetResult.EntityOnly(bullet), null, ability, onHitTagEnviroment);
		}
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		CompTransform compTransform = bullet.GetCompTransform();
		if (rebound && bullet.GetCompVelocity().velocity.magnitude > reboundThresholds)
		{
			if (maxReboundCount >= 0 && compTrajectory.reboundCount > maxReboundCount)
			{
				compTrajectory.trajectory.SetLifeEnd(bullet);
				return;
			}
			compVelocity.velocity = Vector3.Reflect(compVelocity.velocity, normal) * reboundCoefficient;
			compTrajectory.reboundCount++;
		}
		else if (hitWallSlideDown && (Vector3.Angle(normal, Vector3.right) < 45f || Vector3.Angle(normal, Vector3.right) > 135f) && Mathf.Abs(Vector3.Angle(normal, compVelocity.velocity) - 180f) > 0.01f)
		{
			Debug.DrawRay(compTransform.physicsPosition, normal, Color.red, 1f);
			Vector3 dir = Quaternion.AngleAxis(90f, Vector3.Cross(normal, Vector3.down)) * normal;
			Debug.DrawRay(compTransform.physicsPosition, dir, Color.green, 1f);
			compVelocity.velocity = dir.normalized * compVelocity.velocity.magnitude;
		}
		else if (useHitEnviromentDestroy)
		{
			compTrajectory.trajectory.SetLifeEnd(bullet);
		}
	}

	public override void OnHitVirtualPanel(Entity bullet, Ability ability)
	{
		SystemAbility.DoActions(bullet.GetCompProduct().actionSource, bullet, FindTargetResult.EntityOnly(bullet), null, ability, onHitVirtualPlane);
		if (useHitPanelDestroy)
		{
			bullet.GetCompTrajectory().trajectory.SetLifeEnd(bullet);
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onHitEntity, ab);
		ConfigAbility.CacheActionList(list, onHitEnviroment, ab);
	}
}
