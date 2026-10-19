using Cysharp.Threading.Tasks;

namespace ACT.LogicQueue;

public interface ILogicActionInternal
{
	int Id { get; set; }

	LogicActionState State { get; set; }

	bool CanExecute();

	bool CanInterrupt();

	UniTask Start();

	UniTask Stop();
}
