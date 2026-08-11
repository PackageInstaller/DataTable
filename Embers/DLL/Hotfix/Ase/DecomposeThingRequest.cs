using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10627)]
[MemoryPackable(GenerateType.Object)]
public class DecomposeThingRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<DecomposeThingRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class DecomposeThingRequestFormatter : MemoryPackFormatter<DecomposeThingRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref DecomposeThingRequest value)
		{
			DecomposeThingRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref DecomposeThingRequest value)
		{
			DecomposeThingRequest.Deserialize(ref reader, ref value);
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
	public int ThingType { get; set; }

	[MemoryPackOrder(1)]
	public List<PbItem> SelectThings { get; set; } = new List<PbItem>();

	public static DecomposeThingRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(DecomposeThingRequest)) as DecomposeThingRequest;
		}
		return new DecomposeThingRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			ThingType = 0;
			SelectThings.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static DecomposeThingRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<DecomposeThingRequest>())
		{
			MemoryPackFormatterProvider.Register(new DecomposeThingRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<DecomposeThingRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<DecomposeThingRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref DecomposeThingRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(7, value.IsFromPool, value.ThingType);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbItem>>(value.SelectThings));
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref DecomposeThingRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbItem> value4;
		int value5;
		long value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ThingType;
				value4 = value.SelectThings;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_017d;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbItem>(ref reader);
			reader.ReadUnmanaged<int, long, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(DecomposeThingRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ThingType;
				value4 = value.SelectThings;
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
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
		value = new DecomposeThingRequest
		{
			IsFromPool = value2,
			ThingType = value3,
			SelectThings = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_017d:
		value.IsFromPool = value2;
		value.ThingType = value3;
		value.SelectThings = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
