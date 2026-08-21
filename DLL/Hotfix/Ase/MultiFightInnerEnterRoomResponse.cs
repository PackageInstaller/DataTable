using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10451)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerEnterRoomResponse : MessageObject, IResponse, IMessage, IMemoryPackable<MultiFightInnerEnterRoomResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerEnterRoomResponseFormatter : MemoryPackFormatter<MultiFightInnerEnterRoomResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerEnterRoomResponse value)
		{
			MultiFightInnerEnterRoomResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerEnterRoomResponse value)
		{
			MultiFightInnerEnterRoomResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public PbMatchRoomInfo MatchRoomInfo { get; set; }

	public static MultiFightInnerEnterRoomResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerEnterRoomResponse)) as MultiFightInnerEnterRoomResponse;
		}
		return new MultiFightInnerEnterRoomResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0L;
			MatchRoomInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerEnterRoomResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerEnterRoomResponse>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerEnterRoomResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerEnterRoomResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerEnterRoomResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerEnterRoomResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.UserId);
		writer.WritePackable<PbMatchRoomInfo>(value.MatchRoomInfo);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerEnterRoomResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbMatchRoomInfo value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.MatchRoomInfo;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0157;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbMatchRoomInfo>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerEnterRoomResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.MatchRoomInfo;
				value5 = value.RpcId;
				value6 = value.Error;
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
						reader.ReadPackable(ref value4);
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
				goto IL_0157;
			}
		}
		value = new MultiFightInnerEnterRoomResponse
		{
			IsFromPool = value2,
			UserId = value3,
			MatchRoomInfo = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.MatchRoomInfo = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
