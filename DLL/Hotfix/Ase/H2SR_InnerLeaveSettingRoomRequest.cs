using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10417)]
[MemoryPackable(GenerateType.Object)]
public class H2SR_InnerLeaveSettingRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2SR_InnerLeaveSettingRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2SR_InnerLeaveSettingRoomRequestFormatter : MemoryPackFormatter<H2SR_InnerLeaveSettingRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2SR_InnerLeaveSettingRoomRequest value)
		{
			H2SR_InnerLeaveSettingRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2SR_InnerLeaveSettingRoomRequest value)
		{
			H2SR_InnerLeaveSettingRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	public static H2SR_InnerLeaveSettingRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2SR_InnerLeaveSettingRoomRequest)) as H2SR_InnerLeaveSettingRoomRequest;
		}
		return new H2SR_InnerLeaveSettingRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2SR_InnerLeaveSettingRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_InnerLeaveSettingRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2SR_InnerLeaveSettingRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2SR_InnerLeaveSettingRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2SR_InnerLeaveSettingRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2SR_InnerLeaveSettingRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.UserId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2SR_InnerLeaveSettingRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2SR_InnerLeaveSettingRoomRequest), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new H2SR_InnerLeaveSettingRoomRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RpcId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RpcId = value4;
	}
}
