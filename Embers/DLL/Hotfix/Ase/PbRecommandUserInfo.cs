using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(382)]
[MemoryPackable(GenerateType.Object)]
public class PbRecommandUserInfo : MessageObject, IMemoryPackable<PbRecommandUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRecommandUserInfoFormatter : MemoryPackFormatter<PbRecommandUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRecommandUserInfo value)
		{
			PbRecommandUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRecommandUserInfo value)
		{
			PbRecommandUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Icon { get; set; }

	[MemoryPackOrder(1)]
	public int Frame { get; set; }

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	[MemoryPackOrder(3)]
	public string Name { get; set; }

	[MemoryPackOrder(4)]
	public long UserId { get; set; }

	public static PbRecommandUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRecommandUserInfo)) as PbRecommandUserInfo;
		}
		return new PbRecommandUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Icon = 0;
			Frame = 0;
			Level = 0;
			Name = null;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRecommandUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRecommandUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRecommandUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRecommandUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRecommandUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRecommandUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(6, value.IsFromPool, value.Icon, value.Frame, value.Level);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<long>(value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRecommandUserInfo? value)
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
				value4 = value.Frame;
				value5 = value.Level;
				name = value.Name;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				name = reader.ReadString();
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			name = reader.ReadString();
			reader.ReadUnmanaged<long>(out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRecommandUserInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				name = null;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Icon;
				value4 = value.Frame;
				value5 = value.Level;
				name = value.Name;
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
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								name = reader.ReadString();
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
		value = new PbRecommandUserInfo
		{
			IsFromPool = value2,
			Icon = value3,
			Frame = value4,
			Level = value5,
			Name = name,
			UserId = value6
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.Icon = value3;
		value.Frame = value4;
		value.Level = value5;
		value.Name = name;
		value.UserId = value6;
	}
}
