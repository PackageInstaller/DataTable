using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Model;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Battle;

public class TriggerObjectEntry
{
	public TriggerType triggerType = TriggerType.triggerEnter;

	public TriggerObjectFilter filter = TriggerObjectFilter.character;

	public List<TriggerActionBase> triggerActions = new List<TriggerActionBase>();

	public async UniTaskVoid OnTriggerEnter(TriggerActionContext context, TriggerObject triggerObject)
	{
		if (context.HasEntity && MonoECS.instance.PlayerControlType == MonoECS.ControlType.OreCar)
		{
			return;
		}
		bool flag = (triggerType & TriggerType.triggerEnter) != 0;
		if (!flag && context.HasEntity)
		{
			CompMotion compMotion = context.Entity.GetCompMotion();
			flag = ((triggerType & TriggerType.jumpEnter) != 0 && compMotion.curMotionState == MotionState.Jump) || ((triggerType & TriggerType.DodgeEnter) != 0 && compMotion.curMotionState == MotionState.Dodge);
		}
		if (!flag || !Filter(context))
		{
			return;
		}
		foreach (TriggerActionBase triggerAction in triggerActions)
		{
			await triggerAction.Invoke(context, triggerObject.Token);
		}
	}

	public async UniTaskVoid OnTriggerStay(TriggerActionContext context, TriggerObject triggerObject)
	{
		if ((triggerType & TriggerType.triggerStay) == 0 || !Filter(context))
		{
			return;
		}
		foreach (TriggerActionBase triggerAction in triggerActions)
		{
			await triggerAction.Invoke(context, triggerObject.Token);
		}
	}

	public async UniTaskVoid OnTriggerExit(TriggerActionContext context, TriggerObject triggerObject)
	{
		if ((triggerType & TriggerType.triggerExit) == 0 || !Filter(context))
		{
			return;
		}
		foreach (TriggerActionBase triggerAction in triggerActions)
		{
			await triggerAction.Invoke(context, triggerObject.Token);
		}
	}

	public async UniTask OnAttack(Entity entityReference, TriggerObject triggerObject)
	{
		TriggerActionContext context = new TriggerActionContext(entityReference, null, null);
		if ((triggerType & TriggerType.attack) == 0 || !Filter(context))
		{
			return;
		}
		int areaId = Singleton<GameManager>.instance.worldManager.ActiveChunk.AreaId;
		Singleton<AchievementSyncBattleTypeManager>.instance.DispatchDestroyMapItemsCount(areaId);
		foreach (TriggerActionBase triggerAction in triggerActions)
		{
			await triggerAction.Invoke(context, triggerObject.Token);
		}
	}

	private bool Filter(TriggerActionContext context)
	{
		if (context.HasEntity)
		{
			EntityType entityType = context.Entity.GetEntityType();
			if ((filter & TriggerObjectFilter.character) != 0 && entityType == EntityType.Character)
			{
				return true;
			}
			if ((filter & TriggerObjectFilter.enemy) != 0 && (entityType == EntityType.Boss || entityType == EntityType.Elite || entityType == EntityType.Monster))
			{
				return true;
			}
		}
		if ((filter & TriggerObjectFilter.freeObject) != 0)
		{
			return context.TargetObject != null;
		}
		return false;
	}
}
