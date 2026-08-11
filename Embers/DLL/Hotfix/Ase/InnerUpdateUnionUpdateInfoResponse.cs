using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1095)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpdateUnionUpdateInfoResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerUpdateUnionUpdateInfoResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpdateUnionUpdateInfoResponseFormatter : MemoryPackFormatter<InnerUpdateUnionUpdateInfoResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpdateUnionUpdateInfoResponse value)
		{
			InnerUpdateUnionUpdateInfoResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpdateUnionUpdateInfoResponse value)
		{
			InnerUpdateUnionUpdateInfoResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public int UnionFund { get; set; }

	public static InnerUpdateUnionUpdateInfoResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpdateUnionUpdateInfoResponse)) as InnerUpdateUnionUpdateInfoResponse;
		}
		return new InnerUpdateUnionUpdateInfoResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnionId = 0L;
			UnionFund = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpdateUnionUpdateInfoResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateUnionUpdateInfoResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpdateUnionUpdateInfoResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateUnionUpdateInfoResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpdateUnionUpdateInfoResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpdateUnionUpdateInfoResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int>(6, value.IsFromPool, value.UnionId, value.UnionFund, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpdateUnionUpdateInfoResponse? value)
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
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.UnionFund;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014c;
			}
			reader.ReadUnmanaged<bool, long, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpdateUnionUpdateInfoResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.UnionFund;
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
				goto IL_014c;
			}
		}
		value = new InnerUpdateUnionUpdateInfoResponse
		{
			IsFromPool = value2,
			UnionId = value3,
			UnionFund = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014c:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.UnionFund = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
