using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10520)]
[MemoryPackable(GenerateType.Object)]
public class DevMFStartSingleTestRequest : MessageObject, IRequest, IMessage, IMemoryPackable<DevMFStartSingleTestRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class DevMFStartSingleTestRequestFormatter : MemoryPackFormatter<DevMFStartSingleTestRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref DevMFStartSingleTestRequest value)
		{
			DevMFStartSingleTestRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref DevMFStartSingleTestRequest value)
		{
			DevMFStartSingleTestRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public List<long> RoomUserIds { get; set; } = new List<long>();

	[MemoryPackOrder(2)]
	public long RoomId { get; set; }

	[MemoryPackOrder(3)]
	public int LevelLowerLimit { get; set; }

	[MemoryPackOrder(4)]
	public int LevelUpperLimit { get; set; }

	[MemoryPackOrder(5)]
	public int RoomJoinPermission { get; set; }

	[MemoryPackOrder(6)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(7)]
	public int CopyId { get; set; }

	[MemoryPackOrder(8)]
	public int MainType { get; set; }

	[MemoryPackOrder(9)]
	public int SubType { get; set; }

	[MemoryPackOrder(10)]
	public int Difficulty { get; set; }

	public static DevMFStartSingleTestRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(DevMFStartSingleTestRequest)) as DevMFStartSingleTestRequest;
		}
		return new DevMFStartSingleTestRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			RoomUserIds.Clear();
			RoomId = 0L;
			LevelLowerLimit = 0;
			LevelUpperLimit = 0;
			RoomJoinPermission = 0;
			SelectModel = 0;
			CopyId = 0;
			MainType = 0;
			SubType = 0;
			Difficulty = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static DevMFStartSingleTestRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<DevMFStartSingleTestRequest>())
		{
			MemoryPackFormatterProvider.Register(new DevMFStartSingleTestRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<DevMFStartSingleTestRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<DevMFStartSingleTestRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref DevMFStartSingleTestRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(13, value.IsFromPool, value.UserId);
		writer.WriteValue<List<long>>(value.RoomUserIds);
		writer.WriteUnmanaged<long, int, int, int, int, int, int, int, int, int>(value.RoomId, value.LevelLowerLimit, value.LevelUpperLimit, value.RoomJoinPermission, value.SelectModel, value.CopyId, value.MainType, value.SubType, value.Difficulty, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref DevMFStartSingleTestRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<long> value4;
		long value5;
		int value6;
		int value7;
		int value8;
		int value9;
		int value10;
		int value11;
		int value12;
		int value13;
		int value14;
		if (memberCount == 13)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomUserIds;
				value5 = value.RoomId;
				value6 = value.LevelLowerLimit;
				value7 = value.LevelUpperLimit;
				value8 = value.RoomJoinPermission;
				value9 = value.SelectModel;
				value10 = value.CopyId;
				value11 = value.MainType;
				value12 = value.SubType;
				value13 = value.Difficulty;
				value14 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<int>(out value12);
				reader.ReadUnmanaged<int>(out value13);
				reader.ReadUnmanaged<int>(out value14);
				goto IL_0290;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<long, int, int, int, int, int, int, int, int, int>(out value5, out value6, out value7, out value8, out value9, out value10, out value11, out value12, out value13, out value14);
		}
		else
		{
			if (memberCount > 13)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(DevMFStartSingleTestRequest), 13, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				value11 = 0;
				value12 = 0;
				value13 = 0;
				value14 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomUserIds;
				value5 = value.RoomId;
				value6 = value.LevelLowerLimit;
				value7 = value.LevelUpperLimit;
				value8 = value.RoomJoinPermission;
				value9 = value.SelectModel;
				value10 = value.CopyId;
				value11 = value.MainType;
				value12 = value.SubType;
				value13 = value.Difficulty;
				value14 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
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
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value12);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value13);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<int>(out value14);
																_ = 13;
															}
														}
													}
												}
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
				goto IL_0290;
			}
		}
		value = new DevMFStartSingleTestRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RoomUserIds = value4,
			RoomId = value5,
			LevelLowerLimit = value6,
			LevelUpperLimit = value7,
			RoomJoinPermission = value8,
			SelectModel = value9,
			CopyId = value10,
			MainType = value11,
			SubType = value12,
			Difficulty = value13,
			RpcId = value14
		};
		return;
		IL_0290:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoomUserIds = value4;
		value.RoomId = value5;
		value.LevelLowerLimit = value6;
		value.LevelUpperLimit = value7;
		value.RoomJoinPermission = value8;
		value.SelectModel = value9;
		value.CopyId = value10;
		value.MainType = value11;
		value.SubType = value12;
		value.Difficulty = value13;
		value.RpcId = value14;
	}
}
