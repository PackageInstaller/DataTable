using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(397)]
[MemoryPackable(GenerateType.Object)]
public class PbUpdateSuitboxCopyRankInfo : MessageObject, IMemoryPackable<PbUpdateSuitboxCopyRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUpdateSuitboxCopyRankInfoFormatter : MemoryPackFormatter<PbUpdateSuitboxCopyRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUpdateSuitboxCopyRankInfo value)
		{
			PbUpdateSuitboxCopyRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUpdateSuitboxCopyRankInfo value)
		{
			PbUpdateSuitboxCopyRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Score { get; set; }

	[MemoryPackOrder(2)]
	public string Name { get; set; }

	[MemoryPackOrder(3)]
	public int Icon { get; set; }

	[MemoryPackOrder(4)]
	public int Title { get; set; }

	[MemoryPackOrder(5)]
	public List<int> RoleIds { get; set; } = new List<int>();

	public static PbUpdateSuitboxCopyRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUpdateSuitboxCopyRankInfo)) as PbUpdateSuitboxCopyRankInfo;
		}
		return new PbUpdateSuitboxCopyRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			Score = 0;
			Name = null;
			Icon = 0;
			Title = 0;
			RoleIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUpdateSuitboxCopyRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUpdateSuitboxCopyRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUpdateSuitboxCopyRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUpdateSuitboxCopyRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUpdateSuitboxCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUpdateSuitboxCopyRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(7, value.IsFromPool, value.UserId, value.Score);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int>(value.Icon, value.Title);
		writer.WriteValue<List<int>>(value.RoleIds);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUpdateSuitboxCopyRankInfo? value)
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
		List<int> value7;
		string name;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Score;
				name = value.Name;
				value5 = value.Icon;
				value6 = value.Title;
				value7 = value.RoleIds;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadValue(ref value7);
				goto IL_0183;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			value7 = reader.ReadValue<List<int>>();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUpdateSuitboxCopyRankInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				name = null;
				value5 = 0;
				value6 = 0;
				value7 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Score;
				name = value.Name;
				value5 = value.Icon;
				value6 = value.Title;
				value7 = value.RoleIds;
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
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadValue(ref value7);
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
				goto IL_0183;
			}
		}
		value = new PbUpdateSuitboxCopyRankInfo
		{
			IsFromPool = value2,
			UserId = value3,
			Score = value4,
			Name = name,
			Icon = value5,
			Title = value6,
			RoleIds = value7
		};
		return;
		IL_0183:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Score = value4;
		value.Name = name;
		value.Icon = value5;
		value.Title = value6;
		value.RoleIds = value7;
	}
}
