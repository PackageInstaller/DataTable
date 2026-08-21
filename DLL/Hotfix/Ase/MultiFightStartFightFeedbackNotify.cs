using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10496)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightStartFightFeedbackNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightStartFightFeedbackNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightStartFightFeedbackNotifyFormatter : MemoryPackFormatter<MultiFightStartFightFeedbackNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightStartFightFeedbackNotify value)
		{
			MultiFightStartFightFeedbackNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightStartFightFeedbackNotify value)
		{
			MultiFightStartFightFeedbackNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string UserName { get; set; }

	[MemoryPackOrder(2)]
	public int Ope { get; set; }

	public static MultiFightStartFightFeedbackNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightStartFightFeedbackNotify)) as MultiFightStartFightFeedbackNotify;
		}
		return new MultiFightStartFightFeedbackNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			UserName = null;
			Ope = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightStartFightFeedbackNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartFightFeedbackNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightStartFightFeedbackNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartFightFeedbackNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightStartFightFeedbackNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightStartFightFeedbackNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.UserId);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int, long>(value.Ope, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightStartFightFeedbackNotify? value)
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
		long value6;
		string userName;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.Ope;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0150;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int, long>(out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightStartFightFeedbackNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				userName = null;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.Ope;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						userName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0150;
			}
		}
		value = new MultiFightStartFightFeedbackNotify
		{
			IsFromPool = value2,
			UserId = value3,
			UserName = userName,
			Ope = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0150:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserName = userName;
		value.Ope = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
