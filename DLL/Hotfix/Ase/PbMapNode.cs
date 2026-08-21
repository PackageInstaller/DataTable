using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(413)]
[MemoryPackable(GenerateType.Object)]
public class PbMapNode : MessageObject, IMemoryPackable<PbMapNode>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMapNodeFormatter : MemoryPackFormatter<PbMapNode>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMapNode value)
		{
			PbMapNode.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMapNode value)
		{
			PbMapNode.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int MapId { get; set; }

	[MemoryPackOrder(1)]
	public long MiWuId { get; set; }

	[MemoryPackOrder(2)]
	public List<long> HuoWenIdList { get; set; } = new List<long>();

	[MemoryPackOrder(3)]
	public List<int> BoxIdList { get; set; } = new List<int>();

	public static PbMapNode Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMapNode)) as PbMapNode;
		}
		return new PbMapNode();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			MapId = 0;
			MiWuId = 0L;
			HuoWenIdList.Clear();
			BoxIdList.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMapNode()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMapNode>())
		{
			MemoryPackFormatterProvider.Register(new PbMapNodeFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMapNode[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMapNode>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMapNode? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(5, value.IsFromPool, value.MapId, value.MiWuId);
		writer.WriteValue<List<long>>(value.HuoWenIdList);
		writer.WriteValue<List<int>>(value.BoxIdList);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMapNode? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		List<long> value5;
		List<int> value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MapId;
				value4 = value.MiWuId;
				value5 = value.HuoWenIdList;
				value6 = value.BoxIdList;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadValue(ref value5);
				reader.ReadValue(ref value6);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			value5 = reader.ReadValue<List<long>>();
			value6 = reader.ReadValue<List<int>>();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMapNode), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = null;
				value6 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MapId;
				value4 = value.MiWuId;
				value5 = value.HuoWenIdList;
				value6 = value.BoxIdList;
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
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
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
		value = new PbMapNode
		{
			IsFromPool = value2,
			MapId = value3,
			MiWuId = value4,
			HuoWenIdList = value5,
			BoxIdList = value6
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.MapId = value3;
		value.MiWuId = value4;
		value.HuoWenIdList = value5;
		value.BoxIdList = value6;
	}
}
