using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class TrajectoryMovementPattern
{
	public enum BulletInitVelocityType
	{
		customVelocity,
		inheritBeforeVelocity
	}

	public enum BulletInitMoveDirType
	{
		casterDir,
		ownerDIr,
		customDir,
		inheritBeforeVelocityDir,
		dammakuSetDir
	}

	public enum EffectDirType
	{
		velocityDefine,
		effectDir,
		customDir
	}

	public BulletInitVelocityType bulletInitVelocityType;

	public ConfigFunction<float> configFunctionBulletVelocity = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 10f
		}
	};

	public BulletInitMoveDirType bulletInitMoveDirType;

	public ConfigFunction<Vector3> configFunctionBulletDir;

	public EffectDirType effectDirType;

	public VelocityModifier velocityModifier;

	public VelocityModifier[] velocityModify;

	public abstract TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability);

	public virtual void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}
}
