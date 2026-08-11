using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(315)]
[MemoryPackable(GenerateType.Object)]
public class PbDropThing : MessageObject, IMemoryPackable<PbDropThing>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbDropThingFormatter : MemoryPackFormatter<PbDropThing>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbDropThing value)
		{
			PbDropThing.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbDropThing value)
		{
			PbDropThing.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<PbItemBase> Items { get; set; } = new List<PbItemBase>();

	[MemoryPackOrder(1)]
	public List<PbEquipBase> Equips { get; set; } = new List<PbEquipBase>();

	[MemoryPackOrder(2)]
	public List<PbNormalRoleInfo> Roles { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(3)]
	public List<PbExpireItem> ExpireItem { get; set; } = new List<PbExpireItem>();

	public static PbDropThing Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbDropThing)) as PbDropThing;
		}
		return new PbDropThing();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Items.Clear();
			Equips.Clear();
			Roles.Clear();
			ExpireItem.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbDropThing()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbDropThing>())
		{
			MemoryPackFormatterProvider.Register(new PbDropThingFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbDropThing[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbDropThing>());
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
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbExpireItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbExpireItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbDropThing? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItemBase>>(value.Items));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.Equips));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.Roles));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbExpireItem>>(value.ExpireItem));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbDropThing? value)
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
		List<PbExpireItem> value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Items;
				value4 = value.Equips;
				value5 = value.Roles;
				value6 = value.ExpireItem;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				goto IL_0130;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbItemBase>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			value6 = ListFormatter.DeserializePackable<PbExpireItem>(ref reader);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbDropThing), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Items;
				value4 = value.Equips;
				value5 = value.Roles;
				value6 = value.ExpireItem;
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
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0130;
			}
		}
		value = new PbDropThing
		{
			IsFromPool = value2,
			Items = value3,
			Equips = value4,
			Roles = value5,
			ExpireItem = value6
		};
		return;
		IL_0130:
		value.IsFromPool = value2;
		value.Items = value3;
		value.Equips = value4;
		value.Roles = value5;
		value.ExpireItem = value6;
	}
}
