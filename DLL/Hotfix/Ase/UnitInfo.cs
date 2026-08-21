using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5007)]
[MemoryPackable(GenerateType.Object)]
public class UnitInfo : MessageObject, IMemoryPackable<UnitInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnitInfoFormatter : MemoryPackFormatter<UnitInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnitInfo value)
		{
			UnitInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnitInfo value)
		{
			UnitInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UnitId { get; set; }

	[MemoryPackOrder(1)]
	public float X { get; set; }

	[MemoryPackOrder(2)]
	public float Y { get; set; }

	[MemoryPackOrder(3)]
	public float Z { get; set; }

	public static UnitInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnitInfo)) as UnitInfo;
		}
		return new UnitInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UnitId = 0L;
			X = 0f;
			Y = 0f;
			Z = 0f;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnitInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnitInfo>())
		{
			MemoryPackFormatterProvider.Register(new UnitInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnitInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnitInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnitInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, float, float, float>(5, value.IsFromPool, value.UnitId, value.X, value.Y, value.Z);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnitInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		float value4;
		float value5;
		float value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.X;
				value5 = value.Y;
				value6 = value.Z;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<float>(out value4);
				reader.ReadUnmanaged<float>(out value5);
				reader.ReadUnmanaged<float>(out value6);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, long, float, float, float>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnitInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0f;
				value5 = 0f;
				value6 = 0f;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.X;
				value5 = value.Y;
				value6 = value.Z;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<float>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<float>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<float>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0124;
			}
		}
		value = new UnitInfo
		{
			IsFromPool = value2,
			UnitId = value3,
			X = value4,
			Y = value5,
			Z = value6
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.UnitId = value3;
		value.X = value4;
		value.Y = value5;
		value.Z = value6;
	}
}
