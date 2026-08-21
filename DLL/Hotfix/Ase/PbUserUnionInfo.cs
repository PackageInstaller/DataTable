using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(391)]
[MemoryPackable(GenerateType.Object)]
public class PbUserUnionInfo : MessageObject, IMemoryPackable<PbUserUnionInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUserUnionInfoFormatter : MemoryPackFormatter<PbUserUnionInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUserUnionInfo value)
		{
			PbUserUnionInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUserUnionInfo value)
		{
			PbUserUnionInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Money { get; set; }

	[MemoryPackOrder(1)]
	public int ActivePoint { get; set; }

	[MemoryPackOrder(2)]
	public int WeeklyActivePoint { get; set; }

	public static PbUserUnionInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUserUnionInfo)) as PbUserUnionInfo;
		}
		return new PbUserUnionInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Money = 0;
			ActivePoint = 0;
			WeeklyActivePoint = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUserUnionInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUserUnionInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUserUnionInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUserUnionInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUserUnionInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUserUnionInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.Money, value.ActivePoint, value.WeeklyActivePoint);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUserUnionInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Money;
				value4 = value.ActivePoint;
				value5 = value.WeeklyActivePoint;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUserUnionInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Money;
				value4 = value.ActivePoint;
				value5 = value.WeeklyActivePoint;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new PbUserUnionInfo
		{
			IsFromPool = value2,
			Money = value3,
			ActivePoint = value4,
			WeeklyActivePoint = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.Money = value3;
		value.ActivePoint = value4;
		value.WeeklyActivePoint = value5;
	}
}
