using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationBubbleData : T0InterationBaseData
{
	public TriggerType trigger_type = TriggerType.Talk;

	public TalkType talkType = TalkType.Exit;

	public float trigger_range;

	public bool isFollowUI;

	public Vector3 pos;

	public ClickShowType click_show_type;

	public GameObject hubObj;

	public float show_range;

	public float showAngleValueMin = -180f;

	public float showAngleValueMax = 180f;

	public Vector3 click_center;

	public float click_radius;

	public float click_height;

	public float bubbleScale = 1f;

	public bool isFollowParentRotation;

	public string waitEventKey;

	private T0InteracitonBubbleEntity entity;

	private bool isShowTalk;

	public static Dictionary<string, T0InterationBubbleData> globalWaitEvent = new Dictionary<string, T0InterationBubbleData>();

	public bool IsEntityVisible
	{
		get
		{
			if ((bool)entity)
			{
				return entity.isShowBubble;
			}
			return false;
		}
	}

	public override bool isNeedSDK => true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Hub;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		isShowTalk = false;
		if (!(hubObj == null) || click_show_type == ClickShowType.Dummy)
		{
			T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(entityID);
			GameObject gameObject;
			if ((bool)hubObj)
			{
				gameObject = UnityEngine.Object.Instantiate(hubObj, agent.transform);
			}
			else
			{
				gameObject = new GameObject("Dummy");
				gameObject.transform.SetParent(agent.transform);
			}
			entity = gameObject.GetComponent<T0InteracitonBubbleEntity>();
			if (entity == null)
			{
				entity = gameObject.AddComponent<T0InteracitonBubbleEntity>();
			}
			entity.Init(this);
			if (!string.IsNullOrEmpty(waitEventKey))
			{
				globalWaitEvent[waitEventKey] = this;
			}
		}
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		bool isProcess = T0WorldScene.Scene.interactionManager.InteractContext.CheckIsCanProcess(this);
		entity?.Tick(isProcess);
		UpdateTalkShow(behaviour, isProcess);
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		if (!string.IsNullOrEmpty(waitEventKey))
		{
			globalWaitEvent.Remove(waitEventKey);
		}
	}

	public override void DisposeEvent()
	{
		entity?.Dispose();
		RemoveTalkBubble();
	}

	private void RemoveTalkBubble()
	{
		if (T0WorldScene.Scene.mWorldUI != null && T0WorldScene.Scene.mWorldUI.bubblePool != null)
		{
			isShowTalk = false;
			T0WorldScene.Scene.mWorldUI.bubblePool.RemoveBubbleEntity(this);
		}
	}

	public void UpdateTalkShow(T0WorldInteractionBehavior behaviour, bool isProcess = true)
	{
		if (trigger_type != TriggerType.Talk || T0WorldScene.Scene.mWorldUI == null)
		{
			return;
		}
		bool num = isShowTalk;
		isShowTalk = false;
		if (isProcess && Vector3.Distance(T0WorldScene.Scene.player.transform.position, behaviour.transform.position) <= trigger_range)
		{
			Vector3 vector = behaviour.transform.position - T0WorldScene.Scene.player.transform.position;
			vector.y = 0f;
			float num2 = 0f;
			if (vector != Vector3.zero)
			{
				num2 = Vector3.SignedAngle(T0WorldScene.Scene.player.transform.forward, vector, Vector3.up);
			}
			if (num2 >= showAngleValueMin && num2 <= showAngleValueMax)
			{
				isShowTalk = true;
			}
		}
		if (num != isShowTalk)
		{
			if (isShowTalk)
			{
				T0WorldScene.Scene.mWorldUI.bubblePool.RegisterBubbleEntity(this);
			}
			else
			{
				T0WorldScene.Scene.mWorldUI.bubblePool.RemoveBubbleEntity(this);
			}
		}
	}
}
