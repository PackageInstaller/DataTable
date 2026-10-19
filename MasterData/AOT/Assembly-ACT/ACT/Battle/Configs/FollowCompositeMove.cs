using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class FollowCompositeMove : CompositeMoveBase
{
	private FollowConfigCompositeMove m_FollowConfig;

	public FollowCompositeMove(FollowConfigCompositeMove followConfig)
	{
		m_FollowConfig = followConfig;
	}

	protected override void RuntimeGeneralTrajectory(Entity bullet, Ability ability, RuntimeGeneralTrajectory generalTrajectory)
	{
	}

	public override void FixedUpdate(float deltaTime)
	{
		CompProduct compProduct = m_Bullet.GetCompProduct();
		m_Position = (m_FollowConfig.followPosition ? m_FollowConfig.position.Return(new ActionMemory(compProduct.caster, m_Bullet, m_Bullet, null, m_Ability)) : Vector3.zero);
		m_Rotation = (m_FollowConfig.followRotation ? m_FollowConfig.rotation.Return(new ActionMemory(compProduct.caster, m_Bullet, m_Bullet, null, m_Ability)) : Quaternion.identity);
	}
}
