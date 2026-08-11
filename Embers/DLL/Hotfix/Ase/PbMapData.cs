using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5004)]
[MemoryPackable(GenerateType.Object)]
public class PbMapData : MessageObject, IMemoryPackable<PbMapData>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMapDataFormatter : MemoryPackFormatter<PbMapData>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMapData value)
		{
			PbMapData.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMapData value)
		{
			PbMapData.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public string Key { get; set; }

	[MemoryPackOrder(2)]
	public string Data { get; set; }

	public static PbMapData Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMapData)) as PbMapData;
		}
		return new PbMapData();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			Key = null;
			Data = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMapData()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMapData>())
		{
			MemoryPackFormatterProvider.Register(new PbMapDataFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMapData[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMapData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMapData? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(4, value.IsFromPool, value.Type);
		writer.WriteString(value.Key);
		writer.WriteString(value.Data);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMapData? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		string key;
		string data;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				key = value.Key;
				data = value.Data;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				key = reader.ReadString();
				data = reader.ReadString();
				goto IL_00f2;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			key = reader.ReadString();
			data = reader.ReadString();
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMapData), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				key = null;
				data = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				key = value.Key;
				data = value.Data;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						key = reader.ReadString();
						if (memberCount != 3)
						{
							data = reader.ReadString();
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f2;
			}
		}
		value = new PbMapData
		{
			IsFromPool = value2,
			Type = value3,
			Key = key,
			Data = data
		};
		return;
		IL_00f2:
		value.IsFromPool = value2;
		value.Type = value3;
		value.Key = key;
		value.Data = data;
	}
}
