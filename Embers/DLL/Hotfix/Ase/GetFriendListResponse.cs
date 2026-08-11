using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10180)]
[MemoryPackable(GenerateType.Object)]
public class GetFriendListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetFriendListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetFriendListResponseFormatter : MemoryPackFormatter<GetFriendListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetFriendListResponse value)
		{
			GetFriendListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetFriendListResponse value)
		{
			GetFriendListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbFriendItemInfo> Friends { get; set; } = new List<PbFriendItemInfo>();

	[MemoryPackOrder(1)]
	public int TotalFriendsHoleCount { get; set; }

	[MemoryPackOrder(2)]
	public int UsedFriendHoleCount { get; set; }

	[MemoryPackOrder(3)]
	public List<PbFriendItemInfo> RecenetPlayers { get; set; } = new List<PbFriendItemInfo>();

	public static GetFriendListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetFriendListResponse)) as GetFriendListResponse;
		}
		return new GetFriendListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Friends.Clear();
			TotalFriendsHoleCount = 0;
			UsedFriendHoleCount = 0;
			RecenetPlayers.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetFriendListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendListResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetFriendListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetFriendListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendItemInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendItemInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetFriendListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		List<PbFriendItemInfo> source = value.Friends;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteUnmanaged<int, int>(value.TotalFriendsHoleCount, value.UsedFriendHoleCount);
		source = value.RecenetPlayers;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetFriendListResponse? value)
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
		List<PbFriendItemInfo> value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Friends;
				value4 = value.TotalFriendsHoleCount;
				value5 = value.UsedFriendHoleCount;
				value6 = value.RecenetPlayers;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01b8;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbFriendItemInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbFriendItemInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetFriendListResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Friends;
				value4 = value.TotalFriendsHoleCount;
				value5 = value.UsedFriendHoleCount;
				value6 = value.RecenetPlayers;
				value7 = value.RpcId;
				value8 = value.Error;
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
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
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
				goto IL_01b8;
			}
		}
		value = new GetFriendListResponse
		{
			IsFromPool = value2,
			Friends = value3,
			TotalFriendsHoleCount = value4,
			UsedFriendHoleCount = value5,
			RecenetPlayers = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01b8:
		value.IsFromPool = value2;
		value.Friends = value3;
		value.TotalFriendsHoleCount = value4;
		value.UsedFriendHoleCount = value5;
		value.RecenetPlayers = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
