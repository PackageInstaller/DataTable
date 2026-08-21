using System;

namespace T0World;

[Serializable]
public class T0InterationSetPlayerCollisionState : T0InterationFunctionDataBase
{
	public bool isOpenCollisionTest = true;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0WorldScene.Scene.player.enableCollisionTest = isOpenCollisionTest;
		SetCharacterCollisionTestColliderState(isOpenCollisionTest);
		base.IsFinish = true;
	}

	private void SetCharacterCollisionTestColliderState(bool show)
	{
		foreach (T0WorldAgent agent in T0WorldScene.Scene.agentManager.agents)
		{
			if (agent is T0CharacterAgent t0CharacterAgent)
			{
				t0CharacterAgent.CharacterBoard.SetCollisionTestColliderState(show);
			}
		}
	}
}
