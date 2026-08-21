using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10917)]
[MemoryPackable(GenerateType.Object)]
public class C2S_RenamePresetEquipment : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_RenamePresetEquipment>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_RenamePresetEquipmentFormatter : MemoryPackFormatter<C2S_RenamePresetEquipment>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_RenamePresetEquipment value)
		{
			C2S_RenamePresetEquipment.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_RenamePresetEquipment value)
		{
			C2S_RenamePresetEquipment.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int RoleId { get; set; }

	[MemoryPackOrder(1)]
	public int SlotId { get; set; }

	[MemoryPackOrder(2)]
	public string PresetName { get; set; }

	public static C2S_RenamePresetEquipment Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_RenamePresetEquipment)) as C2S_RenamePresetEquipment;
		}
		return new C2S_RenamePresetEquipment();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			RoleId = 0;
			SlotId = 0;
			PresetName = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_RenamePresetEquipment()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_RenamePresetEquipment>())
		{
			MemoryPackFormatterProvider.Register(new C2S_RenamePresetEquipmentFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_RenamePresetEquipment[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_RenamePresetEquipment>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_RenamePresetEquipment? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(8, value.IsFromPool, value.RoleId, value.SlotId);
		writer.WriteString(value.PresetName);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_RenamePresetEquipment? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		long value6;
		int value7;
		long value8;
		string presetName;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.SlotId;
				presetName = value.PresetName;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				presetName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			presetName = reader.ReadString();
			reader.ReadUnmanaged<int, long, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_RenamePresetEquipment), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				presetName = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.SlotId;
				presetName = value.PresetName;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
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
							presetName = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value8);
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01a9;
			}
		}
		value = new C2S_RenamePresetEquipment
		{
			IsFromPool = value2,
			RoleId = value3,
			SlotId = value4,
			PresetName = presetName,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.SlotId = value4;
		value.PresetName = presetName;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
