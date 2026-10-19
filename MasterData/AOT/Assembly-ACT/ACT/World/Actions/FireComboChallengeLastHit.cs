using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class FireComboChallengeLastHit : InteractAction
{
	[Tooltip("特效预制体")]
	public YooAssetReference effectReferenceAssetID;

	public Transform effectTransform;

	public Animator animator;

	public string dieStateName;

	public int stateParam;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (animator != null && !string.IsNullOrEmpty(dieStateName))
		{
			animator.Play("Die");
			animator.SetInteger(dieStateName, stateParam);
		}
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
