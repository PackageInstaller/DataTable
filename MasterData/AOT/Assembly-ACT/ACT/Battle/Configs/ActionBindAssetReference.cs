using System.Collections.Generic;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("绑定Asset引用", "Action", new string[] { "bind", "asset", "reference" })]
public class ActionBindAssetReference : ConfigAction
{
	[Tooltip("子弹prefab要有粒子系统")]
	public YooAssetReference assetReferenceAssetID;

	public bool useExtraAssetReferenceByFaceDir;

	public bool useAssetReferenceColliders;

	public YooAssetReference assetReferenceLeftAssetID;

	public override void Do(ActionMemory memory)
	{
		AsyncBindAssetReference(memory).Forget();
	}

	private async UniTaskVoid AsyncBindAssetReference(ActionMemory memory)
	{
		YooAssetReference effectRef = assetReferenceAssetID;
		YooAssetReference effectRef2 = assetReferenceLeftAssetID;
		ActionFireEffect.RemapEffectReferences(memory, ref effectRef, ref effectRef2);
		if (useExtraAssetReferenceByFaceDir && memory.caster.IsFaceLeft())
		{
			MonoECS.instance.AsyncReplaceAbilityEntityPrefab(memory.target.entity, effectRef2);
			return;
		}
		await MonoECS.instance.AsyncReplaceAbilityEntityPrefab(memory.target.entity, effectRef);
		if (useAssetReferenceColliders)
		{
			Transform transform = memory.target.entity.GetModelTrans().Find("ColliderRoot");
			if ((bool)transform)
			{
				Collider[] componentsInChildren = transform.GetComponentsInChildren<Collider>();
				memory.target.entity.GetCompTrajectory().customColliders = componentsInChildren;
			}
		}
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
		addlist.Add(assetReferenceAssetID);
		addlist.Add(assetReferenceLeftAssetID);
	}
}
