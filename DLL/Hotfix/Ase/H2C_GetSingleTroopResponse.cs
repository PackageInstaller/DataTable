using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10089)]
[MemoryPackable(GenerateType.Object)]
public class H2C_GetSingleTroopResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_GetSingleTroopResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_GetSingleTroopResponseFormatter : MemoryPackFormatter<H2C_GetSingleTroopResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_GetSingleTroopResponse value)
		{
			H2C_GetSingleTroopResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_GetSingleTroopResponse value)
		{
			H2C_GetSingleTroopResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbSingleTroopInfo> Troops { get; set; } = new List<PbSingleTroopInfo>();

	[MemoryPackOrder(1)]
	public int TroopId { get; set; }

	public static H2C_GetSingleTroopResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_GetSingleTroopResponse)) as H2C_GetSingleTroopResponse;
		}
		return new H2C_GetSingleTroopResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Troops.Clear();
			TroopId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_GetSingleTroopResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetSingleTroopResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_GetSingleTroopResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetSingleTroopResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_GetSingleTroopResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSingleTroopInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSingleTroopInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_GetSingleTroopResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSingleTroopInfo>>(value.Troops));
		writer.WriteUnmanaged<int, int, int>(value.TroopId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_GetSingleTroopResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbSingleTroopInfo> value3;
		int value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Troops;
				value4 = value.TroopId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbSingleTroopInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_GetSingleTroopResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Troops;
				value4 = value.TroopId;
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
						reader.ReadUnmanaged<int>(out value4);
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
				goto IL_0156;
			}
		}
		value = new H2C_GetSingleTroopResponse
		{
			IsFromPool = value2,
			Troops = value3,
			TroopId = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.Troops = value3;
		value.TroopId = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
