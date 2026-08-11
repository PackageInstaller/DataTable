using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(332)]
[MemoryPackable(GenerateType.Object)]
public class PbActivityTypeAllData : MessageObject, IMemoryPackable<PbActivityTypeAllData>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbActivityTypeAllDataFormatter : MemoryPackFormatter<PbActivityTypeAllData>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbActivityTypeAllData value)
		{
			PbActivityTypeAllData.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbActivityTypeAllData value)
		{
			PbActivityTypeAllData.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ActivityType { get; set; }

	[MemoryPackOrder(1)]
	public List<PbActivityTaskData> Datas { get; set; } = new List<PbActivityTaskData>();

	[MemoryPackOrder(2)]
	public List<PbActivityRankStateData> RankData { get; set; } = new List<PbActivityRankStateData>();

	public static PbActivityTypeAllData Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbActivityTypeAllData)) as PbActivityTypeAllData;
		}
		return new PbActivityTypeAllData();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActivityType = 0;
			Datas.Clear();
			RankData.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbActivityTypeAllData()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbActivityTypeAllData>())
		{
			MemoryPackFormatterProvider.Register(new PbActivityTypeAllDataFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbActivityTypeAllData[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbActivityTypeAllData>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityTaskData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityTaskData>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityRankStateData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityRankStateData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbActivityTypeAllData? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(4, value.IsFromPool, value.ActivityType);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityTaskData>>(value.Datas));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityRankStateData>>(value.RankData));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbActivityTypeAllData? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbActivityTaskData> value4;
		List<PbActivityRankStateData> value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityType;
				value4 = value.Datas;
				value5 = value.RankData;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbActivityTaskData>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbActivityRankStateData>(ref reader);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbActivityTypeAllData), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityType;
				value4 = value.Datas;
				value5 = value.RankData;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f4;
			}
		}
		value = new PbActivityTypeAllData
		{
			IsFromPool = value2,
			ActivityType = value3,
			Datas = value4,
			RankData = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.ActivityType = value3;
		value.Datas = value4;
		value.RankData = value5;
	}
}
