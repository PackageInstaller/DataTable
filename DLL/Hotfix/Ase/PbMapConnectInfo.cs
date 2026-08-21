using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(328)]
[MemoryPackable(GenerateType.Object)]
public class PbMapConnectInfo : MessageObject, IMemoryPackable<PbMapConnectInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMapConnectInfoFormatter : MemoryPackFormatter<PbMapConnectInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMapConnectInfo value)
		{
			PbMapConnectInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMapConnectInfo value)
		{
			PbMapConnectInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long UnitId { get; set; }

	[MemoryPackOrder(2)]
	public long Key { get; set; }

	[MemoryPackOrder(3)]
	public int KcpConnectId { get; set; }

	public static PbMapConnectInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMapConnectInfo)) as PbMapConnectInfo;
		}
		return new PbMapConnectInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			UnitId = 0L;
			Key = 0L;
			KcpConnectId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMapConnectInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMapConnectInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbMapConnectInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMapConnectInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMapConnectInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMapConnectInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, long, int>(5, value.IsFromPool, value.UserId, value.UnitId, value.Key, value.KcpConnectId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMapConnectInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		long value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UnitId;
				value5 = value.Key;
				value6 = value.KcpConnectId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_011a;
			}
			reader.ReadUnmanaged<bool, long, long, long, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMapConnectInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UnitId;
				value5 = value.Key;
				value6 = value.KcpConnectId;
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
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011a;
			}
		}
		value = new PbMapConnectInfo
		{
			IsFromPool = value2,
			UserId = value3,
			UnitId = value4,
			Key = value5,
			KcpConnectId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UnitId = value4;
		value.Key = value5;
		value.KcpConnectId = value6;
	}
}
