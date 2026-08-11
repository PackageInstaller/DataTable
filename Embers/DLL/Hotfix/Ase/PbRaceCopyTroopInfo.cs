using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(423)]
[MemoryPackable(GenerateType.Object)]
public class PbRaceCopyTroopInfo : MessageObject, IMemoryPackable<PbRaceCopyTroopInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRaceCopyTroopInfoFormatter : MemoryPackFormatter<PbRaceCopyTroopInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRaceCopyTroopInfo value)
		{
			PbRaceCopyTroopInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRaceCopyTroopInfo value)
		{
			PbRaceCopyTroopInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int TroopId { get; set; }

	[MemoryPackOrder(1)]
	public string TroopName { get; set; }

	[MemoryPackOrder(2)]
	public List<int> RoleIds { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public int BuffId { get; set; }

	[MemoryPackOrder(4)]
	public bool Block { get; set; }

	[MemoryPackOrder(9)]
	public string param1 { get; set; }

	public static PbRaceCopyTroopInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRaceCopyTroopInfo)) as PbRaceCopyTroopInfo;
		}
		return new PbRaceCopyTroopInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			TroopId = 0;
			TroopName = null;
			RoleIds.Clear();
			BuffId = 0;
			Block = false;
			param1 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRaceCopyTroopInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRaceCopyTroopInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRaceCopyTroopInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRaceCopyTroopInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRaceCopyTroopInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRaceCopyTroopInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(7, value.IsFromPool, value.TroopId);
		writer.WriteString(value.TroopName);
		writer.WriteValue<List<int>>(value.RoleIds);
		writer.WriteUnmanaged<int, bool>(value.BuffId, value.Block);
		writer.WriteString(value.param1);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRaceCopyTroopInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<int> value4;
		int value5;
		bool value6;
		string troopName;
		string text;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TroopId;
				troopName = value.TroopName;
				value4 = value.RoleIds;
				value5 = value.BuffId;
				value6 = value.Block;
				text = value.param1;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				troopName = reader.ReadString();
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				text = reader.ReadString();
				goto IL_0185;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			troopName = reader.ReadString();
			value4 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, bool>(out value5, out value6);
			text = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRaceCopyTroopInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				troopName = null;
				value4 = null;
				value5 = 0;
				value6 = false;
				text = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TroopId;
				troopName = value.TroopName;
				value4 = value.RoleIds;
				value5 = value.BuffId;
				value6 = value.Block;
				text = value.param1;
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
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<bool>(out value6);
									if (memberCount != 6)
									{
										text = reader.ReadString();
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0185;
			}
		}
		value = new PbRaceCopyTroopInfo
		{
			IsFromPool = value2,
			TroopId = value3,
			TroopName = troopName,
			RoleIds = value4,
			BuffId = value5,
			Block = value6,
			param1 = text
		};
		return;
		IL_0185:
		value.IsFromPool = value2;
		value.TroopId = value3;
		value.TroopName = troopName;
		value.RoleIds = value4;
		value.BuffId = value5;
		value.Block = value6;
		value.param1 = text;
	}
}
