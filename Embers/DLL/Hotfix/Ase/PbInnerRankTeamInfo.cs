using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1058)]
[MemoryPackable(GenerateType.Object)]
public class PbInnerRankTeamInfo : MessageObject, IMemoryPackable<PbInnerRankTeamInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbInnerRankTeamInfoFormatter : MemoryPackFormatter<PbInnerRankTeamInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbInnerRankTeamInfo value)
		{
			PbInnerRankTeamInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbInnerRankTeamInfo value)
		{
			PbInnerRankTeamInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string UserName { get; set; }

	[MemoryPackOrder(2)]
	public int RoleId { get; set; }

	public static PbInnerRankTeamInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbInnerRankTeamInfo)) as PbInnerRankTeamInfo;
		}
		return new PbInnerRankTeamInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			UserName = null;
			RoleId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbInnerRankTeamInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbInnerRankTeamInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbInnerRankTeamInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbInnerRankTeamInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbInnerRankTeamInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbInnerRankTeamInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.UserId);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int>(value.RoleId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbInnerRankTeamInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		string userName;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.RoleId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00f3;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int>(out value4);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbInnerRankTeamInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				userName = null;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				userName = value.UserName;
				value4 = value.RoleId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						userName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f3;
			}
		}
		value = new PbInnerRankTeamInfo
		{
			IsFromPool = value2,
			UserId = value3,
			UserName = userName,
			RoleId = value4
		};
		return;
		IL_00f3:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserName = userName;
		value.RoleId = value4;
	}
}
