using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionDestroy : TriggerActionBase
{
	public GameObject gameObject;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		Object.Destroy(gameObject);
		return UniTask.CompletedTask;
	}
}
