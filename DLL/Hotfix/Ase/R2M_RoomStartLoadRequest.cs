using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10134)]
[MemoryPackable(GenerateType.Object)]
public class R2M_RoomStartLoadRequest : MessageObject, IRequest, IMessage, IMemoryPackable<R2M_RoomStartLoadRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class R2M_RoomStartLoadRequestFormatter : MemoryPackFormatter<R2M_RoomStartLoadRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref R2M_RoomStartLoadRequest value)
		{
			R2M_RoomStartLoadRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref R2M_RoomStartLoadRequest value)
		{
			R2M_RoomStartLoadRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbBattleFiledUserInfo> Users { get; set; } = new List<PbBattleFiledUserInfo>();

	public static R2M_RoomStartLoadRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(R2M_RoomStartLoadRequest)) as R2M_RoomStartLoadRequest;
		}
		return new R2M_RoomStartLoadRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Users.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static R2M_RoomStartLoadRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<R2M_RoomStartLoadRequest>())
		{
			MemoryPackFormatterProvider.Register(new R2M_RoomStartLoadRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<R2M_RoomStartLoadRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<R2M_RoomStartLoadRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBattleFiledUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBattleFiledUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref R2M_RoomStartLoadRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBattleFiledUserInfo>>(value.Users));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref R2M_RoomStartLoadRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbBattleFiledUserInfo> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbBattleFiledUserInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(R2M_RoomStartLoadRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				value4 = value.RpcId;
				value5 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new R2M_RoomStartLoadRequest
		{
			IsFromPool = value2,
			Users = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.Users = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
