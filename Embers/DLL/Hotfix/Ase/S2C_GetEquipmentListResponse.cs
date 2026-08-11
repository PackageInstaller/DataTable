using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10077)]
[MemoryPackable(GenerateType.Object)]
public class S2C_GetEquipmentListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_GetEquipmentListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_GetEquipmentListResponseFormatter : MemoryPackFormatter<S2C_GetEquipmentListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_GetEquipmentListResponse value)
		{
			S2C_GetEquipmentListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_GetEquipmentListResponse value)
		{
			S2C_GetEquipmentListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbEquipBase> Equipments { get; set; } = new List<PbEquipBase>();

	[MemoryPackOrder(1)]
	public long UnselectSuitboxUuid { get; set; }

	public static S2C_GetEquipmentListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_GetEquipmentListResponse)) as S2C_GetEquipmentListResponse;
		}
		return new S2C_GetEquipmentListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Equipments.Clear();
			UnselectSuitboxUuid = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_GetEquipmentListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GetEquipmentListResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_GetEquipmentListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GetEquipmentListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_GetEquipmentListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_GetEquipmentListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.Equipments));
		writer.WriteUnmanaged<long, int, int>(value.UnselectSuitboxUuid, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_GetEquipmentListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbEquipBase> value3;
		long value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Equipments;
				value4 = value.UnselectSuitboxUuid;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0157;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			reader.ReadUnmanaged<long, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_GetEquipmentListResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Equipments;
				value4 = value.UnselectSuitboxUuid;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_0157;
			}
		}
		value = new S2C_GetEquipmentListResponse
		{
			IsFromPool = value2,
			Equipments = value3,
			UnselectSuitboxUuid = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.Equipments = value3;
		value.UnselectSuitboxUuid = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
