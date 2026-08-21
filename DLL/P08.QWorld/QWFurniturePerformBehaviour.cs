using System;
using System.Collections.Generic;
using UnityEngine;

public class QWFurniturePerformBehaviour : QWAgentBehaviour
{
	private QWFurnitureBlackboard bb;

	private Dictionary<string, string> effects;

	private Dictionary<string, GameObject> effectInst;

	private Dictionary<string, string> targetEffects;

	private Dictionary<string, GameObject> targetEffectInst;

	private Dictionary<Transform, QWFurnitureAttachComponent> attachHost;

	private Dictionary<Transform, QWFurnitureAttachComponent> grabAttachHost;

	public override void Initialize()
	{
		base.Initialize();
		bb = base.mAgent.Blackboard as QWFurnitureBlackboard;
		QWBlackboard blackboard = base.mAgent.Blackboard;
		blackboard.ActionHandler = (QWBlackboard.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new QWBlackboard.AgentActionHandler(OnCommonAction));
	}

	private void OnCommonAction(QWAgentAction a)
	{
		switch (a.Type)
		{
		case QWAgentAction.E_Type.Furniture_PlayEffect:
		{
			QWFurniturePlayEffectAction ctx = a as QWFurniturePlayEffectAction;
			PlayEffect(ctx);
			break;
		}
		case QWAgentAction.E_Type.Furniture_AttachTo:
		{
			QWFurnitureAttachToAction action = a as QWFurnitureAttachToAction;
			AttachTo(action);
			break;
		}
		case QWAgentAction.E_Type.Furniture_Enter:
		{
			QWFurnitureEnterAction action4 = a as QWFurnitureEnterAction;
			OnFurnitureEnter(action4);
			break;
		}
		case QWAgentAction.E_Type.Furniture_GrabItem:
		{
			QWFurnitureGrabItemAction action3 = a as QWFurnitureGrabItemAction;
			OnFurnitureGrab(action3);
			break;
		}
		case QWAgentAction.E_Type.Furniture_Visible:
		{
			QWFurnitureVisibleAction action2 = a as QWFurnitureVisibleAction;
			OnFurnitureVisible(action2);
			break;
		}
		case QWAgentAction.E_Type.RemoveFromStage:
			if ((bool)bb && bb.inInteract)
			{
				OnRemoveFromStage();
			}
			break;
		}
	}

	private void PlayEffect(QWFurniturePlayEffectAction ctx)
	{
		if (!base.mAgent.Blackboard.isInStage || QWPerformManager.Instance == null)
		{
			return;
		}
		if (ctx.target == 1)
		{
			if (effects == null)
			{
				effects = new Dictionary<string, string>();
			}
			if (effectInst == null)
			{
				effectInst = new Dictionary<string, GameObject>();
			}
		}
		else
		{
			if (targetEffects == null)
			{
				targetEffects = new Dictionary<string, string>();
			}
			if (targetEffectInst == null)
			{
				targetEffectInst = new Dictionary<string, GameObject>();
			}
		}
		string value7;
		if (ctx.playEffect)
		{
			if (ctx.target == 1)
			{
				if (effects.TryGetValue(ctx.attachPoint, out var value))
				{
					QWPerformManager.Instance.GetEffectController().RemoveEffect(value);
					if (effectInst.TryGetValue(value, out var value2) && (bool)value2)
					{
						UnityEngine.Object.DestroyImmediate(value2);
					}
					effects.Remove(ctx.attachPoint);
					effectInst.Remove(value);
				}
				Transform furnitureAttachPoint = bb.GetFurnitureAttachPoint(ctx.attachPoint);
				if (furnitureAttachPoint == null)
				{
					furnitureAttachPoint = bb.transform;
				}
				GameObject gameObject = QWPerformManager.Instance.GetEffectController().InstantiateEffect(ctx.efxPath, furnitureAttachPoint);
				gameObject.transform.localPosition = ctx.offset;
				gameObject.transform.localRotation = ctx.rotation;
				gameObject.transform.localScale = ctx.scale;
				effects.Add(ctx.attachPoint, ctx.efxPath);
				effectInst.TryAdd(ctx.efxPath, gameObject);
				return;
			}
			QWCharacterBlackboard characterBlackboard = QWorldScene.Scene.Agent.CharacterBlackboard;
			if (targetEffects.TryGetValue(ctx.attachPoint, out var value3))
			{
				QWPerformManager.Instance.GetEffectController().RemoveEffect(value3);
				if (targetEffectInst.TryGetValue(value3, out var value4) && (bool)value4)
				{
					UnityEngine.Object.DestroyImmediate(value4);
				}
				targetEffects.Remove(ctx.attachPoint);
				targetEffectInst.Remove(value3);
			}
			Transform transform = characterBlackboard.FindAttachPoint(ctx.attachPoint);
			if (transform == null)
			{
				transform = characterBlackboard.transform;
			}
			GameObject gameObject2 = QWPerformManager.Instance.GetEffectController().InstantiateEffect(ctx.efxPath, transform);
			gameObject2.transform.localPosition = ctx.offset;
			gameObject2.transform.localRotation = ctx.rotation;
			gameObject2.transform.localScale = ctx.scale;
			targetEffects.Add(ctx.attachPoint, ctx.efxPath);
			targetEffectInst.TryAdd(ctx.efxPath, gameObject2);
		}
		else if (ctx.target == 1)
		{
			if (effects.TryGetValue(ctx.attachPoint, out var value5))
			{
				QWPerformManager.Instance.GetEffectController().RemoveEffect(value5);
				effects.Remove(ctx.attachPoint);
				if (effectInst.TryGetValue(value5, out var value6) && (bool)value6)
				{
					UnityEngine.Object.DestroyImmediate(value6);
				}
				effectInst.Remove(value5);
			}
		}
		else if (targetEffects.TryGetValue(ctx.attachPoint, out value7))
		{
			QWPerformManager.Instance.GetEffectController().RemoveEffect(value7);
			targetEffects.Remove(ctx.attachPoint);
			if (targetEffectInst.TryGetValue(value7, out var value8) && (bool)value8)
			{
				UnityEngine.Object.DestroyImmediate(value8);
			}
			targetEffectInst.Remove(value7);
		}
	}

	private void AttachTo(QWFurnitureAttachToAction action)
	{
		if (attachHost == null)
		{
			attachHost = new Dictionary<Transform, QWFurnitureAttachComponent>();
		}
		if (action.acquireAgent.GetAgentLayer() == QWAgentLayer.Player)
		{
			QWCharacterAgent qWCharacterAgent = action.acquireAgent as QWCharacterAgent;
			if (attachHost.TryGetValue(qWCharacterAgent.transform, out var value))
			{
				value.host = bb.GetFurnitureAttachPoint(action.attachPoint);
				value.client = qWCharacterAgent.transform;
				return;
			}
			value = new QWFurnitureAttachComponent();
			value.host = bb.GetFurnitureAttachPoint(action.attachPoint);
			value.client = qWCharacterAgent.transform;
			attachHost.Add(qWCharacterAgent.transform, value);
		}
	}

	private void OnFurnitureGrab(QWFurnitureGrabItemAction action)
	{
		if (grabAttachHost == null)
		{
			grabAttachHost = new Dictionary<Transform, QWFurnitureAttachComponent>();
		}
		if (action.target.GetAgentLayer() != QWAgentLayer.Player)
		{
			return;
		}
		QWCharacterAgent qWCharacterAgent = action.target as QWCharacterAgent;
		Transform transform = bb.FindItem(action.itemPart);
		if ((bool)transform)
		{
			Transform host = qWCharacterAgent.CharacterBlackboard.FindAttachPoint(action.attachPoint);
			if (grabAttachHost.TryGetValue(transform, out var value))
			{
				value.host = host;
				value.client = transform;
				return;
			}
			value = new QWFurnitureAttachComponent();
			value.host = host;
			value.client = transform;
			grabAttachHost.Add(transform, value);
		}
	}

	private void OnFurnitureEnter(QWFurnitureEnterAction action)
	{
		if (action.isEnter)
		{
			return;
		}
		QWAgent target = action.target;
		if (attachHost != null && attachHost.ContainsKey(target.transform))
		{
			attachHost.Remove(target.transform);
		}
		if (grabAttachHost != null)
		{
			foreach (KeyValuePair<Transform, QWFurnitureAttachComponent> item in grabAttachHost)
			{
				item.Value.client.localPosition = Vector3.zero;
				item.Value.client.localRotation = Quaternion.identity;
				item.Value.client.localScale = Vector3.one;
			}
			grabAttachHost = null;
		}
		if (effectInst != null)
		{
			foreach (KeyValuePair<string, GameObject> item2 in effectInst)
			{
				QWPerformManager.Instance.GetEffectController().RemoveEffect(item2.Key);
				UnityEngine.Object.DestroyImmediate(item2.Value);
			}
			effects.Clear();
			effectInst.Clear();
		}
		if (targetEffectInst == null)
		{
			return;
		}
		foreach (KeyValuePair<string, GameObject> item3 in targetEffectInst)
		{
			QWPerformManager.Instance.GetEffectController().RemoveEffect(item3.Key);
			UnityEngine.Object.DestroyImmediate(item3.Value);
		}
		targetEffects.Clear();
		targetEffectInst.Clear();
	}

	private void OnFurnitureVisible(QWFurnitureVisibleAction action)
	{
		if (action.target == 1)
		{
			MeshRenderer[] componentsInChildren = base.gameObject.GetComponentsInChildren<MeshRenderer>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].SetActive(action.visible);
			}
		}
	}

	public override void LateUpdateBehavior()
	{
		if (attachHost != null)
		{
			foreach (KeyValuePair<Transform, QWFurnitureAttachComponent> item in attachHost)
			{
				if (item.Key != null)
				{
					item.Value.Tick();
				}
			}
		}
		if (grabAttachHost == null)
		{
			return;
		}
		foreach (KeyValuePair<Transform, QWFurnitureAttachComponent> item2 in grabAttachHost)
		{
			if (item2.Key != null)
			{
				item2.Value.Tick();
			}
		}
	}

	private void OnRemoveFromStage()
	{
		LuaHelper.CallFunction("ForceStopAllPerformTask");
		QWPerformManager.Instance.EndFurniturInteract(QWPerformManager.Instance.GetPlayerInteractTarget, resetStatus: false);
	}

	public override void DestroyBehavior()
	{
		base.DestroyBehavior();
		if (effects == null || QWPerformManager.Instance == null)
		{
			return;
		}
		foreach (KeyValuePair<string, string> effect in effects)
		{
			QWPerformManager.Instance.GetEffectController().RemoveEffect(effect.Value);
		}
		effects.Clear();
	}
}
