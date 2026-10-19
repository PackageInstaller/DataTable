using System;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("操作派生类型", "Action", new string[] { "operate", "derivative", "type" })]
public class ActionOperateDerivativeType : ConfigAction
{
	[Serializable]
	private enum SubType
	{
		DerivativeType,
		DerivativeSubType
	}

	[Serializable]
	private enum Target
	{
		Target,
		OwnerProduct,
		Player
	}

	[SerializeField]
	private Target m_Target;

	[SerializeField]
	private SubType m_SubType;

	public bool isAttach;

	public bool isCheckSource;

	public DerivativeType sourceDerivativeType;

	public DerivativeType targetDerivativeType;

	public DerivativeSubType sourceDerivativeSubType;

	public DerivativeSubType targetDerivativeSubType;

	public override void Do(ActionMemory memory)
	{
		switch (m_Target)
		{
		case Target.Target:
			ProcessTarget(memory);
			break;
		case Target.OwnerProduct:
			ProcessOwner(memory);
			break;
		case Target.Player:
			ProcessPlayer(memory);
			break;
		}
	}

	private void ProcessTarget(ActionMemory memory)
	{
		if (m_SubType == SubType.DerivativeType)
		{
			if (memory.target.IsValid)
			{
				Entity entity = memory.target.entity;
				if (isCheckSource || entity.GetCompProduct().derivativeType.HasFlag(sourceDerivativeType))
				{
					SystemProduct.EntityOperateDerivativeType(entity, targetDerivativeType, isAttach);
				}
			}
		}
		else if (memory.target.IsValid)
		{
			Entity entity2 = memory.target.entity;
			if (isCheckSource || entity2.GetCompProduct().derivativeSubType.HasFlag(sourceDerivativeSubType))
			{
				SystemProduct.EntityOperateDerivativeSubType(entity2, targetDerivativeSubType, isAttach);
			}
		}
	}

	private void ProcessOwner(ActionMemory memory)
	{
		if (m_SubType == SubType.DerivativeType)
		{
			Singleton<GameManager>.instance.ecsManager.systemProduct.OperateDerivativeTypeForProduct((Entity eb) =>
			{
				CompProduct compProduct = eb.GetCompProduct();
				if (compProduct != null)
				{
					Entity caster = compProduct.caster;
					if (caster.IsValid && caster.Equals(memory.owner))
					{
						if (isCheckSource)
						{
							return compProduct.derivativeType.HasFlag(sourceDerivativeType);
						}
						return true;
					}
				}
				return false;
			}, targetDerivativeType, isAttach);
			return;
		}
		Singleton<GameManager>.instance.ecsManager.systemProduct.OperateDerivativeSubTypeForProducts((Entity eb) =>
		{
			CompProduct compProduct = eb.GetCompProduct();
			if (compProduct != null)
			{
				Entity caster = compProduct.caster;
				if (caster.IsValid && caster.Equals(memory.owner))
				{
					if (isCheckSource)
					{
						return compProduct.derivativeSubType.HasFlag(sourceDerivativeSubType);
					}
					return true;
				}
			}
			return false;
		}, targetDerivativeSubType, isAttach);
	}

	private void ProcessPlayer(ActionMemory memory)
	{
		if (m_SubType == SubType.DerivativeType)
		{
			Singleton<GameManager>.instance.ecsManager.systemProduct.OperateDerivativeTypeForProduct((Entity eb) =>
			{
				CompProduct compProduct = eb.GetCompProduct();
				if (compProduct != null)
				{
					Entity caster = compProduct.caster;
					if (caster.IsValid && caster.IsCharacter())
					{
						if (isCheckSource)
						{
							return compProduct.derivativeType.HasFlag(sourceDerivativeType);
						}
						return true;
					}
				}
				return false;
			}, targetDerivativeType, isAttach);
			return;
		}
		Singleton<GameManager>.instance.ecsManager.systemProduct.OperateDerivativeSubTypeForProducts((Entity eb) =>
		{
			CompProduct compProduct = eb.GetCompProduct();
			if (compProduct != null)
			{
				Entity caster = compProduct.caster;
				if (caster.IsValid && caster.IsCharacter())
				{
					if (isCheckSource)
					{
						return compProduct.derivativeSubType.HasFlag(sourceDerivativeSubType);
					}
					return true;
				}
			}
			return false;
		}, targetDerivativeSubType, isAttach);
	}
}
