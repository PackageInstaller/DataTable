using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.Battle;

public abstract class TriggerActionBase
{
	public abstract UniTask Invoke(TriggerActionContext context, CancellationToken token);
}
