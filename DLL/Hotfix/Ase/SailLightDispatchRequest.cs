using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10591)]
[MemoryPackable(GenerateType.Object)]
public class SailLightDispatchRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<SailLightDispatchRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SailLightDispatchRequestFormatter : MemoryPackFormatter<SailLightDispatchRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SailLightDispatchRequest value)
		{
			SailLightDispatchRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SailLightDispatchRequest value)
		{
			SailLightDispatchRequest.Deserialize(ref reader, ref value);
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
	public List<int> HeroIds { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public int EventIdx { get; set; }

	public static SailLightDispatchRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SailLightDispatchRequest)) as SailLightDispatchRequest;
		}
		return new SailLightDispatchRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			HeroIds.Clear();
			EventIdx = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SailLightDispatchRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SailLightDispatchRequest>())
		{
			MemoryPackFormatterProvider.Register(new SailLightDispatchRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SailLightDispatchRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SailLightDispatchRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SailLightDispatchRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteValue<List<int>>(value.HeroIds);
		writer.WriteUnmanaged<int, int, long, int, long>(value.EventIdx, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SailLightDispatchRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		int value4;
		int value5;
		long value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.HeroIds;
				value4 = value.EventIdx;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_017d;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, long, int, long>(out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SailLightDispatchRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.HeroIds;
				value4 = value.EventIdx;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
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
				goto IL_017d;
			}
		}
		value = new SailLightDispatchRequest
		{
			IsFromPool = value2,
			HeroIds = value3,
			EventIdx = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_017d:
		value.IsFromPool = value2;
		value.HeroIds = value3;
		value.EventIdx = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
