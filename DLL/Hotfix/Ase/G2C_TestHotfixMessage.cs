using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10045)]
[MemoryPackable(GenerateType.Object)]
public class G2C_TestHotfixMessage : MessageObject, IMessage, IMemoryPackable<G2C_TestHotfixMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2C_TestHotfixMessageFormatter : MemoryPackFormatter<G2C_TestHotfixMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2C_TestHotfixMessage value)
		{
			G2C_TestHotfixMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2C_TestHotfixMessage value)
		{
			G2C_TestHotfixMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public string Info { get; set; }

	public static G2C_TestHotfixMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2C_TestHotfixMessage)) as G2C_TestHotfixMessage;
		}
		return new G2C_TestHotfixMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Info = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2C_TestHotfixMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_TestHotfixMessage>())
		{
			MemoryPackFormatterProvider.Register(new G2C_TestHotfixMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_TestHotfixMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2C_TestHotfixMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2C_TestHotfixMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(2, value.IsFromPool);
		writer.WriteString(value.Info);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2C_TestHotfixMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		string info;
		if (memberCount == 2)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				info = value.Info;
				reader.ReadUnmanaged<bool>(out value2);
				info = reader.ReadString();
				goto IL_0099;
			}
			reader.ReadUnmanaged<bool>(out value2);
			info = reader.ReadString();
		}
		else
		{
			if (memberCount > 2)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2C_TestHotfixMessage), 2, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				info = null;
			}
			else
			{
				value2 = value.IsFromPool;
				info = value.Info;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					info = reader.ReadString();
					_ = 2;
				}
			}
			if (value != null)
			{
				goto IL_0099;
			}
		}
		value = new G2C_TestHotfixMessage
		{
			IsFromPool = value2,
			Info = info
		};
		return;
		IL_0099:
		value.IsFromPool = value2;
		value.Info = info;
	}
}
