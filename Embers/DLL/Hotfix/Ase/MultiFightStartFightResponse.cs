using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10435)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightStartFightResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<MultiFightStartFightResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightStartFightResponseFormatter : MemoryPackFormatter<MultiFightStartFightResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightStartFightResponse value)
		{
			MultiFightStartFightResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightStartFightResponse value)
		{
			MultiFightStartFightResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public string PunishUserName { get; set; }

	[MemoryPackOrder(1)]
	public int PunishLeftTime { get; set; }

	public static MultiFightStartFightResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightStartFightResponse)) as MultiFightStartFightResponse;
		}
		return new MultiFightStartFightResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			PunishUserName = null;
			PunishLeftTime = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightStartFightResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartFightResponse>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightStartFightResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightStartFightResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightStartFightResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightStartFightResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteString(value.PunishUserName);
		writer.WriteUnmanaged<int, int, int>(value.PunishLeftTime, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightStartFightResponse? value)
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
		string punishUserName;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				punishUserName = value.PunishUserName;
				value3 = value.PunishLeftTime;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				punishUserName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_0154;
			}
			reader.ReadUnmanaged<bool>(out value2);
			punishUserName = reader.ReadString();
			reader.ReadUnmanaged<int, int, int>(out value3, out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightStartFightResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				punishUserName = null;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				punishUserName = value.PunishUserName;
				value3 = value.PunishLeftTime;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					punishUserName = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
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
				goto IL_0154;
			}
		}
		value = new MultiFightStartFightResponse
		{
			IsFromPool = value2,
			PunishUserName = punishUserName,
			PunishLeftTime = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_0154:
		value.IsFromPool = value2;
		value.PunishUserName = punishUserName;
		value.PunishLeftTime = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
