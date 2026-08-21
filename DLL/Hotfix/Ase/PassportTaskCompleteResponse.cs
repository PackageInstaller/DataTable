using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10743)]
[MemoryPackable(GenerateType.Object)]
public class PassportTaskCompleteResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<PassportTaskCompleteResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PassportTaskCompleteResponseFormatter : MemoryPackFormatter<PassportTaskCompleteResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PassportTaskCompleteResponse value)
		{
			PassportTaskCompleteResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PassportTaskCompleteResponse value)
		{
			PassportTaskCompleteResponse.Deserialize(ref reader, ref value);
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
	public int TotalPoint { get; set; }

	[MemoryPackOrder(4)]
	public int WeeklyGetPoint { get; set; }

	[MemoryPackOrder(5)]
	public int PassportLevel { get; set; }

	public static PassportTaskCompleteResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PassportTaskCompleteResponse)) as PassportTaskCompleteResponse;
		}
		return new PassportTaskCompleteResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			TaskId = 0;
			TotalPoint = 0;
			WeeklyGetPoint = 0;
			PassportLevel = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PassportTaskCompleteResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PassportTaskCompleteResponse>())
		{
			MemoryPackFormatterProvider.Register(new PassportTaskCompleteResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PassportTaskCompleteResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PassportTaskCompleteResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PassportTaskCompleteResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, int, int>(8, value.IsFromPool, value.TaskId, value.TotalPoint, value.WeeklyGetPoint, value.PassportLevel, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PassportTaskCompleteResponse? value)
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
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.TotalPoint;
				value5 = value.WeeklyGetPoint;
				value6 = value.PassportLevel;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01a1;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PassportTaskCompleteResponse), 8, memberCount);
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
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.TotalPoint;
				value5 = value.WeeklyGetPoint;
				value6 = value.PassportLevel;
				value7 = value.RpcId;
				value8 = value.Error;
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
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
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
				goto IL_01a1;
			}
		}
		value = new PassportTaskCompleteResponse
		{
			IsFromPool = value2,
			TaskId = value3,
			TotalPoint = value4,
			WeeklyGetPoint = value5,
			PassportLevel = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01a1:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.TotalPoint = value4;
		value.WeeklyGetPoint = value5;
		value.PassportLevel = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
