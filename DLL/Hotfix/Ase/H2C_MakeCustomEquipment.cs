using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10876)]
[MemoryPackable(GenerateType.Object)]
public class H2C_MakeCustomEquipment : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_MakeCustomEquipment>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_MakeCustomEquipmentFormatter : MemoryPackFormatter<H2C_MakeCustomEquipment>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_MakeCustomEquipment value)
		{
			H2C_MakeCustomEquipment.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_MakeCustomEquipment value)
		{
			H2C_MakeCustomEquipment.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbEquipBase EquipmentInfo { get; set; }

	[MemoryPackOrder(1)]
	public PbItemChange PackItem { get; set; }

	public static H2C_MakeCustomEquipment Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_MakeCustomEquipment)) as H2C_MakeCustomEquipment;
		}
		return new H2C_MakeCustomEquipment();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			EquipmentInfo = null;
			PackItem = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_MakeCustomEquipment()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_MakeCustomEquipment>())
		{
			MemoryPackFormatterProvider.Register(new H2C_MakeCustomEquipmentFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_MakeCustomEquipment[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_MakeCustomEquipment>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_MakeCustomEquipment? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbEquipBase>(value.EquipmentInfo);
		writer.WritePackable<PbItemChange>(value.PackItem);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_MakeCustomEquipment? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbEquipBase value3;
		PbItemChange value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EquipmentInfo;
				value4 = value.PackItem;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbEquipBase>();
			value4 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_MakeCustomEquipment), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EquipmentInfo;
				value4 = value.PackItem;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_015b;
			}
		}
		value = new H2C_MakeCustomEquipment
		{
			IsFromPool = value2,
			EquipmentInfo = value3,
			PackItem = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.EquipmentInfo = value3;
		value.PackItem = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
