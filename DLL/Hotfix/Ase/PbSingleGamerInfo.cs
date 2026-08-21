using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(210)]
[MemoryPackable(GenerateType.Object)]
public class PbSingleGamerInfo : MessageObject, IMemoryPackable<PbSingleGamerInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSingleGamerInfoFormatter : MemoryPackFormatter<PbSingleGamerInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSingleGamerInfo value)
		{
			PbSingleGamerInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSingleGamerInfo value)
		{
			PbSingleGamerInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long SeatId { get; set; }

	[MemoryPackOrder(2)]
	public string Name { get; set; }

	[MemoryPackOrder(3)]
	public int Icon { get; set; }

	[MemoryPackOrder(4)]
	public int Level { get; set; }

	public static PbSingleGamerInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSingleGamerInfo)) as PbSingleGamerInfo;
		}
		return new PbSingleGamerInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			SeatId = 0L;
			Name = null;
			Icon = 0;
			Level = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSingleGamerInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSingleGamerInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSingleGamerInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSingleGamerInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSingleGamerInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSingleGamerInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(7, value.IsFromPool, value.UserId, value.SeatId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int, int>(value.Icon, value.Level, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSingleGamerInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		int value6;
		int value7;
		string name;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SeatId;
				name = value.Name;
				value5 = value.Icon;
				value6 = value.Level;
				value7 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_017e;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int, int>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSingleGamerInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				name = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SeatId;
				name = value.Name;
				value5 = value.Icon;
				value6 = value.Level;
				value7 = value.RpcId;
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
							name = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_017e;
			}
		}
		value = new PbSingleGamerInfo
		{
			IsFromPool = value2,
			UserId = value3,
			SeatId = value4,
			Name = name,
			Icon = value5,
			Level = value6,
			RpcId = value7
		};
		return;
		IL_017e:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.SeatId = value4;
		value.Name = name;
		value.Icon = value5;
		value.Level = value6;
		value.RpcId = value7;
	}
}
