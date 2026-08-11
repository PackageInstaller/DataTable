using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(345)]
[MemoryPackable(GenerateType.Object)]
public class PbRankTeamInfo : MessageObject, IMemoryPackable<PbRankTeamInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRankTeamInfoFormatter : MemoryPackFormatter<PbRankTeamInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRankTeamInfo value)
		{
			PbRankTeamInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRankTeamInfo value)
		{
			PbRankTeamInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Rank { get; set; }

	[MemoryPackOrder(1)]
	public long PassTime { get; set; }

	[MemoryPackOrder(2)]
	public List<PbRankUserInfo> Users { get; set; } = new List<PbRankUserInfo>();

	public static PbRankTeamInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRankTeamInfo)) as PbRankTeamInfo;
		}
		return new PbRankTeamInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Rank = 0;
			PassTime = 0L;
			Users.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRankTeamInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRankTeamInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRankTeamInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRankTeamInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRankTeamInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRankUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRankUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRankTeamInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(4, value.IsFromPool, value.Rank, value.PassTime);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRankUserInfo>>(value.Users));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRankTeamInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		List<PbRankUserInfo> value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rank;
				value4 = value.PassTime;
				value5 = value.Users;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				goto IL_00f0;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbRankUserInfo>(ref reader);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRankTeamInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rank;
				value4 = value.PassTime;
				value5 = value.Users;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
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
		value = new PbRankTeamInfo
		{
			IsFromPool = value2,
			Rank = value3,
			PassTime = value4,
			Users = value5
		};
		return;
		IL_00f0:
		value.IsFromPool = value2;
		value.Rank = value3;
		value.PassTime = value4;
		value.Users = value5;
	}
}
