using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1066)]
[MemoryPackable(GenerateType.Object)]
public class InnerCheckUserBattleFieldInfoResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerCheckUserBattleFieldInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerCheckUserBattleFieldInfoResponseFormatter : MemoryPackFormatter<InnerCheckUserBattleFieldInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerCheckUserBattleFieldInfoResponse value)
		{
			InnerCheckUserBattleFieldInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerCheckUserBattleFieldInfoResponse value)
		{
			InnerCheckUserBattleFieldInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public bool RoomAlive { get; set; }

	[MemoryPackOrder(1)]
	public string OutAddress { get; set; }

	[MemoryPackOrder(2)]
	public int KcpConnectId { get; set; }

	public static InnerCheckUserBattleFieldInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerCheckUserBattleFieldInfoResponse)) as InnerCheckUserBattleFieldInfoResponse;
		}
		return new InnerCheckUserBattleFieldInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RoomAlive = false;
			OutAddress = null;
			KcpConnectId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerCheckUserBattleFieldInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCheckUserBattleFieldInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerCheckUserBattleFieldInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCheckUserBattleFieldInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerCheckUserBattleFieldInfoResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerCheckUserBattleFieldInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool>(7, value.IsFromPool, value.RoomAlive);
		writer.WriteString(value.OutAddress);
		writer.WriteUnmanaged<int, int, int>(value.KcpConnectId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerCheckUserBattleFieldInfoResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		int value4;
		int value5;
		int value6;
		string outAddress;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomAlive;
				outAddress = value.OutAddress;
				value4 = value.KcpConnectId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				outAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_017f;
			}
			reader.ReadUnmanaged<bool, bool>(out value2, out value3);
			outAddress = reader.ReadString();
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerCheckUserBattleFieldInfoResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
				outAddress = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomAlive;
				outAddress = value.OutAddress;
				value4 = value.KcpConnectId;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<bool>(out value3);
					if (memberCount != 2)
					{
						outAddress = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
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
				goto IL_017f;
			}
		}
		value = new InnerCheckUserBattleFieldInfoResponse
		{
			IsFromPool = value2,
			RoomAlive = value3,
			OutAddress = outAddress,
			KcpConnectId = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_017f:
		value.IsFromPool = value2;
		value.RoomAlive = value3;
		value.OutAddress = outAddress;
		value.KcpConnectId = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
