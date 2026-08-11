using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10760)]
[MemoryPackable(GenerateType.Object)]
public class DevOpenAllStoryDropsRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<DevOpenAllStoryDropsRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class DevOpenAllStoryDropsRequestFormatter : MemoryPackFormatter<DevOpenAllStoryDropsRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref DevOpenAllStoryDropsRequest value)
		{
			DevOpenAllStoryDropsRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref DevOpenAllStoryDropsRequest value)
		{
			DevOpenAllStoryDropsRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<int> BoxIds { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public List<int> MonsterIds { get; set; } = new List<int>();

	[MemoryPackOrder(2)]
	public int ChapterId { get; set; }

	public static DevOpenAllStoryDropsRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(DevOpenAllStoryDropsRequest)) as DevOpenAllStoryDropsRequest;
		}
		return new DevOpenAllStoryDropsRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			BoxIds.Clear();
			MonsterIds.Clear();
			ChapterId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static DevOpenAllStoryDropsRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<DevOpenAllStoryDropsRequest>())
		{
			MemoryPackFormatterProvider.Register(new DevOpenAllStoryDropsRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<DevOpenAllStoryDropsRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<DevOpenAllStoryDropsRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref DevOpenAllStoryDropsRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteValue<List<int>>(value.BoxIds);
		writer.WriteValue<List<int>>(value.MonsterIds);
		writer.WriteUnmanaged<int, int, long, int, long>(value.ChapterId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref DevOpenAllStoryDropsRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		List<int> value4;
		int value5;
		int value6;
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BoxIds;
				value4 = value.MonsterIds;
				value5 = value.ChapterId;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01ad;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			value4 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, long, int, long>(out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(DevOpenAllStoryDropsRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BoxIds;
				value4 = value.MonsterIds;
				value5 = value.ChapterId;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
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
				goto IL_01ad;
			}
		}
		value = new DevOpenAllStoryDropsRequest
		{
			IsFromPool = value2,
			BoxIds = value3,
			MonsterIds = value4,
			ChapterId = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01ad:
		value.IsFromPool = value2;
		value.BoxIds = value3;
		value.MonsterIds = value4;
		value.ChapterId = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
