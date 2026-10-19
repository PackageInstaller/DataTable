using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/RecoverDropItemBehaveEvent")]
public class RecoverDropItemBehaveEvent : DropItemBehaveEvents
{
	public YooAssetReference effectReferenceAssetID;

	public override void OnCollected(Entity eb = default(Entity))
	{
		CompAbility compAbility = eb.GetCompAbility();
		compAbility.ServerSetHP(compAbility.hp + Mathf.CeilToInt((float)(compAbility.maxHP * interactDropItem.dropItemData.Count) * 0.01f));
		if (effectReferenceAssetID.RuntimeKeyIsValid())
		{
			GameManager.effectSystem.FireEffect(effectReferenceAssetID, eb.GetModelTrans().position, Quaternion.identity);
		}
		base.OnCollected(eb);
	}
}
