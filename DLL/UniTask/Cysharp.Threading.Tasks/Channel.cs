namespace Cysharp.Threading.Tasks;

public static class Channel
{
	public static Channel<T> CreateSingleConsumerUnbounded<T>()
	{
		return new SingleConsumerUnboundedChannel<T>();
	}
}
public abstract class Channel<TWrite, TRead>
{
	public ChannelReader<TRead> Reader { get; protected set; }

	public ChannelWriter<TWrite> Writer { get; protected set; }

	public static implicit operator ChannelReader<TRead>(Channel<TWrite, TRead> channel)
	{
		return channel.Reader;
	}

	public static implicit operator ChannelWriter<TWrite>(Channel<TWrite, TRead> channel)
	{
		return channel.Writer;
	}
}
public abstract class Channel<T> : Channel<T, T>
{
}
