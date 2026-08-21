using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class TriggerAreaNode : BaseMapDataNode, IMathTriggerEventHandler
{
	public string m_TriggerDesc;

	private List<BaseTrigger> triggerList = new List<BaseTrigger>();

	[SerializeField]
	private GameObject heroEnter;

	public override bool DisplayNode => false;

	public override bool UsedOcTree => false;

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		BaseTrigger[] componentsInChildren = ((Component)(object)this).transform.GetComponentsInChildren<BaseTrigger>();
		triggerList.Clear();
		BaseTrigger[] array = componentsInChildren;
		foreach (BaseTrigger baseTrigger in array)
		{
			baseTrigger.OnInit(data);
			triggerList.Add(baseTrigger);
		}
	}

	public override void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		base.OnReceiveMapDataEvent(eventType, otherEntity);
		foreach (BaseTrigger trigger in triggerList)
		{
			trigger.OnReceiveMapDataEvent(eventType, otherEntity);
		}
	}

	private void UpdateItemName()
	{
		((Object)(object)this).name = "触发器区域 -  " + m_TriggerDesc;
	}

	public override void OnDisposed()
	{
		foreach (BaseTrigger trigger in triggerList)
		{
			trigger.OnDispose();
		}
	}

	public void OnMathTriggerEnter(MathTriggerEventData eventData)
	{
		if (!base.TaskConditionResult)
		{
			if (SubscriptionTask && eventData.Other.TryGetComponent<HeroView>(out var component) && component.Entity.IsActorEntity)
			{
				heroEnter = eventData.Other;
			}
		}
		else
		{
			TriggerExcute(eventData.Other, AreaTriggerType.Enter);
		}
	}

	public void OnMathTriggerExit(MathTriggerEventData eventData)
	{
		if (SubscriptionTask && eventData.Other.TryGetComponent<HeroView>(out var component) && component.Entity.IsActorEntity)
		{
			heroEnter = null;
		}
		if (base.TaskConditionResult)
		{
			TriggerExcute(eventData.Other, AreaTriggerType.Exit);
		}
	}

	public void OnMathTriggerStay(MathTriggerEventData eventData)
	{
	}

	public void TriggerExcute(GameObject collider, AreaTriggerType areaTriggerType)
	{
		HeroTrigger(collider, areaTriggerType);
	}

	public void HeroTrigger(GameObject other, AreaTriggerType areaTriggerType)
	{
		if (!other.TryGetComponent<HeroView>(out var component) || !component.Entity.IsActorEntity)
		{
			return;
		}
		foreach (BaseTrigger trigger in triggerList)
		{
			trigger.OnTrigger(areaTriggerType, component.Entity);
		}
	}

	protected override void OnTaskConditionChanged()
	{
		base.OnTaskConditionChanged();
		if (heroEnter != null && base.TaskConditionResult)
		{
			TriggerExcute(heroEnter, AreaTriggerType.Enter);
		}
	}
}
