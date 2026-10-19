using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class Log : InteractAction
{
	public string logText;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(behave.GetRoot().name + "->" + stateObjectBase.gameObject.name + ":" + logText);
		}
		return UniTask.CompletedTask;
	}
}
