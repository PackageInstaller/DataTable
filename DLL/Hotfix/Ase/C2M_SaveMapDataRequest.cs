using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10114)]
[MemoryPackable(GenerateType.Object)]
public class C2M_SaveMapDataRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2M_SaveMapDataRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2M_SaveMapDataRequestFormatter : MemoryPackFormatter<C2M_SaveMapDataRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2M_SaveMapDataRequest value)
		{
			C2M_SaveMapDataRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2M_SaveMapDataRequest value)
		{
			C2M_SaveMapDataRequest.Deserialize(ref reader, ref value);
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
	public int MapId { get; set; }

	[MemoryPackOrder(1)]
	public long HuoWenId { get; set; }

	[MemoryPackOrder(2)]
	public long MiWuId { get; set; }

	public static C2M_SaveMapDataRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2M_SaveMapDataRequest)) as C2M_SaveMapDataRequest;
		}
		return new C2M_SaveMapDataRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			MapId = 0;
			HuoWenId = 0L;
			MiWuId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2M_SaveMapDataRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_SaveMapDataRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2M_SaveMapDataRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_SaveMapDataRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2M_SaveMapDataRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2M_SaveMapDataRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, long, int, long, int, long>(8, value.IsFromPool, value.MapId, value.HuoWenId, value.MiWuId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2M_SaveMapDataRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		int value6;
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MapId;
				value4 = value.HuoWenId;
				value5 = value.MiWuId;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_019f;
			}
			reader.ReadUnmanaged<bool, int, long, long, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2M_SaveMapDataRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MapId;
				value4 = value.HuoWenId;
				value5 = value.MiWuId;
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
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_019f;
			}
		}
		value = new C2M_SaveMapDataRequest
		{
			IsFromPool = value2,
			MapId = value3,
			HuoWenId = value4,
			MiWuId = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_019f:
		value.IsFromPool = value2;
		value.MapId = value3;
		value.HuoWenId = value4;
		value.MiWuId = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
