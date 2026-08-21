using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(359)]
[MemoryPackable(GenerateType.Object)]
public class PbBuildingInfo : MessageObject, IMemoryPackable<PbBuildingInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbBuildingInfoFormatter : MemoryPackFormatter<PbBuildingInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbBuildingInfo value)
		{
			PbBuildingInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbBuildingInfo value)
		{
			PbBuildingInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int BuildingType { get; set; }

	[MemoryPackOrder(1)]
	public int BuildingLevel { get; set; }

	public static PbBuildingInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbBuildingInfo)) as PbBuildingInfo;
		}
		return new PbBuildingInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			BuildingType = 0;
			BuildingLevel = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbBuildingInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbBuildingInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbBuildingInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbBuildingInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbBuildingInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbBuildingInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.BuildingType, value.BuildingLevel);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbBuildingInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BuildingType;
				value4 = value.BuildingLevel;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00be;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbBuildingInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BuildingType;
				value4 = value.BuildingLevel;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00be;
			}
		}
		value = new PbBuildingInfo
		{
			IsFromPool = value2,
			BuildingType = value3,
			BuildingLevel = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.BuildingType = value3;
		value.BuildingLevel = value4;
	}
}
