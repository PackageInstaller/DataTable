using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10777)]
[MemoryPackable(GenerateType.Object)]
public class ActiveTaskCompleteResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<ActiveTaskCompleteResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ActiveTaskCompleteResponseFormatter : MemoryPackFormatter<ActiveTaskCompleteResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ActiveTaskCompleteResponse value)
		{
			ActiveTaskCompleteResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ActiveTaskCompleteResponse value)
		{
			ActiveTaskCompleteResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public int DailyPoint { get; set; }

	[MemoryPackOrder(2)]
	public int WeekPoint { get; set; }

	public static ActiveTaskCompleteResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ActiveTaskCompleteResponse)) as ActiveTaskCompleteResponse;
		}
		return new ActiveTaskCompleteResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			TaskId = 0;
			DailyPoint = 0;
			WeekPoint = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ActiveTaskCompleteResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ActiveTaskCompleteResponse>())
		{
			MemoryPackFormatterProvider.Register(new ActiveTaskCompleteResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ActiveTaskCompleteResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ActiveTaskCompleteResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ActiveTaskCompleteResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, int>(7, value.IsFromPool, value.TaskId, value.DailyPoint, value.WeekPoint, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ActiveTaskCompleteResponse? value)
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
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.DailyPoint;
				value5 = value.WeekPoint;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0176;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ActiveTaskCompleteResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.DailyPoint;
				value5 = value.WeekPoint;
				value6 = value.RpcId;
				value7 = value.Error;
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
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
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
				goto IL_0176;
			}
		}
		value = new ActiveTaskCompleteResponse
		{
			IsFromPool = value2,
			TaskId = value3,
			DailyPoint = value4,
			WeekPoint = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0176:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.DailyPoint = value4;
		value.WeekPoint = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
