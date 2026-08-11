using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10493)]
[MemoryPackable(GenerateType.Object)]
public class H2MR_InnerStartMatchResponse : MessageObject, IResponse, IMessage, IMemoryPackable<H2MR_InnerStartMatchResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2MR_InnerStartMatchResponseFormatter : MemoryPackFormatter<H2MR_InnerStartMatchResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerStartMatchResponse value)
		{
			H2MR_InnerStartMatchResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerStartMatchResponse value)
		{
			H2MR_InnerStartMatchResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long PunishUserId { get; set; }

	[MemoryPackOrder(1)]
	public int PunishLeftTime { get; set; }

	[MemoryPackOrder(2)]
	public string PunishName { get; set; }

	public static H2MR_InnerStartMatchResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2MR_InnerStartMatchResponse)) as H2MR_InnerStartMatchResponse;
		}
		return new H2MR_InnerStartMatchResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			PunishUserId = 0L;
			PunishLeftTime = 0;
			PunishName = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2MR_InnerStartMatchResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerStartMatchResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2MR_InnerStartMatchResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerStartMatchResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2MR_InnerStartMatchResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerStartMatchResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(7, value.IsFromPool, value.PunishUserId, value.PunishLeftTime);
		writer.WriteString(value.PunishName);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerStartMatchResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		string punishName;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PunishUserId;
				value4 = value.PunishLeftTime;
				punishName = value.PunishName;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				punishName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0183;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			punishName = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2MR_InnerStartMatchResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				punishName = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PunishUserId;
				value4 = value.PunishLeftTime;
				punishName = value.PunishName;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							punishName = reader.ReadString();
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
				goto IL_0183;
			}
		}
		value = new H2MR_InnerStartMatchResponse
		{
			IsFromPool = value2,
			PunishUserId = value3,
			PunishLeftTime = value4,
			PunishName = punishName,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0183:
		value.IsFromPool = value2;
		value.PunishUserId = value3;
		value.PunishLeftTime = value4;
		value.PunishName = punishName;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
