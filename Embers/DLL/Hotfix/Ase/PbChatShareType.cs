using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(428)]
[MemoryPackable(GenerateType.Object)]
public class PbChatShareType : MessageObject, IMemoryPackable<PbChatShareType>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbChatShareTypeFormatter : MemoryPackFormatter<PbChatShareType>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbChatShareType value)
		{
			PbChatShareType.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbChatShareType value)
		{
			PbChatShareType.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public long SelectId { get; set; }

	public static PbChatShareType Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbChatShareType)) as PbChatShareType;
		}
		return new PbChatShareType();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			SelectId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbChatShareType()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbChatShareType>())
		{
			MemoryPackFormatterProvider.Register(new PbChatShareTypeFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbChatShareType[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbChatShareType>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbChatShareType? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.Type, value.SelectId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbChatShareType? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.SelectId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbChatShareType), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.SelectId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new PbChatShareType
		{
			IsFromPool = value2,
			Type = value3,
			SelectId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.Type = value3;
		value.SelectId = value4;
	}
}
