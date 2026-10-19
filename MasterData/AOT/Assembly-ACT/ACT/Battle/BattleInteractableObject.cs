using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[ExecuteInEditMode]
[AddComponentMenu("4战斗相关组件/信息点")]
public class BattleInteractableObject : MonoBehaviour
{
	[Flags]
	public enum BattleInteractableObjectExtraFunctionType
	{
		FireEffect = 2,
		UseAnimator = 4,
		SendEventToBT = 8,
		DoAction = 0x10
	}

	public BattleInteractableObjectExtraFunctionType battleInteractableObjectExtraFunctionType;

	[Header("信息点相关")]
	public int[] contextTypes;

	public BTActionNode btActionNode;

	private List<Entity> doActionEntityBehaves;

	public string btEventNameEnterTrigger;

	public string btEventNameExitTrigger;

	public List<Entity> sendEventToBTEntityBehaves;

	[Header("暂时废弃的内容")]
	public int id;

	[Range(0f, 1f)]
	public float percent;

	public YooAssetReference assetReferenceAssetID;

	public Transform effectTransform;

	public Animator animator;

	public bool ShowDoAction()
	{
		return battleInteractableObjectExtraFunctionType.HasFlag(BattleInteractableObjectExtraFunctionType.DoAction);
	}

	public bool ShowSendEventToBT()
	{
		return battleInteractableObjectExtraFunctionType.HasFlag(BattleInteractableObjectExtraFunctionType.SendEventToBT);
	}

	private void Init()
	{
		if (effectTransform == null)
		{
			effectTransform = transform;
		}
		if (animator == null && GetComponentInChildren<Animator>() != null)
		{
			animator = GetComponentInChildren<Animator>();
		}
	}

	private void Start()
	{
		doActionEntityBehaves = new List<Entity>();
		sendEventToBTEntityBehaves = new List<Entity>();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SkillInteract, OnSkillInteract);
		Init();
		MonoECS.instance?.aiContextManager?.Register(this);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SkillInteract, OnSkillInteract);
		MonoECS.instance?.aiContextManager?.UnRegister(this);
	}

	private void OnSkillInteract(BaseEventContent obj)
	{
		SkillInteractEvt skillInteractEvt = (SkillInteractEvt)obj;
		if (skillInteractEvt.id != id)
		{
			return;
		}
		switch (skillInteractEvt.interactEventType)
		{
		case SendInteractEventType.needSendPara2Animator:
			switch (skillInteractEvt.animatorPataType)
			{
			case ConfigAnimParameterType.Int:
				animator.SetInteger(skillInteractEvt.animatorPara, skillInteractEvt.intvalue);
				break;
			case ConfigAnimParameterType.Float:
				animator.SetFloat(skillInteractEvt.animatorPara, skillInteractEvt.floatvalue);
				break;
			case ConfigAnimParameterType.Bool:
				animator.SetBool(skillInteractEvt.animatorPara, skillInteractEvt.boolValue);
				break;
			case ConfigAnimParameterType.Trigger:
				animator.SetTrigger(skillInteractEvt.animatorPara);
				break;
			}
			break;
		case SendInteractEventType.FireEffect:
			GameManager.effectSystem.FireEffect(assetReferenceAssetID, effectTransform.position, effectTransform.rotation);
			break;
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!component || !component.entity.IsBehaveAvailable())
		{
			return;
		}
		if (!doActionEntityBehaves.Contains(component.entity) && battleInteractableObjectExtraFunctionType.HasFlag(BattleInteractableObjectExtraFunctionType.DoAction))
		{
			ActionMemory memory = new ActionMemory(component.entity, component.entity, component.entity);
			ConfigAction[] configActions = btActionNode.configActions;
			for (int i = 0; i < configActions.Length; i++)
			{
				configActions[i].CheckDo(memory);
			}
			doActionEntityBehaves.Add(component.entity);
		}
		if (!sendEventToBTEntityBehaves.Contains(component.entity) && battleInteractableObjectExtraFunctionType.HasFlag(BattleInteractableObjectExtraFunctionType.SendEventToBT))
		{
			component.btree.SendEvent(btEventNameEnterTrigger);
			sendEventToBTEntityBehaves.Add(component.entity);
		}
	}

	private void OnTriggerStay(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!component)
		{
			return;
		}
		if (!doActionEntityBehaves.Contains(component.entity) && battleInteractableObjectExtraFunctionType.HasFlag(BattleInteractableObjectExtraFunctionType.DoAction))
		{
			ActionMemory memory = new ActionMemory(component.entity, component.entity, component.entity);
			ConfigAction[] configActions = btActionNode.configActions;
			for (int i = 0; i < configActions.Length; i++)
			{
				configActions[i].CheckDo(memory);
			}
			doActionEntityBehaves.Add(component.entity);
		}
		if (!sendEventToBTEntityBehaves.Contains(component.entity) && battleInteractableObjectExtraFunctionType.HasFlag(BattleInteractableObjectExtraFunctionType.SendEventToBT))
		{
			component.btree.SendEvent(btEventNameEnterTrigger);
			sendEventToBTEntityBehaves.Add(component.entity);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if ((bool)component)
		{
			if (!component.entity.IsBehaveAvailable())
			{
				sendEventToBTEntityBehaves.Remove(component.entity);
				doActionEntityBehaves.Remove(component.entity);
			}
			else if (doActionEntityBehaves.Contains(component.entity) && battleInteractableObjectExtraFunctionType.HasFlag(BattleInteractableObjectExtraFunctionType.DoAction))
			{
				component.btree?.SendEvent(btEventNameExitTrigger);
				sendEventToBTEntityBehaves.Remove(component.entity);
				doActionEntityBehaves.Remove(component.entity);
			}
		}
	}
}
