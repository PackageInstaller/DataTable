using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10854)]
[MemoryPackable(GenerateType.Object)]
public class GetTeamRoomInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetTeamRoomInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetTeamRoomInfoResponseFormatter : MemoryPackFormatter<GetTeamRoomInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetTeamRoomInfoResponse value)
		{
			GetTeamRoomInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetTeamRoomInfoResponse value)
		{
			GetTeamRoomInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(2)]
	public List<PbTeamRoomUserInfo> UserInfos { get; set; } = new List<PbTeamRoomUserInfo>();

	[MemoryPackOrder(1)]
	public PbBattleConnectInfo ConnectInfo { get; set; }

	public static GetTeamRoomInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetTeamRoomInfoResponse)) as GetTeamRoomInfoResponse;
		}
		return new GetTeamRoomInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserInfos.Clear();
			ConnectInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetTeamRoomInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetTeamRoomInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetTeamRoomInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetTeamRoomInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetTeamRoomInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbTeamRoomUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbTeamRoomUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetTeamRoomInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbBattleConnectInfo>(value.ConnectInfo);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbTeamRoomUserInfo>>(value.UserInfos));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetTeamRoomInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbBattleConnectInfo value3;
		List<PbTeamRoomUserInfo> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ConnectInfo;
				value4 = value.UserInfos;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbBattleConnectInfo>();
			value4 = ListFormatter.DeserializePackable<PbTeamRoomUserInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetTeamRoomInfoResponse), 6, memberCount);
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
				value3 = value.ConnectInfo;
				value4 = value.UserInfos;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
		value = new GetTeamRoomInfoResponse
		{
			IsFromPool = value2,
			ConnectInfo = value3,
			UserInfos = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.ConnectInfo = value3;
		value.UserInfos = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
