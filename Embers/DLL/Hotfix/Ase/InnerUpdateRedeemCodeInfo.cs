using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1140)]
[MemoryPackable(GenerateType.Object)]
public class InnerUpdateRedeemCodeInfo : MessageObject, IRequest, IMessage, IMemoryPackable<InnerUpdateRedeemCodeInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerUpdateRedeemCodeInfoFormatter : MemoryPackFormatter<InnerUpdateRedeemCodeInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerUpdateRedeemCodeInfo value)
		{
			InnerUpdateRedeemCodeInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerUpdateRedeemCodeInfo value)
		{
			InnerUpdateRedeemCodeInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long DBId { get; set; }

	public static InnerUpdateRedeemCodeInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerUpdateRedeemCodeInfo)) as InnerUpdateRedeemCodeInfo;
		}
		return new InnerUpdateRedeemCodeInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			DBId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerUpdateRedeemCodeInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateRedeemCodeInfo>())
		{
			MemoryPackFormatterProvider.Register(new InnerUpdateRedeemCodeInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerUpdateRedeemCodeInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerUpdateRedeemCodeInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerUpdateRedeemCodeInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.DBId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerUpdateRedeemCodeInfo? value)
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
				value3 = value.DBId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerUpdateRedeemCodeInfo), 3, memberCount);
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
				value3 = value.DBId;
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
		value = new InnerUpdateRedeemCodeInfo
		{
			IsFromPool = value2,
			DBId = value3,
			RpcId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.DBId = value3;
		value.RpcId = value4;
	}
}
