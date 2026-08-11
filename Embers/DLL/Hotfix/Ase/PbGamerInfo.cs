using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(204)]
[MemoryPackable(GenerateType.Object)]
public class PbGamerInfo : MessageObject, IMemoryPackable<PbGamerInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbGamerInfoFormatter : MemoryPackFormatter<PbGamerInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbGamerInfo value)
		{
			PbGamerInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbGamerInfo value)
		{
			PbGamerInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	[MemoryPackOrder(2)]
	public PbRoomRoleInfo Role { get; set; }

	[MemoryPackOrder(3)]
	public int SeatId { get; set; }

	[MemoryPackOrder(4)]
	public int ReadyState { get; set; }

	[MemoryPackOrder(5)]
	public int Icon { get; set; }

	[MemoryPackOrder(6)]
	public long Level { get; set; }

	public static PbGamerInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbGamerInfo)) as PbGamerInfo;
		}
		return new PbGamerInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Name = null;
			Role = null;
			SeatId = 0;
			ReadyState = 0;
			Icon = 0;
			Level = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbGamerInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbGamerInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbGamerInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbGamerInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbGamerInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbGamerInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(9, value.IsFromPool, value.UserId);
		writer.WriteString(value.Name);
		writer.WritePackable<PbRoomRoleInfo>(value.Role);
		writer.WriteUnmanaged<int, int, int, long, int>(value.SeatId, value.ReadyState, value.Icon, value.Level, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbGamerInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbRoomRoleInfo value4;
		int value5;
		int value6;
		int value7;
		long value8;
		int value9;
		string name;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Role;
				value5 = value.SeatId;
				value6 = value.ReadyState;
				value7 = value.Icon;
				value8 = value.Level;
				value9 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				goto IL_01db;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			value4 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<int, int, int, long, int>(out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbGamerInfo), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				name = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Role;
				value5 = value.SeatId;
				value6 = value.ReadyState;
				value7 = value.Icon;
				value8 = value.Level;
				value9 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						name = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												_ = 9;
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01db;
			}
		}
		value = new PbGamerInfo
		{
			IsFromPool = value2,
			UserId = value3,
			Name = name,
			Role = value4,
			SeatId = value5,
			ReadyState = value6,
			Icon = value7,
			Level = value8,
			RpcId = value9
		};
		return;
		IL_01db:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Name = name;
		value.Role = value4;
		value.SeatId = value5;
		value.ReadyState = value6;
		value.Icon = value7;
		value.Level = value8;
		value.RpcId = value9;
	}
}
