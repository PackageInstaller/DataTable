using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(206)]
[MemoryPackable(GenerateType.Object)]
public class PbSingleRoomInfo : MessageObject, IMemoryPackable<PbSingleRoomInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSingleRoomInfoFormatter : MemoryPackFormatter<PbSingleRoomInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSingleRoomInfo value)
		{
			PbSingleRoomInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSingleRoomInfo value)
		{
			PbSingleRoomInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public int CopyId { get; set; }

	[MemoryPackOrder(4)]
	public int Difficulty { get; set; }

	[MemoryPackOrder(7)]
	public List<PbSingleGamerInfo> SingleGamerInfo { get; set; } = new List<PbSingleGamerInfo>();

	public static PbSingleRoomInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSingleRoomInfo)) as PbSingleRoomInfo;
		}
		return new PbSingleRoomInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoomId = 0L;
			CopyId = 0;
			Difficulty = 0;
			SingleGamerInfo.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSingleRoomInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSingleRoomInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSingleRoomInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSingleRoomInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSingleRoomInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSingleGamerInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSingleGamerInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSingleRoomInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(6, value.IsFromPool, value.RoomId, value.CopyId, value.Difficulty);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSingleGamerInfo>>(value.SingleGamerInfo));
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSingleRoomInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		List<PbSingleGamerInfo> value6;
		int value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.CopyId;
				value5 = value.Difficulty;
				value6 = value.SingleGamerInfo;
				value7 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			value6 = ListFormatter.DeserializePackable<PbSingleGamerInfo>(ref reader);
			reader.ReadUnmanaged<int>(out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSingleRoomInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.CopyId;
				value5 = value.Difficulty;
				value6 = value.SingleGamerInfo;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
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
		value = new PbSingleRoomInfo
		{
			IsFromPool = value2,
			RoomId = value3,
			CopyId = value4,
			Difficulty = value5,
			SingleGamerInfo = value6,
			RpcId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.CopyId = value4;
		value.Difficulty = value5;
		value.SingleGamerInfo = value6;
		value.RpcId = value7;
	}
}
