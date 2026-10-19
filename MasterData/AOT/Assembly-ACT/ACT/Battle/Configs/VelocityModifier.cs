using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class VelocityModifier
{
	public abstract Vector3 Modify(Vector3 velocity, float dt, float lifeTime);
}
