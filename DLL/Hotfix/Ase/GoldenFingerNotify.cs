using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10532)]
[MemoryPackable(GenerateType.Object)]
public class GoldenFingerNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<GoldenFingerNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GoldenFingerNotifyFormatter : MemoryPackFormatter<GoldenFingerNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GoldenFingerNotify value)
		{
			GoldenFingerNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GoldenFingerNotify value)
		{
			GoldenFingerNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long ServerOpenTime { get; set; }

	public static GoldenFingerNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GoldenFingerNotify)) as GoldenFingerNotify;
		}
		return new GoldenFingerNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			RpcId = 0;
			Error = 0;
			Message = null;
			ServerOpenTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GoldenFingerNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GoldenFingerNotify>())
		{
			MemoryPackFormatterProvider.Register(new GoldenFingerNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GoldenFingerNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GoldenFingerNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GoldenFingerNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, int>(6, value.IsFromPool, value.ServerOpenTime, value.ActorId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GoldenFingerNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ServerOpenTime;
				value4 = value.ActorId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014d;
			}
			reader.ReadUnmanaged<bool, long, long, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GoldenFingerNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ServerOpenTime;
				value4 = value.ActorId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014d;
			}
		}
		value = new GoldenFingerNotify
		{
			IsFromPool = value2,
			ServerOpenTime = value3,
			ActorId = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014d:
		value.IsFromPool = value2;
		value.ServerOpenTime = value3;
		value.ActorId = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
