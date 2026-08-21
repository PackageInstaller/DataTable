using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10215)]
[MemoryPackable(GenerateType.Object)]
public class GetFriendBlackListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetFriendBlackListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetFriendBlackListResponseFormatter : MemoryPackFormatter<GetFriendBlackListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetFriendBlackListResponse value)
		{
			GetFriendBlackListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetFriendBlackListResponse value)
		{
			GetFriendBlackListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbFriendItemInfo> FriendInfo { get; set; } = new List<PbFriendItemInfo>();

	public static GetFriendBlackListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetFriendBlackListResponse)) as GetFriendBlackListResponse;
		}
		return new GetFriendBlackListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			FriendInfo.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetFriendBlackListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendBlackListResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetFriendBlackListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendBlackListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetFriendBlackListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendItemInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendItemInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetFriendBlackListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendItemInfo>>(value.FriendInfo));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetFriendBlackListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbFriendItemInfo> value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendInfo;
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
			value3 = ListFormatter.DeserializePackable<PbFriendItemInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetFriendBlackListResponse), 5, memberCount);
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
				value3 = value.FriendInfo;
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
		value = new GetFriendBlackListResponse
		{
			IsFromPool = value2,
			FriendInfo = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.FriendInfo = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
