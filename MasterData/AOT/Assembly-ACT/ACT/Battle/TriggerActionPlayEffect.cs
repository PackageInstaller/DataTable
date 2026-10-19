using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionPlayEffect : TriggerActionBase
{
	public YooAssetReference effectReferenceAssetID;

	public Transform pos;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		GameManager.effectSystem.FireEffect(effectReferenceAssetID, pos.position, pos.rotation);
		return UniTask.CompletedTask;
	}
}
