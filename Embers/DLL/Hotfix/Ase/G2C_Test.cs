using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5013)]
[MemoryPackable(GenerateType.Object)]
public class G2C_Test : MessageObject, IMessage, IMemoryPackable<G2C_Test>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2C_TestFormatter : MemoryPackFormatter<G2C_Test>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2C_Test value)
		{
			G2C_Test.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2C_Test value)
		{
			G2C_Test.Deserialize(ref reader, ref value);
		}
	}

	public static G2C_Test Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2C_Test)) as G2C_Test;
		}
		return new G2C_Test();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2C_Test()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_Test>())
		{
			MemoryPackFormatterProvider.Register(new G2C_TestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_Test[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2C_Test>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2C_Test? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool>(1, value.IsFromPool);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2C_Test? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		if (memberCount == 1)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				reader.ReadUnmanaged<bool>(out value2);
				goto IL_006b;
			}
			reader.ReadUnmanaged<bool>(out value2);
		}
		else
		{
			if (memberCount > 1)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2C_Test), 1, memberCount);
				return;
			}
			value2 = value != null && value.IsFromPool;
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				_ = 1;
			}
			if (value != null)
			{
				goto IL_006b;
			}
		}
		value = new G2C_Test
		{
			IsFromPool = value2
		};
		return;
		IL_006b:
		value.IsFromPool = value2;
	}
}
