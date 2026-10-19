using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class RemoveAbility : InteractAction
{
	[Tooltip("移除的技能")]
	public string[] abilitiyName;

	public bool removeAllAbility;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (removeAllAbility)
		{
			stateObjectBase.entity.GetCompAbility().ClearTimeAbility();
		}
		else
		{
			CompAbility compAbility = stateObjectBase.entity.GetCompAbility();
			for (int i = 0; i < abilitiyName.Length; i++)
			{
				compAbility.RemoveAbility(abilitiyName[i]);
			}
		}
		return UniTask.CompletedTask;
	}
}
