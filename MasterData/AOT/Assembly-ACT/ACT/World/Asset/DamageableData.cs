using System;
using System.Threading;
using ACT.Config;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class DamageableData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	public string damageableAddress;

	[Tooltip("每个阶段可攻击次数")]
	public int[] attacksList;

	[Tooltip("是否保留最后阶段")]
	public bool lastKeep;

	public override YooAssetReference addressAssetID => GameLoader.meta.damageableReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override (StateWorldAsset, UniTask) OnLoad(CancellationToken syncInit)
	{
		(DamageableAsset, UniTask) tuple = StateWorldAsset.Load<DamageableAsset>(this, syncInit);
		return (tuple.Item1, tuple.Item2);
	}

	public override void OnRelease()
	{
		StateWorldAsset.Release<DamageableAsset>(this);
	}
}
