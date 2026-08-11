using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(377)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionUpdateInfo : MessageObject, IMemoryPackable<PbUnionUpdateInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionUpdateInfoFormatter : MemoryPackFormatter<PbUnionUpdateInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionUpdateInfo value)
		{
			PbUnionUpdateInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionUpdateInfo value)
		{
			PbUnionUpdateInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ActivePoint { get; set; }

	[MemoryPackOrder(1)]
	public int WeeklyActivePoint { get; set; }

	[MemoryPackOrder(2)]
	public int Money { get; set; }

	public static PbUnionUpdateInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionUpdateInfo)) as PbUnionUpdateInfo;
		}
		return new PbUnionUpdateInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActivePoint = 0;
			WeeklyActivePoint = 0;
			Money = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionUpdateInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionUpdateInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionUpdateInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionUpdateInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionUpdateInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionUpdateInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.ActivePoint, value.WeeklyActivePoint, value.Money);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionUpdateInfo? value)
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
				value3 = value.ActivePoint;
				value4 = value.WeeklyActivePoint;
				value5 = value.Money;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionUpdateInfo), 4, memberCount);
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
				value3 = value.ActivePoint;
				value4 = value.WeeklyActivePoint;
				value5 = value.Money;
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
		value = new PbUnionUpdateInfo
		{
			IsFromPool = value2,
			ActivePoint = value3,
			WeeklyActivePoint = value4,
			Money = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.ActivePoint = value3;
		value.WeeklyActivePoint = value4;
		value.Money = value5;
	}
}
