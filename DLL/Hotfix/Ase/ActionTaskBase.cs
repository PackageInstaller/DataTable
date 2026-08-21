using System.Diagnostics;
using Ase.ECS;
using NodeCanvas.Framework;

namespace Ase;

public abstract class ActionTaskBase : ActionTask
{
	protected BaseEntity ownerEntity;

	protected virtual bool IsDisplayNode => false;

	protected override void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity();
		if (ownerEntity == null)
		{
			EndAction(success: false);
		}
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
		return ownerEntity.GetSystem<EntitySystem>()?.GetEntity(entityId);
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

	protected void OnActionEnd(bool result)
	{
		EndAction(result);
	}

	protected void OnActionFail()
	{
		EndAction(success: true);
	}

	protected void OnActionFail(string failMsg)
	{
		EndAction(success: true);
	}

	protected void OnActionFinish()
	{
		EndAction(success: true);
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_ERROR_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	[Conditional("ENABLE_ERROR_AND_ABOVE_LOG")]
	protected void LogActionError(string content)
	{
	}
}
