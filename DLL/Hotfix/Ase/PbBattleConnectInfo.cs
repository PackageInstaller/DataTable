using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(427)]
[MemoryPackable(GenerateType.Object)]
public class PbBattleConnectInfo : MessageObject, IMemoryPackable<PbBattleConnectInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbBattleConnectInfoFormatter : MemoryPackFormatter<PbBattleConnectInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbBattleConnectInfo value)
		{
			PbBattleConnectInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbBattleConnectInfo value)
		{
			PbBattleConnectInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public string BattleAddress { get; set; }

	[MemoryPackOrder(1)]
	public long LoginKey { get; set; }

	[MemoryPackOrder(2)]
	public int KcpConnectId { get; set; }

	public static PbBattleConnectInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbBattleConnectInfo)) as PbBattleConnectInfo;
		}
		return new PbBattleConnectInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			BattleAddress = null;
			LoginKey = 0L;
			KcpConnectId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbBattleConnectInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleConnectInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbBattleConnectInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleConnectInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbBattleConnectInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbBattleConnectInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WriteString(value.BattleAddress);
		writer.WriteUnmanaged<long, int>(value.LoginKey, value.KcpConnectId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbBattleConnectInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		string battleAddress;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				battleAddress = value.BattleAddress;
				value3 = value.LoginKey;
				value4 = value.KcpConnectId;
				reader.ReadUnmanaged<bool>(out value2);
				battleAddress = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00f3;
			}
			reader.ReadUnmanaged<bool>(out value2);
			battleAddress = reader.ReadString();
			reader.ReadUnmanaged<long, int>(out value3, out value4);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbBattleConnectInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				battleAddress = null;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				battleAddress = value.BattleAddress;
				value3 = value.LoginKey;
				value4 = value.KcpConnectId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					battleAddress = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f3;
			}
		}
		value = new PbBattleConnectInfo
		{
			IsFromPool = value2,
			BattleAddress = battleAddress,
			LoginKey = value3,
			KcpConnectId = value4
		};
		return;
		IL_00f3:
		value.IsFromPool = value2;
		value.BattleAddress = battleAddress;
		value.LoginKey = value3;
		value.KcpConnectId = value4;
	}
}
