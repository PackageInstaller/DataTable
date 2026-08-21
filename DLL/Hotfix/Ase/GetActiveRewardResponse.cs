using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10779)]
[MemoryPackable(GenerateType.Object)]
public class GetActiveRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetActiveRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetActiveRewardResponseFormatter : MemoryPackFormatter<GetActiveRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetActiveRewardResponse value)
		{
			GetActiveRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetActiveRewardResponse value)
		{
			GetActiveRewardResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Rewards { get; set; }

	[MemoryPackOrder(1)]
	public int DailyRewardState { get; set; }

	[MemoryPackOrder(2)]
	public int WeekRewardState { get; set; }

	[MemoryPackOrder(3)]
	public int Level { get; set; }

	[MemoryPackOrder(4)]
	public int Exp { get; set; }

	public static GetActiveRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetActiveRewardResponse)) as GetActiveRewardResponse;
		}
		return new GetActiveRewardResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Rewards = null;
			DailyRewardState = 0;
			WeekRewardState = 0;
			Level = 0;
			Exp = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetActiveRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetActiveRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetActiveRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetActiveRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetActiveRewardResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetActiveRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(9, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WriteUnmanaged<int, int, int, int, int, int>(value.DailyRewardState, value.WeekRewardState, value.Level, value.Exp, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetActiveRewardResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		int value4;
		int value5;
		int value6;
		int value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.DailyRewardState;
				value5 = value.WeekRewardState;
				value6 = value.Level;
				value7 = value.Exp;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01db;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, int, int, int, int, int>(out value4, out value5, out value6, out value7, out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetActiveRewardResponse), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.DailyRewardState;
				value5 = value.WeekRewardState;
				value6 = value.Level;
				value7 = value.Exp;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
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
				goto IL_01db;
			}
		}
		value = new GetActiveRewardResponse
		{
			IsFromPool = value2,
			Rewards = value3,
			DailyRewardState = value4,
			WeekRewardState = value5,
			Level = value6,
			Exp = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01db:
		value.IsFromPool = value2;
		value.Rewards = value3;
		value.DailyRewardState = value4;
		value.WeekRewardState = value5;
		value.Level = value6;
		value.Exp = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
