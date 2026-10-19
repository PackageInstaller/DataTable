using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class AidRecover : InteractAction
{
	public float percent;

	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		CompAbility compAbility = behave.GetCompAbility();
		compAbility.ServerSetHP(compAbility.hp + Mathf.CeilToInt((float)compAbility.maxHP * percent));
		return UniTask.CompletedTask;
	}
}
