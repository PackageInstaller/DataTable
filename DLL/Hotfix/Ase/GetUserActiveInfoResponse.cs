using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10775)]
[MemoryPackable(GenerateType.Object)]
public class GetUserActiveInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetUserActiveInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetUserActiveInfoResponseFormatter : MemoryPackFormatter<GetUserActiveInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetUserActiveInfoResponse value)
		{
			GetUserActiveInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetUserActiveInfoResponse value)
		{
			GetUserActiveInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int DailyPoint { get; set; }

	[MemoryPackOrder(1)]
	public int WeekPoint { get; set; }

	[MemoryPackOrder(2)]
	public int DailyRewardState { get; set; }

	[MemoryPackOrder(3)]
	public int WeekRewardState { get; set; }

	[MemoryPackOrder(4)]
	public List<PbState> TaskDoneValue { get; set; } = new List<PbState>();

	public static GetUserActiveInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetUserActiveInfoResponse)) as GetUserActiveInfoResponse;
		}
		return new GetUserActiveInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			DailyPoint = 0;
			WeekPoint = 0;
			DailyRewardState = 0;
			WeekRewardState = 0;
			TaskDoneValue.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetUserActiveInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetUserActiveInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetUserActiveInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetUserActiveInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetUserActiveInfoResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbState>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetUserActiveInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(9, value.IsFromPool, value.DailyPoint, value.WeekPoint, value.DailyRewardState, value.WeekRewardState);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbState>>(value.TaskDoneValue));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetUserActiveInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		int value6;
		List<PbState> value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.DailyPoint;
				value4 = value.WeekPoint;
				value5 = value.DailyRewardState;
				value6 = value.WeekRewardState;
				value7 = value.TaskDoneValue;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01dc;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			value7 = ListFormatter.DeserializePackable<PbState>(ref reader);
			reader.ReadUnmanaged<int, int>(out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetUserActiveInfoResponse), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = null;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.DailyPoint;
				value4 = value.WeekPoint;
				value5 = value.DailyRewardState;
				value6 = value.WeekRewardState;
				value7 = value.TaskDoneValue;
				value8 = value.RpcId;
				value9 = value.Error;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
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
				goto IL_01dc;
			}
		}
		value = new GetUserActiveInfoResponse
		{
			IsFromPool = value2,
			DailyPoint = value3,
			WeekPoint = value4,
			DailyRewardState = value5,
			WeekRewardState = value6,
			TaskDoneValue = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01dc:
		value.IsFromPool = value2;
		value.DailyPoint = value3;
		value.WeekPoint = value4;
		value.DailyRewardState = value5;
		value.WeekRewardState = value6;
		value.TaskDoneValue = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
