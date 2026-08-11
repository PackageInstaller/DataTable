using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10079)]
[MemoryPackable(GenerateType.Object)]
public class H2C_EquipEquipmentResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_EquipEquipmentResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_EquipEquipmentResponseFormatter : MemoryPackFormatter<H2C_EquipEquipmentResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_EquipEquipmentResponse value)
		{
			H2C_EquipEquipmentResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_EquipEquipmentResponse value)
		{
			H2C_EquipEquipmentResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbNormalRoleInfo RoleInfo { get; set; }

	[MemoryPackOrder(1)]
	public PbEquipBase NewEquipInfo { get; set; }

	[MemoryPackOrder(2)]
	public PbEquipBase OldEquipInfo { get; set; }

	public static H2C_EquipEquipmentResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_EquipEquipmentResponse)) as H2C_EquipEquipmentResponse;
		}
		return new H2C_EquipEquipmentResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RoleInfo = null;
			NewEquipInfo = null;
			OldEquipInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_EquipEquipmentResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_EquipEquipmentResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_EquipEquipmentResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_EquipEquipmentResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_EquipEquipmentResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_EquipEquipmentResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbNormalRoleInfo>(value.RoleInfo);
		writer.WritePackable<PbEquipBase>(value.NewEquipInfo);
		writer.WritePackable<PbEquipBase>(value.OldEquipInfo);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_EquipEquipmentResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbNormalRoleInfo value3;
		PbEquipBase value4;
		PbEquipBase value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleInfo;
				value4 = value.NewEquipInfo;
				value5 = value.OldEquipInfo;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbNormalRoleInfo>();
			value4 = reader.ReadPackable<PbEquipBase>();
			value5 = reader.ReadPackable<PbEquipBase>();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_EquipEquipmentResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleInfo;
				value4 = value.NewEquipInfo;
				value5 = value.OldEquipInfo;
				value6 = value.RpcId;
				value7 = value.Error;
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
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
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
				goto IL_018c;
			}
		}
		value = new H2C_EquipEquipmentResponse
		{
			IsFromPool = value2,
			RoleInfo = value3,
			NewEquipInfo = value4,
			OldEquipInfo = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.RoleInfo = value3;
		value.NewEquipInfo = value4;
		value.OldEquipInfo = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
