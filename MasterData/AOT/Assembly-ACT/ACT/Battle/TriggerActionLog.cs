using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionLog : TriggerActionBase
{
	public string log;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(log);
		}
		return UniTask.CompletedTask;
	}
}
