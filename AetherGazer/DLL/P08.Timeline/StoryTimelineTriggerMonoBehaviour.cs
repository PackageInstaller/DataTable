using UnityEngine;

public class StoryTimelineTriggerMonoBehaviour : MonoBehaviour
{
	public float range;

	public StoryTimelineTriggerNodeBehaviour node;

	private bool start;

	public void StartUpdate()
	{
		start = true;
	}

	private bool GetPlayerPos(out Vector3 pos)
	{
		pos = Vector3.zero;
		if (SceneDirector.Instance == null)
		{
			return false;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return false;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return false;
		}
		AgentManager agentManager = battleScene.GetAgentManager();
		if (agentManager == null)
		{
			return false;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		if (playerAgent == null)
		{
			return false;
		}
		pos = playerAgent.transform.position;
		return true;
	}

	private void Update()
	{
		if (start && GetPlayerPos(out var pos) && (pos - base.transform.position).sqrMagnitude <= range * range)
		{
			node.Finish();
			start = false;
		}
	}
}
