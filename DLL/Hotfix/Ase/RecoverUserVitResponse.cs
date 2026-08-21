using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10489)]
[MemoryPackable(GenerateType.Object)]
public class RecoverUserVitResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<RecoverUserVitResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class RecoverUserVitResponseFormatter : MemoryPackFormatter<RecoverUserVitResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref RecoverUserVitResponse value)
		{
			RecoverUserVitResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref RecoverUserVitResponse value)
		{
			RecoverUserVitResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(92)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbItemChange ItemChange { get; set; }

	[MemoryPackOrder(1)]
	public long Vit { get; set; }

	[MemoryPackOrder(2)]
	public long LastVitRecoverTime { get; set; }

	public static RecoverUserVitResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(RecoverUserVitResponse)) as RecoverUserVitResponse;
		}
		return new RecoverUserVitResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ItemChange = null;
			Vit = 0L;
			LastVitRecoverTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static RecoverUserVitResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<RecoverUserVitResponse>())
		{
			MemoryPackFormatterProvider.Register(new RecoverUserVitResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<RecoverUserVitResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<RecoverUserVitResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref RecoverUserVitResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WritePackable<PbItemChange>(value.ItemChange);
		writer.WriteUnmanaged<long, long, int, int>(value.Vit, value.LastVitRecoverTime, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref RecoverUserVitResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbItemChange value3;
		long value4;
		long value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ItemChange;
				value4 = value.Vit;
				value5 = value.LastVitRecoverTime;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0183;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<long, long, int, int>(out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(RecoverUserVitResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ItemChange;
				value4 = value.Vit;
				value5 = value.LastVitRecoverTime;
				value6 = value.RpcId;
				value7 = value.Error;
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
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_0183;
			}
		}
		value = new RecoverUserVitResponse
		{
			IsFromPool = value2,
			ItemChange = value3,
			Vit = value4,
			LastVitRecoverTime = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0183:
		value.IsFromPool = value2;
		value.ItemChange = value3;
		value.Vit = value4;
		value.LastVitRecoverTime = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
