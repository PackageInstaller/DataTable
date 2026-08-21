using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(425)]
[MemoryPackable(GenerateType.Object)]
public class PbShareEquipInfo : MessageObject, IMemoryPackable<PbShareEquipInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbShareEquipInfoFormatter : MemoryPackFormatter<PbShareEquipInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbShareEquipInfo value)
		{
			PbShareEquipInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbShareEquipInfo value)
		{
			PbShareEquipInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int EquipType { get; set; }

	[MemoryPackOrder(1)]
	public PbEquipBase EquipInfo { get; set; }

	public static PbShareEquipInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbShareEquipInfo)) as PbShareEquipInfo;
		}
		return new PbShareEquipInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			EquipType = 0;
			EquipInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbShareEquipInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbShareEquipInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbShareEquipInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbShareEquipInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbShareEquipInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbShareEquipInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.EquipType);
		writer.WritePackable<PbEquipBase>(value.EquipInfo);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbShareEquipInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbEquipBase value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EquipType;
				value4 = value.EquipInfo;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbEquipBase>();
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbShareEquipInfo), 3, memberCount);
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
				value3 = value.EquipType;
				value4 = value.EquipInfo;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c3;
			}
		}
		value = new PbShareEquipInfo
		{
			IsFromPool = value2,
			EquipType = value3,
			EquipInfo = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.EquipType = value3;
		value.EquipInfo = value4;
	}
}
