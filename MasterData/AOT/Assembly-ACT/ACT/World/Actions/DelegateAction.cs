using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

[Obsolete]
public class DelegateAction : InteractAction
{
	public Action delegateAction;

	protected override AbilityAuth auth
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		return UniTask.CompletedTask;
	}
}
