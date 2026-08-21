using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10148)]
[MemoryPackable(GenerateType.Object)]
public class RecvTaskRewardNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<RecvTaskRewardNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class RecvTaskRewardNotifyFormatter : MemoryPackFormatter<RecvTaskRewardNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref RecvTaskRewardNotify value)
		{
			RecvTaskRewardNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref RecvTaskRewardNotify value)
		{
			RecvTaskRewardNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public PbDropThing Rewards { get; set; }

	[MemoryPackOrder(2)]
	public int UserLevel { get; set; }

	[MemoryPackOrder(3)]
	public long UserExp { get; set; }

	public static RecvTaskRewardNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(RecvTaskRewardNotify)) as RecvTaskRewardNotify;
		}
		return new RecvTaskRewardNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			TaskId = 0;
			Rewards = null;
			UserLevel = 0;
			UserExp = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static RecvTaskRewardNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<RecvTaskRewardNotify>())
		{
			MemoryPackFormatterProvider.Register(new RecvTaskRewardNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<RecvTaskRewardNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<RecvTaskRewardNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref RecvTaskRewardNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(7, value.IsFromPool, value.TaskId);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WriteUnmanaged<int, long, int, long>(value.UserLevel, value.UserExp, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref RecvTaskRewardNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbDropThing value4;
		int value5;
		long value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.Rewards;
				value5 = value.UserLevel;
				value6 = value.UserExp;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_017d;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, long, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(RecvTaskRewardNotify), 7, memberCount);
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
				value3 = value.TaskId;
				value4 = value.Rewards;
				value5 = value.UserLevel;
				value6 = value.UserExp;
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
						reader.ReadPackable(ref value4);
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
		value = new RecvTaskRewardNotify
		{
			IsFromPool = value2,
			TaskId = value3,
			Rewards = value4,
			UserLevel = value5,
			UserExp = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_017d:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.Rewards = value4;
		value.UserLevel = value5;
		value.UserExp = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
