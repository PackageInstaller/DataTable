using UnityEngine;

namespace T0World;

[RequireComponent(typeof(T0CharacterBlackborad))]
public class T0CharacterAgent : T0WorldAgent
{
	public T0CharacterBlackborad CharacterBoard;

	public void Awake()
	{
	}

	public override T0AgentLayer GetAgentLayer()
	{
		return T0AgentLayer.Character;
	}

	public override void Initialize()
	{
		base.Initialize();
		CharacterBoard = base.Blackboard as T0CharacterBlackborad;
	}

	public override void UpdateAgent()
	{
		base.UpdateAgent();
	}

	public bool IsHaveEvent()
	{
		return CharacterBoard.EventContext.IsHaveEvent();
	}

	public void ClearEvent()
	{
		CharacterBoard.EventContext.DisposeAllEvent();
	}

	public override void DisposeAgent()
	{
		Asset.Unload(CharacterBoard.loadResPath);
		base.DisposeAgent();
	}
}
