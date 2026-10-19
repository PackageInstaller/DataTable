using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class CompositeMoveBase
{
	protected Vector3 m_Position;

	protected Quaternion m_Rotation;

	protected Entity m_Bullet;

	protected Ability m_Ability;

	protected RuntimeGeneralTrajectory m_GeneralTrajectory;

	public Vector3 Position => m_Position;

	public Quaternion Rotation => m_Rotation;

	public void Create(Entity bullet, Ability ability, RuntimeGeneralTrajectory generalTrajectory)
	{
		m_Bullet = bullet;
		m_Ability = ability;
		m_GeneralTrajectory = generalTrajectory;
		m_Position = Vector3.zero;
		m_Rotation = Quaternion.identity;
		RuntimeGeneralTrajectory(bullet, ability, generalTrajectory);
	}

	protected abstract void RuntimeGeneralTrajectory(Entity bullet, Ability ability, RuntimeGeneralTrajectory generalTrajectory);

	public abstract void FixedUpdate(float deltaTime);

	protected ActionMemory ActionMemory()
	{
		CompProduct compProduct = m_Bullet.GetCompProduct();
		return new ActionMemory(compProduct.caster, compProduct.productOwner, m_Bullet, null, m_Ability);
	}
}
