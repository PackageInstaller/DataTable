using System;
using System.Collections.Generic;
using ACT.World.Actions;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.StateObject;

[Serializable]
public class InteractActionList
{
	private StateObjectBase stateObjectBase;

	public List<InteractAction> interactActions = new List<InteractAction>();

	public void BindInteractObject(StateObjectBase stateObjectBase)
	{
		this.stateObjectBase = stateObjectBase;
		for (int i = 0; i < interactActions.Count; i++)
		{
			if (interactActions[i] != null)
			{
				interactActions[i].BindInteractObject(stateObjectBase);
			}
		}
	}

	public async UniTask TryInteract(Entity behave, InteractAction.InteractSource interactSource)
	{
		for (int i = 0; i < interactActions.Count; i++)
		{
			if (interactActions[i] != null)
			{
				await interactActions[i].TryInteract(behave);
			}
		}
	}
}
