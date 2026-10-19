using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public interface IQuestContext
{
	bool ContainsScope(string scopeId);

	UniTask BeginScope(IScope scope, object options, CancellationToken token);

	UniTask EndScope(string scopeId, object options, CancellationToken token);

	UniTask EndAllScope(CancellationToken token);
}
