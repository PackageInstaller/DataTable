using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10295)]
[MemoryPackable(GenerateType.Object)]
public class GetCopyCanFightTimesResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetCopyCanFightTimesResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetCopyCanFightTimesResponseFormatter : MemoryPackFormatter<GetCopyCanFightTimesResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetCopyCanFightTimesResponse value)
		{
			GetCopyCanFightTimesResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetCopyCanFightTimesResponse value)
		{
			GetCopyCanFightTimesResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(92)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbCopyPassTimesInfo> PassTimesInfos { get; set; } = new List<PbCopyPassTimesInfo>();

	public static GetCopyCanFightTimesResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetCopyCanFightTimesResponse)) as GetCopyCanFightTimesResponse;
		}
		return new GetCopyCanFightTimesResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			PassTimesInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetCopyCanFightTimesResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetCopyCanFightTimesResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetCopyCanFightTimesResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetCopyCanFightTimesResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetCopyCanFightTimesResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyPassTimesInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyPassTimesInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetCopyCanFightTimesResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyPassTimesInfo>>(value.PassTimesInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetCopyCanFightTimesResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbCopyPassTimesInfo> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PassTimesInfos;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbCopyPassTimesInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetCopyCanFightTimesResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PassTimesInfos;
				value4 = value.RpcId;
				value5 = value.Error;
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
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_012b;
			}
		}
		value = new GetCopyCanFightTimesResponse
		{
			IsFromPool = value2,
			PassTimesInfos = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.PassTimesInfos = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
