using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10464)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerMatchResultFeedbackServerNotify : MessageObject, IRequest, IMessage, IMemoryPackable<MultiFightInnerMatchResultFeedbackServerNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerMatchResultFeedbackServerNotifyFormatter : MemoryPackFormatter<MultiFightInnerMatchResultFeedbackServerNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerMatchResultFeedbackServerNotify value)
		{
			MultiFightInnerMatchResultFeedbackServerNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerMatchResultFeedbackServerNotify value)
		{
			MultiFightInnerMatchResultFeedbackServerNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public long ResultId { get; set; }

	[MemoryPackOrder(3)]
	public int Opt { get; set; }

	public static MultiFightInnerMatchResultFeedbackServerNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerMatchResultFeedbackServerNotify)) as MultiFightInnerMatchResultFeedbackServerNotify;
		}
		return new MultiFightInnerMatchResultFeedbackServerNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			RoomId = 0L;
			ResultId = 0L;
			Opt = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerMatchResultFeedbackServerNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerMatchResultFeedbackServerNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerMatchResultFeedbackServerNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerMatchResultFeedbackServerNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerMatchResultFeedbackServerNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerMatchResultFeedbackServerNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, long, int, int, long>(7, value.IsFromPool, value.UserId, value.RoomId, value.ResultId, value.Opt, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerMatchResultFeedbackServerNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
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
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.ResultId;
				value6 = value.Opt;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0174;
			}
			reader.ReadUnmanaged<bool, long, long, long, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerMatchResultFeedbackServerNotify), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.ResultId;
				value6 = value.Opt;
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
				goto IL_0174;
			}
		}
		value = new MultiFightInnerMatchResultFeedbackServerNotify
		{
			IsFromPool = value2,
			UserId = value3,
			RoomId = value4,
			ResultId = value5,
			Opt = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_0174:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoomId = value4;
		value.ResultId = value5;
		value.Opt = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
