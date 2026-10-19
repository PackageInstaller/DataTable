using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class AddAbilityToInteracter : InteractAction
{
	[Tooltip("添加的技能")]
	public string[] abilities;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		behave.GetCompAbility().AddAbilities(abilities, AbilitySource.Ability);
		return UniTask.CompletedTask;
	}
}
