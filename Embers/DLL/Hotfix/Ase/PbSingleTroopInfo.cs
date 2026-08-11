using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(316)]
[MemoryPackable(GenerateType.Object)]
public class PbSingleTroopInfo : MessageObject, IMemoryPackable<PbSingleTroopInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSingleTroopInfoFormatter : MemoryPackFormatter<PbSingleTroopInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSingleTroopInfo value)
		{
			PbSingleTroopInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSingleTroopInfo value)
		{
			PbSingleTroopInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int TroopId { get; set; }

	[MemoryPackOrder(1)]
	public string TroopName { get; set; }

	[MemoryPackOrder(2)]
	public List<int> RoleIds { get; set; } = new List<int>();

	public static PbSingleTroopInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSingleTroopInfo)) as PbSingleTroopInfo;
		}
		return new PbSingleTroopInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			TroopId = 0;
			TroopName = null;
			RoleIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSingleTroopInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSingleTroopInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSingleTroopInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSingleTroopInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSingleTroopInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSingleTroopInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(4, value.IsFromPool, value.TroopId);
		writer.WriteString(value.TroopName);
		writer.WriteValue<List<int>>(value.RoleIds);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSingleTroopInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<int> value4;
		string troopName;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TroopId;
				troopName = value.TroopName;
				value4 = value.RoleIds;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				troopName = reader.ReadString();
				reader.ReadValue(ref value4);
				goto IL_00f2;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			troopName = reader.ReadString();
			value4 = reader.ReadValue<List<int>>();
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSingleTroopInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				troopName = null;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TroopId;
				troopName = value.TroopName;
				value4 = value.RoleIds;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						troopName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadValue(ref value4);
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
		value = new PbSingleTroopInfo
		{
			IsFromPool = value2,
			TroopId = value3,
			TroopName = troopName,
			RoleIds = value4
		};
		return;
		IL_00f2:
		value.IsFromPool = value2;
		value.TroopId = value3;
		value.TroopName = troopName;
		value.RoleIds = value4;
	}
}
