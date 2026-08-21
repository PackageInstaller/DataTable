using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10205)]
[MemoryPackable(GenerateType.Object)]
public class HeroLifeSeatUpgradeRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<HeroLifeSeatUpgradeRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class HeroLifeSeatUpgradeRequestFormatter : MemoryPackFormatter<HeroLifeSeatUpgradeRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref HeroLifeSeatUpgradeRequest value)
		{
			HeroLifeSeatUpgradeRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref HeroLifeSeatUpgradeRequest value)
		{
			HeroLifeSeatUpgradeRequest.Deserialize(ref reader, ref value);
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
	public int RoleId { get; set; }

	[MemoryPackOrder(1)]
	public int optType { get; set; }

	[MemoryPackOrder(2)]
	public int point { get; set; }

	public static HeroLifeSeatUpgradeRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(HeroLifeSeatUpgradeRequest)) as HeroLifeSeatUpgradeRequest;
		}
		return new HeroLifeSeatUpgradeRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			RoleId = 0;
			optType = 0;
			point = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static HeroLifeSeatUpgradeRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HeroLifeSeatUpgradeRequest>())
		{
			MemoryPackFormatterProvider.Register(new HeroLifeSeatUpgradeRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<HeroLifeSeatUpgradeRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<HeroLifeSeatUpgradeRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref HeroLifeSeatUpgradeRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, long, int, long>(8, value.IsFromPool, value.RoleId, value.optType, value.point, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref HeroLifeSeatUpgradeRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
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
				value3 = value.RoleId;
				value4 = value.optType;
				value5 = value.point;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_019d;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(HeroLifeSeatUpgradeRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.optType;
				value5 = value.point;
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
						reader.ReadUnmanaged<int>(out value4);
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
				goto IL_019d;
			}
		}
		value = new HeroLifeSeatUpgradeRequest
		{
			IsFromPool = value2,
			RoleId = value3,
			optType = value4,
			point = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_019d:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.optType = value4;
		value.point = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
