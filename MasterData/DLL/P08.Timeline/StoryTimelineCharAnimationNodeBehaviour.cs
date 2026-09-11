using NodeCanvas.Framework;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCharAnimationNodeBehaviour : PlayableBehaviour
{
	public CharAnimeType charAnimeType;

	public int triggerID;

	public string animationName = "stand";

	public int layer;

	public float fixedTransitionDuration = 0.1f;

	public bool useCustomPosition;

	public Vector3 customPosition;

	public string path;

	public Vector3 customRotation;

	private bool finished;

	private Animator animator;

	private BattleScene battleScene;

	public Animator GetRunTimeChar(MemberPosition position)
	{
		if (!Application.isPlaying || SceneDirector.Instance == null)
		{
			return null;
		}
		battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null)
		{
			return null;
		}
		int agentIDByMemberPosition = agentManager.GetAgentIDByMemberPosition(position);
		NAgent agent = agentManager.GetAgent(agentIDByMemberPosition);
		if (agent == null)
		{
			return null;
		}
		return agent.Animator;
	}

	public Animator GetTriggerEnemy()
	{
		if (!Application.isPlaying || SceneDirector.Instance == null)
		{
			return null;
		}
		battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		Blackboard triggerBlackboards = battleScene.GetTriggerBlackboards(triggerID);
		if (triggerBlackboards == null)
		{
			return null;
		}
		if (triggerBlackboards.variables == null || !triggerBlackboards.variables.TryGetValue("AI_ENTITY_ID", out var value))
		{
			return null;
		}
		if (!(value is Variable<int> variable))
		{
			return null;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null)
		{
			return null;
		}
		NAgent agent = agentManager.GetAgent(variable.value);
		if (agent == null)
		{
			return null;
		}
		return agent.Animator;
	}

	private Animator GetAnimator(object playerData)
	{
		Animator animator = (Animator)playerData;
		if (animator != null)
		{
			return animator;
		}
		switch (charAnimeType)
		{
		case CharAnimeType.Char1:
			animator = GetRunTimeChar(MemberPosition.First);
			break;
		case CharAnimeType.Char2:
			animator = GetRunTimeChar(MemberPosition.Second);
			break;
		case CharAnimeType.Char3:
			animator = GetRunTimeChar(MemberPosition.Third);
			break;
		case CharAnimeType.TargetTriggerEnemy:
			animator = GetTriggerEnemy();
			break;
		case CharAnimeType.TrackBind:
			animator = (Animator)playerData;
			break;
		case CharAnimeType.CreateByPath:
			if (animator == null)
			{
				GameObject gameObject = Asset.Instantiate(path);
				if (gameObject != null)
				{
					animator = gameObject.GetComponent<Animator>();
				}
			}
			break;
		}
		return animator;
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		finished = false;
		if (animator != null)
		{
			animator.applyRootMotion = false;
		}
		if (battleScene != null)
		{
			battleScene.enabled = true;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (finished)
		{
			return;
		}
		animator = GetAnimator(playerData);
		if (battleScene != null)
		{
			battleScene.enabled = false;
		}
		if (animator != null)
		{
			if (useCustomPosition)
			{
				animator.transform.position = customPosition;
				animator.transform.eulerAngles = customRotation;
			}
			animator.speed = 1f;
			animator.CrossFadeInFixedTime(animationName, fixedTransitionDuration, layer);
			animator.applyRootMotion = true;
			finished = true;
		}
	}
}
