using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(342)]
[MemoryPackable(GenerateType.Object)]
public class PbMatchResultUserInfo : MessageObject, IMemoryPackable<PbMatchResultUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMatchResultUserInfoFormatter : MemoryPackFormatter<PbMatchResultUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMatchResultUserInfo value)
		{
			PbMatchResultUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMatchResultUserInfo value)
		{
			PbMatchResultUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Icon { get; set; }

	[MemoryPackOrder(2)]
	public string Name { get; set; }

	public static PbMatchResultUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMatchResultUserInfo)) as PbMatchResultUserInfo;
		}
		return new PbMatchResultUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			Icon = 0;
			Name = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMatchResultUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMatchResultUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbMatchResultUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMatchResultUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMatchResultUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMatchResultUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(4, value.IsFromPool, value.UserId, value.Icon);
		writer.WriteString(value.Name);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMatchResultUserInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		string name;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Icon;
				name = value.Name;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				name = reader.ReadString();
				goto IL_00f0;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			name = reader.ReadString();
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMatchResultUserInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				name = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Icon;
				name = value.Name;
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
							name = reader.ReadString();
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f0;
			}
		}
		value = new PbMatchResultUserInfo
		{
			IsFromPool = value2,
			UserId = value3,
			Icon = value4,
			Name = name
		};
		return;
		IL_00f0:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Icon = value4;
		value.Name = name;
	}
}
