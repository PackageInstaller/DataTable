using System;

namespace Cysharp.Threading.Tasks;

public abstract class ChannelWriter<T>
{
	public abstract bool TryWrite(T item);

	public abstract bool TryComplete(Exception error = null);

	public void Complete(Exception error = null)
	{
		if (!TryComplete(error))
		{
			throw new ChannelClosedException();
		}
	}
}
