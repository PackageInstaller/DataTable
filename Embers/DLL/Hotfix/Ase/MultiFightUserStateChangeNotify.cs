using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10443)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightUserStateChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightUserStateChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightUserStateChangeNotifyFormatter : MemoryPackFormatter<MultiFightUserStateChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightUserStateChangeNotify value)
		{
			MultiFightUserStateChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightUserStateChangeNotify value)
		{
			MultiFightUserStateChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Vit { get; set; }

	[MemoryPackOrder(2)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(3)]
	public int RewardTimes { get; set; }

	public static MultiFightUserStateChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightUserStateChangeNotify)) as MultiFightUserStateChangeNotify;
		}
		return new MultiFightUserStateChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Vit = 0;
			SelectModel = 0;
			RewardTimes = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightUserStateChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightUserStateChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightUserStateChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightUserStateChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightUserStateChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightUserStateChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int, int, long>(7, value.IsFromPool, value.UserId, value.Vit, value.SelectModel, value.RewardTimes, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightUserStateChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Vit;
				value5 = value.SelectModel;
				value6 = value.RewardTimes;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0172;
			}
			reader.ReadUnmanaged<bool, long, int, int, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightUserStateChangeNotify), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Vit;
				value5 = value.SelectModel;
				value6 = value.RewardTimes;
				value7 = value.RpcId;
				value8 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
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
				goto IL_0172;
			}
		}
		value = new MultiFightUserStateChangeNotify
		{
			IsFromPool = value2,
			UserId = value3,
			Vit = value4,
			SelectModel = value5,
			RewardTimes = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_0172:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Vit = value4;
		value.SelectModel = value5;
		value.RewardTimes = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
