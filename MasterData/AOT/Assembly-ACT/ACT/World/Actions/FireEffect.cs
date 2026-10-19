using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class FireEffect : InteractAction
{
	[Tooltip("特效预制体")]
	public YooAssetReference effectReferenceAssetID;

	public Transform effectTransform;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (effectTransform != null)
		{
			GameManager.effectSystem.FireEffect(effectReferenceAssetID, effectTransform.position, effectTransform.rotation);
		}
		else
		{
			GameManager.effectSystem.FireEffect(effectReferenceAssetID, behave.GetModelTrans().position, Quaternion.identity);
		}
		return UniTask.CompletedTask;
	}
}
