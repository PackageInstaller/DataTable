using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class ParallelQuestContext : IQuestContext
{
	public static readonly ParallelQuestContext Instance = new ParallelQuestContext();

	public bool ContainsScope(string scopeId)
	{
		return false;
	}

	public UniTask BeginScope(IScope scope, object options, CancellationToken token)
	{
		return UniTask.CompletedTask;
	}

	public UniTask EndScope(string scopeId, object options, CancellationToken token)
	{
		return UniTask.CompletedTask;
	}

	public UniTask EndAllScope(CancellationToken token)
	{
		return UniTask.CompletedTask;
	}
}
