using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(360)]
[MemoryPackable(GenerateType.Object)]
public class PbFarmGridInfo : MessageObject, IMemoryPackable<PbFarmGridInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFarmGridInfoFormatter : MemoryPackFormatter<PbFarmGridInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFarmGridInfo value)
		{
			PbFarmGridInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFarmGridInfo value)
		{
			PbFarmGridInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int GirdId { get; set; }

	[MemoryPackOrder(1)]
	public int State { get; set; }

	[MemoryPackOrder(2)]
	public long HarvestTime { get; set; }

	[MemoryPackOrder(3)]
	public int SeedId { get; set; }

	[MemoryPackOrder(4)]
	public PbItem Fruit { get; set; }

	public static PbFarmGridInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFarmGridInfo)) as PbFarmGridInfo;
		}
		return new PbFarmGridInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			GirdId = 0;
			State = 0;
			HarvestTime = 0L;
			SeedId = 0;
			Fruit = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFarmGridInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFarmGridInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbFarmGridInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFarmGridInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFarmGridInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFarmGridInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int>(6, value.IsFromPool, value.GirdId, value.State, value.HarvestTime, value.SeedId);
		writer.WritePackable<PbItem>(value.Fruit);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFarmGridInfo? value)
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
		int value6;
		PbItem value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.GirdId;
				value4 = value.State;
				value5 = value.HarvestTime;
				value6 = value.SeedId;
				value7 = value.Fruit;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadPackable(ref value7);
				goto IL_014c;
			}
			reader.ReadUnmanaged<bool, int, int, long, int>(out value2, out value3, out value4, out value5, out value6);
			value7 = reader.ReadPackable<PbItem>();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFarmGridInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.GirdId;
				value4 = value.State;
				value5 = value.HarvestTime;
				value6 = value.SeedId;
				value7 = value.Fruit;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadPackable(ref value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014c;
			}
		}
		value = new PbFarmGridInfo
		{
			IsFromPool = value2,
			GirdId = value3,
			State = value4,
			HarvestTime = value5,
			SeedId = value6,
			Fruit = value7
		};
		return;
		IL_014c:
		value.IsFromPool = value2;
		value.GirdId = value3;
		value.State = value4;
		value.HarvestTime = value5;
		value.SeedId = value6;
		value.Fruit = value7;
	}
}
