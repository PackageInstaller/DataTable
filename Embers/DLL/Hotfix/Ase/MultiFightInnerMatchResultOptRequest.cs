using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10460)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerMatchResultOptRequest : MessageObject, IRequest, IMessage, IMemoryPackable<MultiFightInnerMatchResultOptRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerMatchResultOptRequestFormatter : MemoryPackFormatter<MultiFightInnerMatchResultOptRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerMatchResultOptRequest value)
		{
			MultiFightInnerMatchResultOptRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerMatchResultOptRequest value)
		{
			MultiFightInnerMatchResultOptRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	[MemoryPackOrder(2)]
	public int Opt { get; set; }

	[MemoryPackOrder(3)]
	public long ResultId { get; set; }

	[MemoryPackOrder(4)]
	public PbCreateSettingRoomUserInfo UserInfo { get; set; }

	public static MultiFightInnerMatchResultOptRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerMatchResultOptRequest)) as MultiFightInnerMatchResultOptRequest;
		}
		return new MultiFightInnerMatchResultOptRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			RoomId = 0L;
			UserId = 0L;
			Opt = 0;
			ResultId = 0L;
			UserInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerMatchResultOptRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerMatchResultOptRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerMatchResultOptRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerMatchResultOptRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerMatchResultOptRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerMatchResultOptRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, long>(8, value.IsFromPool, value.RoomId, value.UserId, value.Opt, value.ResultId);
		writer.WritePackable<PbCreateSettingRoomUserInfo>(value.UserInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerMatchResultOptRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		long value6;
		PbCreateSettingRoomUserInfo value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserId;
				value5 = value.Opt;
				value6 = value.ResultId;
				value7 = value.UserInfo;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadPackable(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01ab;
			}
			reader.ReadUnmanaged<bool, long, long, int, long>(out value2, out value3, out value4, out value5, out value6);
			value7 = reader.ReadPackable<PbCreateSettingRoomUserInfo>();
			reader.ReadUnmanaged<int, long>(out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerMatchResultOptRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = null;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserId;
				value5 = value.Opt;
				value6 = value.ResultId;
				value7 = value.UserInfo;
				value8 = value.RpcId;
				value9 = value.ActorId;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadPackable(ref value7);
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
				goto IL_01ab;
			}
		}
		value = new MultiFightInnerMatchResultOptRequest
		{
			IsFromPool = value2,
			RoomId = value3,
			UserId = value4,
			Opt = value5,
			ResultId = value6,
			UserInfo = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01ab:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.UserId = value4;
		value.Opt = value5;
		value.ResultId = value6;
		value.UserInfo = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
