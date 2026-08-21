using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10592)]
[MemoryPackable(GenerateType.Object)]
public class SailLightDispatchResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<SailLightDispatchResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SailLightDispatchResponseFormatter : MemoryPackFormatter<SailLightDispatchResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SailLightDispatchResponse value)
		{
			SailLightDispatchResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SailLightDispatchResponse value)
		{
			SailLightDispatchResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long Idx { get; set; }

	public static SailLightDispatchResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SailLightDispatchResponse)) as SailLightDispatchResponse;
		}
		return new SailLightDispatchResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Idx = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SailLightDispatchResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SailLightDispatchResponse>())
		{
			MemoryPackFormatterProvider.Register(new SailLightDispatchResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SailLightDispatchResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SailLightDispatchResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SailLightDispatchResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(5, value.IsFromPool, value.Idx, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SailLightDispatchResponse? value)
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
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Idx;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_011e;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SailLightDispatchResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Idx;
				value4 = value.RpcId;
				value5 = value.Error;
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
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011e;
			}
		}
		value = new SailLightDispatchResponse
		{
			IsFromPool = value2,
			Idx = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_011e:
		value.IsFromPool = value2;
		value.Idx = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
