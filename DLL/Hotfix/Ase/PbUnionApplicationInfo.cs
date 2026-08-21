using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(378)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionApplicationInfo : MessageObject, IMemoryPackable<PbUnionApplicationInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionApplicationInfoFormatter : MemoryPackFormatter<PbUnionApplicationInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionApplicationInfo value)
		{
			PbUnionApplicationInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionApplicationInfo value)
		{
			PbUnionApplicationInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Icon { get; set; }

	[MemoryPackOrder(1)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(2)]
	public string Name { get; set; }

	[MemoryPackOrder(3)]
	public int Level { get; set; }

	[MemoryPackOrder(4)]
	public long UserId { get; set; }

	public static PbUnionApplicationInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionApplicationInfo)) as PbUnionApplicationInfo;
		}
		return new PbUnionApplicationInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Icon = 0;
			IconFrame = 0;
			Name = null;
			Level = 0;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionApplicationInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionApplicationInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionApplicationInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionApplicationInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionApplicationInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionApplicationInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(6, value.IsFromPool, value.Icon, value.IconFrame);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, long>(value.Level, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionApplicationInfo? value)
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
		long value6;
		string name;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.IconFrame;
				name = value.Name;
				value5 = value.Level;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionApplicationInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				name = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.IconFrame;
				name = value.Name;
				value5 = value.Level;
				value6 = value.UserId;
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
							name = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0152;
			}
		}
		value = new PbUnionApplicationInfo
		{
			IsFromPool = value2,
			Icon = value3,
			IconFrame = value4,
			Name = name,
			Level = value5,
			UserId = value6
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.Icon = value3;
		value.IconFrame = value4;
		value.Name = name;
		value.Level = value5;
		value.UserId = value6;
	}
}
