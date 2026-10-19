using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.Drama;

public interface IDialogueWrapper
{
	bool IsPlaying();

	UniTask Play(CancellationToken token);

	void Skip();

	void Stop();

	void TryNext();
}
