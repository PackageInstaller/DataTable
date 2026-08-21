using System.Runtime.InteropServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

[StructLayout(LayoutKind.Auto)]
public readonly struct UniTaskCancelableAsyncEnumerable<T>
{
	[StructLayout(LayoutKind.Auto)]
	public readonly struct Enumerator
	{
		private readonly IUniTaskAsyncEnumerator<T> enumerator;

		public T Current => enumerator.Current;

		internal Enumerator(IUniTaskAsyncEnumerator<T> enumerator)
		{
			this.enumerator = enumerator;
		}

		public UniTask<bool> MoveNextAsync()
		{
			return enumerator.MoveNextAsync();
		}

		public UniTask DisposeAsync()
		{
			return enumerator.DisposeAsync();
		}
	}

	private readonly IUniTaskAsyncEnumerable<T> enumerable;

	private readonly CancellationToken cancellationToken;

	internal UniTaskCancelableAsyncEnumerable(IUniTaskAsyncEnumerable<T> enumerable, CancellationToken cancellationToken)
	{
		this.enumerable = enumerable;
		this.cancellationToken = cancellationToken;
	}

	public Enumerator GetAsyncEnumerator()
	{
		return new Enumerator(enumerable.GetAsyncEnumerator(cancellationToken));
	}
}
