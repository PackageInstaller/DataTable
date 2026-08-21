using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10026)]
[MemoryPackable(GenerateType.Object)]
public class S2C_Global_GameStart : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<S2C_Global_GameStart>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_Global_GameStartFormatter : MemoryPackFormatter<S2C_Global_GameStart>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_Global_GameStart value)
		{
			S2C_Global_GameStart.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_Global_GameStart value)
		{
			S2C_Global_GameStart.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	public static S2C_Global_GameStart Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_Global_GameStart)) as S2C_Global_GameStart;
		}
		return new S2C_Global_GameStart();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ActorId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_Global_GameStart()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_Global_GameStart>())
		{
			MemoryPackFormatterProvider.Register(new S2C_Global_GameStartFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_Global_GameStart[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_Global_GameStart>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_Global_GameStart? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(5, value.IsFromPool, value.RpcId, value.Error);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_Global_GameStart? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				message = reader.ReadString();
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			message = reader.ReadString();
			reader.ReadUnmanaged<long>(out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_Global_GameStart), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				message = null;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							message = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0124;
			}
		}
		value = new S2C_Global_GameStart
		{
			IsFromPool = value2,
			RpcId = value3,
			Error = value4,
			Message = message,
			ActorId = value5
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.RpcId = value3;
		value.Error = value4;
		value.Message = message;
		value.ActorId = value5;
	}
}
