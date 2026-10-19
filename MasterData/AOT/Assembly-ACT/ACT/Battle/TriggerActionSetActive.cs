using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionSetActive : TriggerActionBase
{
	public GameObject gameObject;

	public bool active = true;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (gameObject != null)
		{
			gameObject.SetActive(active);
		}
		return UniTask.CompletedTask;
	}
}
