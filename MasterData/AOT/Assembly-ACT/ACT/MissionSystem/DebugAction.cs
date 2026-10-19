using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.MissionSystem;

public class DebugAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		Debug.Log((Param as DebugActionParam)?.content);
		return UniTask.CompletedTask;
	}
}
