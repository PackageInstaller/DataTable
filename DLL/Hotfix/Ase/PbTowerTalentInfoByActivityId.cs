using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(418)]
[MemoryPackable(GenerateType.Object)]
public class PbTowerTalentInfoByActivityId : MessageObject, IMemoryPackable<PbTowerTalentInfoByActivityId>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbTowerTalentInfoByActivityIdFormatter : MemoryPackFormatter<PbTowerTalentInfoByActivityId>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbTowerTalentInfoByActivityId value)
		{
			PbTowerTalentInfoByActivityId.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbTowerTalentInfoByActivityId value)
		{
			PbTowerTalentInfoByActivityId.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ActivityId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbTowerTalentInfo> TowerTalentInfos { get; set; } = new List<PbTowerTalentInfo>();

	public static PbTowerTalentInfoByActivityId Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbTowerTalentInfoByActivityId)) as PbTowerTalentInfoByActivityId;
		}
		return new PbTowerTalentInfoByActivityId();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActivityId = 0;
			TowerTalentInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbTowerTalentInfoByActivityId()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbTowerTalentInfoByActivityId>())
		{
			MemoryPackFormatterProvider.Register(new PbTowerTalentInfoByActivityIdFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbTowerTalentInfoByActivityId[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbTowerTalentInfoByActivityId>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbTowerTalentInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbTowerTalentInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbTowerTalentInfoByActivityId? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.ActivityId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbTowerTalentInfo>>(value.TowerTalentInfos));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbTowerTalentInfoByActivityId? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbTowerTalentInfo> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ActivityId;
				value4 = value.TowerTalentInfos;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbTowerTalentInfo>(ref reader);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbTowerTalentInfoByActivityId), 3, memberCount);
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
				value3 = value.ActivityId;
				value4 = value.TowerTalentInfos;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c3;
			}
		}
		value = new PbTowerTalentInfoByActivityId
		{
			IsFromPool = value2,
			ActivityId = value3,
			TowerTalentInfos = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.ActivityId = value3;
		value.TowerTalentInfos = value4;
	}
}
