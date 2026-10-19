using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public interface IScope
{
	string ScopeId { get; }

	UniTask Enter(object options, CancellationToken token);

	UniTask Exit(object options, CancellationToken token);
}
