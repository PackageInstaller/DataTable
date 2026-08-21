using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10823)]
[MemoryPackable(GenerateType.Object)]
public class S2CGetTowerTalentInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2CGetTowerTalentInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2CGetTowerTalentInfoResponseFormatter : MemoryPackFormatter<S2CGetTowerTalentInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2CGetTowerTalentInfoResponse value)
		{
			S2CGetTowerTalentInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2CGetTowerTalentInfoResponse value)
		{
			S2CGetTowerTalentInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbTowerTalentInfoByActivityId> Infos { get; set; } = new List<PbTowerTalentInfoByActivityId>();

	public static S2CGetTowerTalentInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2CGetTowerTalentInfoResponse)) as S2CGetTowerTalentInfoResponse;
		}
		return new S2CGetTowerTalentInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Infos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2CGetTowerTalentInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetTowerTalentInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2CGetTowerTalentInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2CGetTowerTalentInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2CGetTowerTalentInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbTowerTalentInfoByActivityId>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbTowerTalentInfoByActivityId>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2CGetTowerTalentInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbTowerTalentInfoByActivityId>>(value.Infos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2CGetTowerTalentInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbTowerTalentInfoByActivityId> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Infos;
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
			value3 = ListFormatter.DeserializePackable<PbTowerTalentInfoByActivityId>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2CGetTowerTalentInfoResponse), 5, memberCount);
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
				value3 = value.Infos;
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
		value = new S2CGetTowerTalentInfoResponse
		{
			IsFromPool = value2,
			Infos = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.Infos = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
