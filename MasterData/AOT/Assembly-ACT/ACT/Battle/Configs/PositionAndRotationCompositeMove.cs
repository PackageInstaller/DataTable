using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class PositionAndRotationCompositeMove : CompositeMoveBase
{
	private PositionAndRotationConfigCompositeMove m_PositionAndRotationConfig;

	public PositionAndRotationCompositeMove(PositionAndRotationConfigCompositeMove positionAndRotationConfig)
	{
		m_PositionAndRotationConfig = positionAndRotationConfig;
	}

	protected override void RuntimeGeneralTrajectory(Entity bullet, Ability ability, RuntimeGeneralTrajectory generalTrajectory)
	{
		CompProduct compProduct = m_Bullet.GetCompProduct();
		m_Position = m_PositionAndRotationConfig.position.Return(new ActionMemory(compProduct.caster, compProduct.productOwner, m_Bullet, null, m_Ability));
		m_Rotation = m_PositionAndRotationConfig.rotation.Return(new ActionMemory(compProduct.caster, compProduct.productOwner, m_Bullet, null, m_Ability));
	}

	public override void FixedUpdate(float deltaTime)
	{
	}
}
