using System;
using Bamboo.ECS;

namespace ACT.Battle;

public class CompProduct : EcsComponent
{
	public Entity caster;

	public Entity productOwner;

	public Entity actionSource;

	private AbilityEntityType m_AbilityEntityType;

	public ProductLifeTimeMode productLifeTimeMode;

	public float lifeTime = -1f;

	public Action<Entity> onOutOfControl;

	public bool disengage;

	public DerivativeType derivativeType;

	public DerivativeSubType derivativeSubType;

	public AbilityEntityType AbilityEntityType
	{
		get
		{
			return m_AbilityEntityType;
		}
		set
		{
			if (m_AbilityEntityType != value)
			{
				m_AbilityEntityType = value;
				derivativeType = SystemProduct.GetDefaultDerivativeType(m_AbilityEntityType);
				derivativeSubType = SystemProduct.GetDefaultDerivativeSubType(m_AbilityEntityType);
			}
		}
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		caster = Entity.Invalid;
		productOwner = default;
		actionSource = default;
		m_AbilityEntityType = AbilityEntityType.Normal;
		lifeTime = -1f;
		productLifeTimeMode = ProductLifeTimeMode.control;
		onOutOfControl = null;
		disengage = false;
		derivativeType = DerivativeType.None;
		derivativeSubType = DerivativeSubType.None;
	}
}
