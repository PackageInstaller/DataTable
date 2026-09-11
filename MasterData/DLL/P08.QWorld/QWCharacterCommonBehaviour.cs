using System;
using System.Collections.Generic;
using P08.QWorld.Misc;
using UnityEngine;

public class QWCharacterCommonBehaviour : QWAgentBehaviour
{
	private const string BasePath = "QWWorld/Chars/Player/";

	private QWLocomotionBehaviour locomotion;

	private QWCharacterBlackboard characterBlackboard;

	public Dictionary<int, QWCharacterProxy> chars;

	public float birdsInfluenceStrength = 1f;

	public float birdsInfluenceInterval = 0.5f;

	private float timer;

	public override void Initialize()
	{
		base.Initialize();
		QWBlackboard blackboard = base.mAgent.Blackboard;
		blackboard.ActionHandler = (QWBlackboard.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new QWBlackboard.AgentActionHandler(OnCommonAction));
	}

	private void OnCommonAction(QWAgentAction action)
	{
		if (action.Type == QWAgentAction.E_Type.ChangeCharacter)
		{
			ChangeCharacter(action as QWChangeCharacterAction);
		}
	}

	public void InitialCharacter(int actorId, QWCharacterBlackboard blackboard, QWAgent agent)
	{
		locomotion = GetComponent<QWLocomotionBehaviour>();
		characterBlackboard = blackboard;
		chars = new Dictionary<int, QWCharacterProxy>();
		QWCharacterProxy component = UnityEngine.Object.Instantiate(Asset.Load("QWWorld/Chars/Player/" + actorId) as GameObject, base.transform).GetComponent<QWCharacterProxy>();
		component.smrs = component.gameObject.GetComponentsInChildren<SkinnedMeshRenderer>();
		component.charId = actorId;
		chars.Add(actorId, component);
		characterBlackboard.curProxy = component;
		component.EnterActive();
		component.animatorMoveDelgate = locomotion.OnAnimatorMove;
		component.agent = agent;
	}

	private void ChangeCharacter(QWChangeCharacterAction action)
	{
		int charId = action.charId;
		QWCharacterProxy qWCharacterProxy = null;
		bool flag = false;
		if (action.isLoad)
		{
			if (charId == characterBlackboard.curProxy.charId)
			{
				return;
			}
			if (chars.TryGetValue(charId, out var value))
			{
				qWCharacterProxy = characterBlackboard.curProxy;
				characterBlackboard.curProxy = value;
				value.EnterActive();
				flag = true;
			}
			else
			{
				qWCharacterProxy = characterBlackboard.curProxy;
				GameObject gameObject = Asset.Load("QWWorld/Chars/Player/" + charId) as GameObject;
				if ((bool)gameObject)
				{
					QWCharacterProxy component = UnityEngine.Object.Instantiate(gameObject, base.transform).GetComponent<QWCharacterProxy>();
					component.smrs = component.gameObject.GetComponentsInChildren<SkinnedMeshRenderer>();
					component.charId = charId;
					chars.Add(charId, component);
					characterBlackboard.curProxy = component;
					component.animatorMoveDelgate = locomotion.OnAnimatorMove;
					component.EnterActive();
					flag = true;
				}
				else
				{
					Debug.LogError("不存在的主控角色: " + charId);
				}
			}
		}
		if (flag)
		{
			QWPostChangeCharacterAction action2 = QWAgentActionFactory.Create(QWAgentAction.E_Type.PostChangeCharacter) as QWPostChangeCharacterAction;
			base.mAgent.Blackboard.ActionAdd(action2);
			if (action.isLoad)
			{
				qWCharacterProxy?.BackWait();
			}
		}
	}

	public override void UpdateBehavior()
	{
		base.UpdateBehavior();
		if (timer <= 0f)
		{
			QWorldBroadcastPosMsg.Emit(base.transform.position, 4f, delegate(QWorldBirdsOnGround birds)
			{
				birds.BroadcastActiveToBirdsEntity(base.transform.position, birdsInfluenceStrength);
			});
			timer = birdsInfluenceInterval;
		}
		timer -= Time.deltaTime;
	}
}
