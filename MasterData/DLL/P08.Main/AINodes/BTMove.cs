using System;
using System.Threading.Tasks;
using BilliardGame.Spell;
using T0World;
using UnityEngine;

namespace AINodes;

public class BTMove : BActionNode
{
	[NonSerialized]
	private BTNodeStatus status;

	public string sourceName = "Self";

	public string targetName = "Target";

	private T0CharacterBehaviorAI aiBehaviour;

	public const float MOVE_NAV_DEAD_ZONE = 1.5f;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (!BNode.CheckRequiredParamsFromEnv(env, sourceName, targetName))
		{
			return BTNodeStatus.Failure;
		}
		if (status == BTNodeStatus.Inactive)
		{
			T0WorldScene.Scene.interactionManager.InteractContext.ClearFocusEvent();
			T0WorldScene.Scene.agentManager.CharacteraAgent.ClearEvent();
			status = BTNodeStatus.Running;
			StartMove(env);
		}
		return status;
	}

	private async void StartMove(BTEnv env)
	{
		GameObject gameObject = env.GetObject<GameObject>(sourceName);
		aiBehaviour = gameObject.GetComponent<T0CharacterBehaviorAI>();
		Transform transform = env.GetObject<Transform>(targetName);
		aiBehaviour.moveAnimBrain.navigatingDeadZone = 1.5f;
		aiBehaviour.moveAnimBrain.SetNavigationDestination(transform);
		aiBehaviour.OpenMove(isMove: true);
		PlayerMoveAnimBrain moveBrain = aiBehaviour.moveAnimBrain;
		do
		{
			await Task.Yield();
		}
		while (moveBrain.IsAINavigatingMove || moveBrain.moveState != PlayerMoveAnimBrain.MoveState.Idle);
		OnMoveEnd();
	}

	private void OnMoveEnd()
	{
		status = BTNodeStatus.Success;
	}

	public override void OnEnd(BTEnv env)
	{
		aiBehaviour.OpenMove(isMove: false);
		base.OnEnd(env);
		status = BTNodeStatus.Inactive;
	}
}
