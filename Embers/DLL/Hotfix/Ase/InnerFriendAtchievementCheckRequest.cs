using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1117)]
[MemoryPackable(GenerateType.Object)]
public class InnerFriendAtchievementCheckRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerFriendAtchievementCheckRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerFriendAtchievementCheckRequestFormatter : MemoryPackFormatter<InnerFriendAtchievementCheckRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerFriendAtchievementCheckRequest value)
		{
			InnerFriendAtchievementCheckRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerFriendAtchievementCheckRequest value)
		{
			InnerFriendAtchievementCheckRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public List<long> TeamIds { get; set; } = new List<long>();

	[MemoryPackOrder(1)]
	public long UnionId { get; set; }

	public static InnerFriendAtchievementCheckRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerFriendAtchievementCheckRequest)) as InnerFriendAtchievementCheckRequest;
		}
		return new InnerFriendAtchievementCheckRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			TeamIds.Clear();
			UnionId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerFriendAtchievementCheckRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerFriendAtchievementCheckRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerFriendAtchievementCheckRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerFriendAtchievementCheckRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerFriendAtchievementCheckRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerFriendAtchievementCheckRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteValue<List<long>>(value.TeamIds);
		writer.WriteUnmanaged<long, int, long>(value.UnionId, value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerFriendAtchievementCheckRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<long> value3;
		long value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TeamIds;
				value4 = value.UnionId;
				value5 = value.RpcId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<long, int, long>(out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerFriendAtchievementCheckRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TeamIds;
				value4 = value.UnionId;
				value5 = value.RpcId;
				value6 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0124;
			}
		}
		value = new InnerFriendAtchievementCheckRequest
		{
			IsFromPool = value2,
			TeamIds = value3,
			UnionId = value4,
			RpcId = value5,
			UserId = value6
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.TeamIds = value3;
		value.UnionId = value4;
		value.RpcId = value5;
		value.UserId = value6;
	}
}
