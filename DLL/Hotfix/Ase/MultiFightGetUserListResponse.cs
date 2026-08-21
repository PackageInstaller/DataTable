using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10427)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightGetUserListResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<MultiFightGetUserListResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightGetUserListResponseFormatter : MemoryPackFormatter<MultiFightGetUserListResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightGetUserListResponse value)
		{
			MultiFightGetUserListResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightGetUserListResponse value)
		{
			MultiFightGetUserListResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbLongIdValue> UserStates { get; set; } = new List<PbLongIdValue>();

	[MemoryPackOrder(1)]
	public List<PbMultiFightFriendInfo> RecentPlayers { get; set; } = new List<PbMultiFightFriendInfo>();

	[MemoryPackOrder(2)]
	public List<PbLongIdValue> UnionUserStates { get; set; } = new List<PbLongIdValue>();

	public static MultiFightGetUserListResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightGetUserListResponse)) as MultiFightGetUserListResponse;
		}
		return new MultiFightGetUserListResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserStates.Clear();
			RecentPlayers.Clear();
			UnionUserStates.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightGetUserListResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightGetUserListResponse>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightGetUserListResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightGetUserListResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightGetUserListResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbLongIdValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbLongIdValue>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMultiFightFriendInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMultiFightFriendInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightGetUserListResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		List<PbLongIdValue> source = value.UserStates;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMultiFightFriendInfo>>(value.RecentPlayers));
		source = value.UnionUserStates;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightGetUserListResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbLongIdValue> value3;
		List<PbMultiFightFriendInfo> value4;
		List<PbLongIdValue> value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserStates;
				value4 = value.RecentPlayers;
				value5 = value.UnionUserStates;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_018c;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbLongIdValue>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbMultiFightFriendInfo>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbLongIdValue>(ref reader);
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightGetUserListResponse), 7, memberCount);
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
				value3 = value.UserStates;
				value4 = value.RecentPlayers;
				value5 = value.UnionUserStates;
				value6 = value.RpcId;
				value7 = value.Error;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
		value = new MultiFightGetUserListResponse
		{
			IsFromPool = value2,
			UserStates = value3,
			RecentPlayers = value4,
			UnionUserStates = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_018c:
		value.IsFromPool = value2;
		value.UserStates = value3;
		value.RecentPlayers = value4;
		value.UnionUserStates = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
