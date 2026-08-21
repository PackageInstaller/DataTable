using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10741)]
[MemoryPackable(GenerateType.Object)]
public class GetManualRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetManualRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetManualRewardResponseFormatter : MemoryPackFormatter<GetManualRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetManualRewardResponse value)
		{
			GetManualRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetManualRewardResponse value)
		{
			GetManualRewardResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbItemChange Reward { get; set; }

	public static GetManualRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetManualRewardResponse)) as GetManualRewardResponse;
		}
		return new GetManualRewardResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Reward = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetManualRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetManualRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetManualRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetManualRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetManualRewardResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetManualRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<PbItemChange>(value.Reward);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetManualRewardResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbItemChange value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Reward;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetManualRewardResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Reward;
				value4 = value.RpcId;
				value5 = value.Error;
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
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_012b;
			}
		}
		value = new GetManualRewardResponse
		{
			IsFromPool = value2,
			Reward = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.Reward = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
