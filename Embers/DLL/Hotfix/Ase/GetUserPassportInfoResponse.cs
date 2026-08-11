using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10704)]
[MemoryPackable(GenerateType.Object)]
public class GetUserPassportInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetUserPassportInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetUserPassportInfoResponseFormatter : MemoryPackFormatter<GetUserPassportInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetUserPassportInfoResponse value)
		{
			GetUserPassportInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetUserPassportInfoResponse value)
		{
			GetUserPassportInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int Grade { get; set; }

	[MemoryPackOrder(1)]
	public int Level { get; set; }

	[MemoryPackOrder(2)]
	public int Point { get; set; }

	[MemoryPackOrder(1)]
	public List<PbRewardStateList> LevelMaxRewardState { get; set; } = new List<PbRewardStateList>();

	[MemoryPackOrder(2)]
	public List<PbState> TaskDoneValue { get; set; } = new List<PbState>();

	[MemoryPackOrder(3)]
	public long EndTime { get; set; }

	[MemoryPackOrder(4)]
	public int WeeklyGetPoint { get; set; }

	public static GetUserPassportInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetUserPassportInfoResponse)) as GetUserPassportInfoResponse;
		}
		return new GetUserPassportInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Grade = 0;
			Level = 0;
			Point = 0;
			LevelMaxRewardState.Clear();
			TaskDoneValue.Clear();
			EndTime = 0L;
			WeeklyGetPoint = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetUserPassportInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetUserPassportInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetUserPassportInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetUserPassportInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetUserPassportInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRewardStateList>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRewardStateList>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbState>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetUserPassportInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(11, value.IsFromPool, value.Grade, value.Level);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRewardStateList>>(value.LevelMaxRewardState));
		writer.WriteUnmanaged<int>(value.Point);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbState>>(value.TaskDoneValue));
		writer.WriteUnmanaged<long, int, int, int>(value.EndTime, value.WeeklyGetPoint, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetUserPassportInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<PbRewardStateList> value5;
		int value6;
		List<PbState> value7;
		long value8;
		int value9;
		int value10;
		int value11;
		string message;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Grade;
				value4 = value.Level;
				value5 = value.LevelMaxRewardState;
				value6 = value.Point;
				value7 = value.TaskDoneValue;
				value8 = value.EndTime;
				value9 = value.WeeklyGetPoint;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				message = reader.ReadString();
				goto IL_0244;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbRewardStateList>(ref reader);
			reader.ReadUnmanaged<int>(out value6);
			value7 = ListFormatter.DeserializePackable<PbState>(ref reader);
			reader.ReadUnmanaged<long, int, int, int>(out value8, out value9, out value10, out value11);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetUserPassportInfoResponse), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = null;
				value8 = 0L;
				value9 = 0;
				value10 = 0;
				value11 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Grade;
				value4 = value.Level;
				value5 = value.LevelMaxRewardState;
				value6 = value.Point;
				value7 = value.TaskDoneValue;
				value8 = value.EndTime;
				value9 = value.WeeklyGetPoint;
				value10 = value.RpcId;
				value11 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
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
														message = reader.ReadString();
														_ = 11;
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
				goto IL_0244;
			}
		}
		value = new GetUserPassportInfoResponse
		{
			IsFromPool = value2,
			Grade = value3,
			Level = value4,
			LevelMaxRewardState = value5,
			Point = value6,
			TaskDoneValue = value7,
			EndTime = value8,
			WeeklyGetPoint = value9,
			RpcId = value10,
			Error = value11,
			Message = message
		};
		return;
		IL_0244:
		value.IsFromPool = value2;
		value.Grade = value3;
		value.Level = value4;
		value.LevelMaxRewardState = value5;
		value.Point = value6;
		value.TaskDoneValue = value7;
		value.EndTime = value8;
		value.WeeklyGetPoint = value9;
		value.RpcId = value10;
		value.Error = value11;
		value.Message = message;
	}
}
