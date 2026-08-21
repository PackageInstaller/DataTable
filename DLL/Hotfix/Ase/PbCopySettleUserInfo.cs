using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(420)]
[MemoryPackable(GenerateType.Object)]
public class PbCopySettleUserInfo : MessageObject, IMemoryPackable<PbCopySettleUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopySettleUserInfoFormatter : MemoryPackFormatter<PbCopySettleUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopySettleUserInfo value)
		{
			PbCopySettleUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopySettleUserInfo value)
		{
			PbCopySettleUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long damage { get; set; }

	public static PbCopySettleUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopySettleUserInfo)) as PbCopySettleUserInfo;
		}
		return new PbCopySettleUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			damage = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopySettleUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopySettleUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopySettleUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopySettleUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopySettleUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopySettleUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long>(3, value.IsFromPool, value.UserId, value.damage);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopySettleUserInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.damage;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00c0;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopySettleUserInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.damage;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c0;
			}
		}
		value = new PbCopySettleUserInfo
		{
			IsFromPool = value2,
			UserId = value3,
			damage = value4
		};
		return;
		IL_00c0:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.damage = value4;
	}
}
