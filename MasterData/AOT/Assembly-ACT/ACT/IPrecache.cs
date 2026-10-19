using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT;

public interface IPrecache
{
	UniTask CollectPrecacheAsync(PrecacheCollector collector, CancellationToken ct = default(CancellationToken));
}
