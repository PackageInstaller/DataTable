using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(349)]
[MemoryPackable(GenerateType.Object)]
public class PbLotteryDropThing : MessageObject, IMemoryPackable<PbLotteryDropThing>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbLotteryDropThingFormatter : MemoryPackFormatter<PbLotteryDropThing>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbLotteryDropThing value)
		{
			PbLotteryDropThing.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbLotteryDropThing value)
		{
			PbLotteryDropThing.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<PbItemBase> items { get; set; } = new List<PbItemBase>();

	[MemoryPackOrder(1)]
	public List<PbEquipBase> equips { get; set; } = new List<PbEquipBase>();

	[MemoryPackOrder(2)]
	public List<PbNormalRoleInfo> roles { get; set; } = new List<PbNormalRoleInfo>();

	public static PbLotteryDropThing Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbLotteryDropThing)) as PbLotteryDropThing;
		}
		return new PbLotteryDropThing();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			items.Clear();
			equips.Clear();
			roles.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbLotteryDropThing()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbLotteryDropThing>())
		{
			MemoryPackFormatterProvider.Register(new PbLotteryDropThingFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbLotteryDropThing[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbLotteryDropThing>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemBase>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbLotteryDropThing? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemBase>>(value.items));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.equips));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.roles));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbLotteryDropThing? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbItemBase> value3;
		List<PbEquipBase> value4;
		List<PbNormalRoleInfo> value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.items;
				value4 = value.equips;
				value5 = value.roles;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				goto IL_00f9;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbItemBase>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbLotteryDropThing), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.items;
				value4 = value.equips;
				value5 = value.roles;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
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
				goto IL_00f9;
			}
		}
		value = new PbLotteryDropThing
		{
			IsFromPool = value2,
			items = value3,
			equips = value4,
			roles = value5
		};
		return;
		IL_00f9:
		value.IsFromPool = value2;
		value.items = value3;
		value.equips = value4;
		value.roles = value5;
	}
}
