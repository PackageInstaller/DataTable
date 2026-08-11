using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10728)]
[MemoryPackable(GenerateType.Object)]
public class GetMonthlyCardInfoResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetMonthlyCardInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetMonthlyCardInfoResponseFormatter : MemoryPackFormatter<GetMonthlyCardInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetMonthlyCardInfoResponse value)
		{
			GetMonthlyCardInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetMonthlyCardInfoResponse value)
		{
			GetMonthlyCardInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int LeftDays { get; set; }

	[MemoryPackOrder(1)]
	public int TodayGot { get; set; }

	public static GetMonthlyCardInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetMonthlyCardInfoResponse)) as GetMonthlyCardInfoResponse;
		}
		return new GetMonthlyCardInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			LeftDays = 0;
			TodayGot = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetMonthlyCardInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetMonthlyCardInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetMonthlyCardInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetMonthlyCardInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetMonthlyCardInfoResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetMonthlyCardInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(6, value.IsFromPool, value.LeftDays, value.TodayGot, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetMonthlyCardInfoResponse? value)
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
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.LeftDays;
				value4 = value.TodayGot;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014b;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetMonthlyCardInfoResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.LeftDays;
				value4 = value.TodayGot;
				value5 = value.RpcId;
				value6 = value.Error;
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
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014b;
			}
		}
		value = new GetMonthlyCardInfoResponse
		{
			IsFromPool = value2,
			LeftDays = value3,
			TodayGot = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014b:
		value.IsFromPool = value2;
		value.LeftDays = value3;
		value.TodayGot = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
