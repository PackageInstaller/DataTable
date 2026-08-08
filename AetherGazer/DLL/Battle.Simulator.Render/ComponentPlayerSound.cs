using System;

public class ComponentPlayerSound : CMonoBehaviour
{
	private BBHumanoid mCharacter;

	private CriAtomSource mAtomSource;

	public override void Initialize()
	{
		base.Initialize();
		mCharacter = mAgent.Blackboard as BBHumanoid;
		BBCommom blackboard = mAgent.Blackboard;
		blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new BBCommom.AgentActionHandler(handleAction));
		mAtomSource = base.gameObject.AddComponent<CriAtomSource>();
	}

	public void Play(string name, string cueName)
	{
		mAtomSource.cueSheet = name;
		mAtomSource.cueName = cueName;
		mAtomSource.Play();
	}

	public void Stop()
	{
		mAtomSource.Stop();
	}

	private void handleAction(AgentAction action)
	{
		_ = action is AgentActionDead;
		if (action is AgentActionHurt)
		{
			_ = (action as AgentActionHurt).damageType;
			_ = 2;
		}
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		BBCommom blackboard = mAgent.Blackboard;
		blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(blackboard.ActionHandler, new BBCommom.AgentActionHandler(handleAction));
	}
}
