using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10913)]
[MemoryPackable(GenerateType.Object)]
public class C2S_SetPresetEquipment : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_SetPresetEquipment>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_SetPresetEquipmentFormatter : MemoryPackFormatter<C2S_SetPresetEquipment>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_SetPresetEquipment value)
		{
			C2S_SetPresetEquipment.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_SetPresetEquipment value)
		{
			C2S_SetPresetEquipment.Deserialize(ref reader, ref value);
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
	public PbPresetEquipmentSlotInfo Slot { get; set; }

	public static C2S_SetPresetEquipment Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_SetPresetEquipment)) as C2S_SetPresetEquipment;
		}
		return new C2S_SetPresetEquipment();
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
			Slot = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_SetPresetEquipment()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_SetPresetEquipment>())
		{
			MemoryPackFormatterProvider.Register(new C2S_SetPresetEquipmentFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_SetPresetEquipment[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_SetPresetEquipment>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_SetPresetEquipment? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(7, value.IsFromPool, value.RoleId);
		writer.WritePackable<PbPresetEquipmentSlotInfo>(value.Slot);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_SetPresetEquipment? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbPresetEquipmentSlotInfo value4;
		int value5;
		long value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Slot;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_017d;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbPresetEquipmentSlotInfo>();
			reader.ReadUnmanaged<int, long, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_SetPresetEquipment), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Slot;
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
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
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
				goto IL_017d;
			}
		}
		value = new C2S_SetPresetEquipment
		{
			IsFromPool = value2,
			RoleId = value3,
			Slot = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_017d:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.Slot = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
