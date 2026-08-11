using System.Diagnostics;
using Ase.ECS;
using NodeCanvas.Framework;

namespace Ase;

public class ConditionTaskBase : ConditionTask
{
	protected BaseEntity ownerEntity;

	protected bool IsLogicTree()
	{
		if (ownerEntity.LogicType != EntityLogicType.Logic)
		{
			return ownerEntity.LogicType == EntityLogicType.None;
		}
		return true;
	}

	protected override bool OnCheck()
	{
		Reset();
		ownerEntity = GetOwnerEntity();
		if (ownerEntity == null)
		{
			return false;
		}
		return base.OnCheck();
	}

	private void Reset()
	{
		ownerEntity = null;
		OnClear();
	}

	protected BaseEntity GetOwnerEntity()
	{
		if (ownerEntity == null || ownerEntity.Id == 0)
		{
			BaseEntity baseEntity = base.blackboard.GetVariable<BaseEntity>("BaseEntity")?.value;
			if (baseEntity == null)
			{
				return null;
			}
			ownerEntity = baseEntity;
		}
		return ownerEntity;
	}

	protected BaseEntity GetEntity(int entityId, bool isSyncEntity)
	{
		return ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId);
	}

	protected bool EntityAndTreeConsistency(int entityId, out BaseEntity baseEntity)
	{
		baseEntity = GetEntity(entityId, isSyncEntity: false);
		if (baseEntity == null)
		{
			return false;
		}
		if (baseEntity.LogicType == EntityLogicType.None)
		{
			return true;
		}
		return baseEntity.LogicType == ownerEntity.LogicType;
	}

	protected virtual void OnClear()
	{
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	protected void LogActionError(string content)
	{
	}
}
