using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10465)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerAllConfirmMatchNotify : MessageObject, IRequest, IMessage, IMemoryPackable<MultiFightInnerAllConfirmMatchNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerAllConfirmMatchNotifyFormatter : MemoryPackFormatter<MultiFightInnerAllConfirmMatchNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerAllConfirmMatchNotify value)
		{
			MultiFightInnerAllConfirmMatchNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerAllConfirmMatchNotify value)
		{
			MultiFightInnerAllConfirmMatchNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public string Address { get; set; }

	[MemoryPackOrder(2)]
	public List<long> UserIds { get; set; } = new List<long>();

	public static MultiFightInnerAllConfirmMatchNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerAllConfirmMatchNotify)) as MultiFightInnerAllConfirmMatchNotify;
		}
		return new MultiFightInnerAllConfirmMatchNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			RoomId = 0L;
			Address = null;
			UserIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerAllConfirmMatchNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerAllConfirmMatchNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerAllConfirmMatchNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerAllConfirmMatchNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerAllConfirmMatchNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerAllConfirmMatchNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.RoomId);
		writer.WriteString(value.Address);
		writer.WriteValue<List<long>>(value.UserIds);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerAllConfirmMatchNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<long> value4;
		int value5;
		long value6;
		string address;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				address = value.Address;
				value4 = value.UserIds;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				address = reader.ReadString();
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			address = reader.ReadString();
			value4 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerAllConfirmMatchNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				address = null;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				address = value.Address;
				value4 = value.UserIds;
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
						address = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadValue(ref value4);
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
				goto IL_0156;
			}
		}
		value = new MultiFightInnerAllConfirmMatchNotify
		{
			IsFromPool = value2,
			RoomId = value3,
			Address = address,
			UserIds = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.Address = address;
		value.UserIds = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
