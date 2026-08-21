using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10462)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerMatchResultNotify : MessageObject, IRequest, IMessage, IMemoryPackable<MultiFightInnerMatchResultNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerMatchResultNotifyFormatter : MemoryPackFormatter<MultiFightInnerMatchResultNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerMatchResultNotify value)
		{
			MultiFightInnerMatchResultNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerMatchResultNotify value)
		{
			MultiFightInnerMatchResultNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbMatchResultUserInfo> UserInfos { get; set; } = new List<PbMatchResultUserInfo>();

	[MemoryPackOrder(2)]
	public long ResultId { get; set; }

	[MemoryPackOrder(3)]
	public string FinalRoomAddress { get; set; }

	[MemoryPackOrder(4)]
	public long FinalRoomId { get; set; }

	[MemoryPackOrder(5)]
	public List<long> RobotUids { get; set; } = new List<long>();

	public static MultiFightInnerMatchResultNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerMatchResultNotify)) as MultiFightInnerMatchResultNotify;
		}
		return new MultiFightInnerMatchResultNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			RoomId = 0L;
			UserInfos.Clear();
			ResultId = 0L;
			FinalRoomAddress = null;
			FinalRoomId = 0L;
			RobotUids.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerMatchResultNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerMatchResultNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerMatchResultNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerMatchResultNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerMatchResultNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMatchResultUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMatchResultUserInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerMatchResultNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(9, value.IsFromPool, value.RoomId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMatchResultUserInfo>>(value.UserInfos));
		writer.WriteUnmanaged<long>(value.ResultId);
		writer.WriteString(value.FinalRoomAddress);
		writer.WriteUnmanaged<long>(value.FinalRoomId);
		writer.WriteValue<List<long>>(value.RobotUids);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerMatchResultNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbMatchResultUserInfo> value4;
		long value5;
		long value6;
		List<long> value7;
		int value8;
		long value9;
		string finalRoomAddress;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserInfos;
				value5 = value.ResultId;
				finalRoomAddress = value.FinalRoomAddress;
				value6 = value.FinalRoomId;
				value7 = value.RobotUids;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<long>(out value5);
				finalRoomAddress = reader.ReadString();
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadValue(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01f1;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbMatchResultUserInfo>(ref reader);
			reader.ReadUnmanaged<long>(out value5);
			finalRoomAddress = reader.ReadString();
			reader.ReadUnmanaged<long>(out value6);
			value7 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, long>(out value8, out value9);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerMatchResultNotify), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0L;
				finalRoomAddress = null;
				value6 = 0L;
				value7 = null;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserInfos;
				value5 = value.ResultId;
				finalRoomAddress = value.FinalRoomAddress;
				value6 = value.FinalRoomId;
				value7 = value.RobotUids;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								finalRoomAddress = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									if (memberCount != 6)
									{
										reader.ReadValue(ref value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value9);
												_ = 9;
											}
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
				goto IL_01f1;
			}
		}
		value = new MultiFightInnerMatchResultNotify
		{
			IsFromPool = value2,
			RoomId = value3,
			UserInfos = value4,
			ResultId = value5,
			FinalRoomAddress = finalRoomAddress,
			FinalRoomId = value6,
			RobotUids = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01f1:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.UserInfos = value4;
		value.ResultId = value5;
		value.FinalRoomAddress = finalRoomAddress;
		value.FinalRoomId = value6;
		value.RobotUids = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
