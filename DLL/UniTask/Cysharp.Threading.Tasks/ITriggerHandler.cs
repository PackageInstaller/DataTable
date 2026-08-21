using System;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public interface ITriggerHandler<T>
{
	ITriggerHandler<T> Prev { get; set; }

	ITriggerHandler<T> Next { get; set; }

	void OnNext(T value);

	void OnError(Exception ex);

	void OnCompleted();

	void OnCanceled(CancellationToken cancellationToken);
}
