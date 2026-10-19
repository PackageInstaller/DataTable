using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class PredicateInteractAction : InteractAction
{
	public ConfigPredicateList predicateList;

	public InteractActionList onTrue = new InteractActionList();

	public InteractActionList onFalse = new InteractActionList();

	protected override AbilityAuth auth => AbilityAuth.Both;

	public override IEnumerator<InteractActionList> GetEnumerator()
	{
		yield return onTrue;
		yield return onFalse;
	}

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		List<InteractAction> interactActions = (predicateList.Check(new ActionMemory(behave, behave, behave)) ? onTrue : onFalse).interactActions;
		if (interactActions != null)
		{
			foreach (InteractAction item in interactActions)
			{
				item.TryInteract(behave);
			}
		}
		return UniTask.CompletedTask;
	}
}
