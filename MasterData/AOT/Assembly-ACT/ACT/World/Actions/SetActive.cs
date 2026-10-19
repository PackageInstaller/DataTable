using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.Actions;

public class SetActive : InteractAction
{
	[FormerlySerializedAs("gameObject")]
	public GameObject target;

	public bool active;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		target.SetActive(active);
		return UniTask.CompletedTask;
	}
}
