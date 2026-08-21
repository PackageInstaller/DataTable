using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(424)]
[MemoryPackable(GenerateType.Object)]
public class UnionEventInfo : MessageObject, IMemoryPackable<UnionEventInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionEventInfoFormatter : MemoryPackFormatter<UnionEventInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionEventInfo value)
		{
			UnionEventInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionEventInfo value)
		{
			UnionEventInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public List<string> Params { get; set; } = new List<string>();

	public static UnionEventInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionEventInfo)) as UnionEventInfo;
		}
		return new UnionEventInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			Params.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionEventInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionEventInfo>())
		{
			MemoryPackFormatterProvider.Register(new UnionEventInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionEventInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionEventInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionEventInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.Type);
		writer.WriteValue<List<string>>(value.Params);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionEventInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<string> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Params;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadValue(ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadValue<List<string>>();
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionEventInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.Params;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c3;
			}
		}
		value = new UnionEventInfo
		{
			IsFromPool = value2,
			Type = value3,
			Params = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.Type = value3;
		value.Params = value4;
	}
}
