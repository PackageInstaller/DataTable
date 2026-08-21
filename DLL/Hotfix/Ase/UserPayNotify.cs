using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10792)]
[MemoryPackable(GenerateType.Object)]
public class UserPayNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UserPayNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserPayNotifyFormatter : MemoryPackFormatter<UserPayNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserPayNotify value)
		{
			UserPayNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserPayNotify value)
		{
			UserPayNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Things { get; set; }

	[MemoryPackOrder(1)]
	public long TotalCharge { get; set; }

	[MemoryPackOrder(2)]
	public long FirstCharge { get; set; }

	public static UserPayNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserPayNotify)) as UserPayNotify;
		}
		return new UserPayNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			ActorId = 0L;
			Things = null;
			TotalCharge = 0L;
			FirstCharge = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserPayNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserPayNotify>())
		{
			MemoryPackFormatterProvider.Register(new UserPayNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserPayNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserPayNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserPayNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Things);
		writer.WriteUnmanaged<long, long, int, int, long>(value.TotalCharge, value.FirstCharge, value.RpcId, value.Error, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserPayNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		long value4;
		long value5;
		int value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Things;
				value4 = value.TotalCharge;
				value5 = value.FirstCharge;
				value6 = value.RpcId;
				value7 = value.Error;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_017e;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<long, long, int, int, long>(out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserPayNotify), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Things;
				value4 = value.TotalCharge;
				value5 = value.FirstCharge;
				value6 = value.RpcId;
				value7 = value.Error;
				value8 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
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
				goto IL_017e;
			}
		}
		value = new UserPayNotify
		{
			IsFromPool = value2,
			Things = value3,
			TotalCharge = value4,
			FirstCharge = value5,
			RpcId = value6,
			Error = value7,
			ActorId = value8
		};
		return;
		IL_017e:
		value.IsFromPool = value2;
		value.Things = value3;
		value.TotalCharge = value4;
		value.FirstCharge = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.ActorId = value8;
	}
}
