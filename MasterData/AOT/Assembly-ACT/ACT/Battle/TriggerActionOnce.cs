using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.Battle;

public class TriggerActionOnce : TriggerActionBase
{
	public TriggerActionBase[] actions;

	private bool triggered;

	public override async UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (!triggered)
		{
			TriggerActionBase[] array = actions;
			for (int i = 0; i < array.Length; i++)
			{
				await array[i].Invoke(context, token);
			}
		}
		triggered = true;
	}
}
