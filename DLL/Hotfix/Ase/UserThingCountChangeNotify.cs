using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10311)]
[MemoryPackable(GenerateType.Object)]
public class UserThingCountChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UserThingCountChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserThingCountChangeNotifyFormatter : MemoryPackFormatter<UserThingCountChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserThingCountChangeNotify value)
		{
			UserThingCountChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserThingCountChangeNotify value)
		{
			UserThingCountChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Things { get; set; }

	[MemoryPackOrder(1)]
	public bool Hide { get; set; }

	public static UserThingCountChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserThingCountChangeNotify)) as UserThingCountChangeNotify;
		}
		return new UserThingCountChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Things = null;
			Hide = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserThingCountChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserThingCountChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new UserThingCountChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserThingCountChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserThingCountChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserThingCountChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Things);
		writer.WriteUnmanaged<bool, int, long>(value.Hide, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserThingCountChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		bool value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Things;
				value4 = value.Hide;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<bool, int, long>(out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserThingCountChangeNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = false;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Things;
				value4 = value.Hide;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<bool>(out value4);
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
				goto IL_0123;
			}
		}
		value = new UserThingCountChangeNotify
		{
			IsFromPool = value2,
			Things = value3,
			Hide = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.Things = value3;
		value.Hide = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
