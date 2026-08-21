using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(384)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionLeaderInfo : MessageObject, IMemoryPackable<PbUnionLeaderInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionLeaderInfoFormatter : MemoryPackFormatter<PbUnionLeaderInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionLeaderInfo value)
		{
			PbUnionLeaderInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionLeaderInfo value)
		{
			PbUnionLeaderInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long LeaderUserId { get; set; }

	[MemoryPackOrder(1)]
	public string LeaderName { get; set; }

	[MemoryPackOrder(2)]
	public int LeaderIcon { get; set; }

	[MemoryPackOrder(3)]
	public int LeaderIconFrame { get; set; }

	[MemoryPackOrder(4)]
	public int LeaderLevel { get; set; }

	public static PbUnionLeaderInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionLeaderInfo)) as PbUnionLeaderInfo;
		}
		return new PbUnionLeaderInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LeaderUserId = 0L;
			LeaderName = null;
			LeaderIcon = 0;
			LeaderIconFrame = 0;
			LeaderLevel = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionLeaderInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionLeaderInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionLeaderInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionLeaderInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionLeaderInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionLeaderInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.LeaderUserId);
		writer.WriteString(value.LeaderName);
		writer.WriteUnmanaged<int, int, int>(value.LeaderIcon, value.LeaderIconFrame, value.LeaderLevel);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionLeaderInfo? value)
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
		int value6;
		string leaderName;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.LeaderUserId;
				leaderName = value.LeaderName;
				value4 = value.LeaderIcon;
				value5 = value.LeaderIconFrame;
				value6 = value.LeaderLevel;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				leaderName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_014f;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			leaderName = reader.ReadString();
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionLeaderInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				leaderName = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.LeaderUserId;
				leaderName = value.LeaderName;
				value4 = value.LeaderIcon;
				value5 = value.LeaderIconFrame;
				value6 = value.LeaderLevel;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						leaderName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014f;
			}
		}
		value = new PbUnionLeaderInfo
		{
			IsFromPool = value2,
			LeaderUserId = value3,
			LeaderName = leaderName,
			LeaderIcon = value4,
			LeaderIconFrame = value5,
			LeaderLevel = value6
		};
		return;
		IL_014f:
		value.IsFromPool = value2;
		value.LeaderUserId = value3;
		value.LeaderName = leaderName;
		value.LeaderIcon = value4;
		value.LeaderIconFrame = value5;
		value.LeaderLevel = value6;
	}
}
