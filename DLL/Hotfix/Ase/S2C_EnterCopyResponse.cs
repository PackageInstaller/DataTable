using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10097)]
[MemoryPackable(GenerateType.Object)]
public class S2C_EnterCopyResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_EnterCopyResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_EnterCopyResponseFormatter : MemoryPackFormatter<S2C_EnterCopyResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_EnterCopyResponse value)
		{
			S2C_EnterCopyResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_EnterCopyResponse value)
		{
			S2C_EnterCopyResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long CheckCode { get; set; }

	[MemoryPackOrder(1)]
	public int AccountEnergy { get; set; }

	[MemoryPackOrder(2)]
	public long LastVitRecoverTime { get; set; }

	[MemoryPackOrder(3)]
	public int CopyTicketCount { get; set; }

	[MemoryPackOrder(4)]
	public long RoomId { get; set; }

	[MemoryPackOrder(5)]
	public int RandSeed { get; set; }

	public static S2C_EnterCopyResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_EnterCopyResponse)) as S2C_EnterCopyResponse;
		}
		return new S2C_EnterCopyResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			CheckCode = 0L;
			AccountEnergy = 0;
			LastVitRecoverTime = 0L;
			CopyTicketCount = 0;
			RoomId = 0L;
			RandSeed = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_EnterCopyResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_EnterCopyResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_EnterCopyResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_EnterCopyResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_EnterCopyResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_EnterCopyResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, long, int, long, int, int, int>(10, value.IsFromPool, value.CheckCode, value.AccountEnergy, value.LastVitRecoverTime, value.CopyTicketCount, value.RoomId, value.RandSeed, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_EnterCopyResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		int value6;
		long value7;
		int value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CheckCode;
				value4 = value.AccountEnergy;
				value5 = value.LastVitRecoverTime;
				value6 = value.CopyTicketCount;
				value7 = value.RoomId;
				value8 = value.RandSeed;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_01ff;
			}
			reader.ReadUnmanaged<bool, long, int, long, int, long, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_EnterCopyResponse), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CheckCode;
				value4 = value.AccountEnergy;
				value5 = value.LastVitRecoverTime;
				value6 = value.CopyTicketCount;
				value7 = value.RoomId;
				value8 = value.RandSeed;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
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
													message = reader.ReadString();
													_ = 10;
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
				goto IL_01ff;
			}
		}
		value = new S2C_EnterCopyResponse
		{
			IsFromPool = value2,
			CheckCode = value3,
			AccountEnergy = value4,
			LastVitRecoverTime = value5,
			CopyTicketCount = value6,
			RoomId = value7,
			RandSeed = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_01ff:
		value.IsFromPool = value2;
		value.CheckCode = value3;
		value.AccountEnergy = value4;
		value.LastVitRecoverTime = value5;
		value.CopyTicketCount = value6;
		value.RoomId = value7;
		value.RandSeed = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
