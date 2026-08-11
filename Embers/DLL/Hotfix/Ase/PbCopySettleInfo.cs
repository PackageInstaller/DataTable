using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(333)]
[MemoryPackable(GenerateType.Object)]
public class PbCopySettleInfo : MessageObject, IMemoryPackable<PbCopySettleInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopySettleInfoFormatter : MemoryPackFormatter<PbCopySettleInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopySettleInfo value)
		{
			PbCopySettleInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopySettleInfo value)
		{
			PbCopySettleInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int PassTime { get; set; }

	[MemoryPackOrder(1)]
	public int Deaths { get; set; }

	[MemoryPackOrder(2)]
	public float BossHPLeft { get; set; }

	[MemoryPackOrder(3)]
	public int SettleMode { get; set; }

	[MemoryPackOrder(4)]
	public int MonsterKillCount { get; set; }

	[MemoryPackOrder(5)]
	public List<PbCopySettleUserInfo> UserInfos { get; set; } = new List<PbCopySettleUserInfo>();

	public static PbCopySettleInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopySettleInfo)) as PbCopySettleInfo;
		}
		return new PbCopySettleInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			PassTime = 0;
			Deaths = 0;
			BossHPLeft = 0f;
			SettleMode = 0;
			MonsterKillCount = 0;
			UserInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopySettleInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopySettleInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopySettleInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopySettleInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopySettleInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopySettleUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopySettleUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopySettleInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, float, int, int>(7, value.IsFromPool, value.PassTime, value.Deaths, value.BossHPLeft, value.SettleMode, value.MonsterKillCount);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopySettleUserInfo>>(value.UserInfos));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopySettleInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		float value5;
		int value6;
		int value7;
		List<PbCopySettleUserInfo> value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PassTime;
				value4 = value.Deaths;
				value5 = value.BossHPLeft;
				value6 = value.SettleMode;
				value7 = value.MonsterKillCount;
				value8 = value.UserInfos;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<float>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				ListFormatter.DeserializePackable(ref reader, ref value8);
				goto IL_017a;
			}
			reader.ReadUnmanaged<bool, int, int, float, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			value8 = ListFormatter.DeserializePackable<PbCopySettleUserInfo>(ref reader);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopySettleInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0f;
				value6 = 0;
				value7 = 0;
				value8 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PassTime;
				value4 = value.Deaths;
				value5 = value.BossHPLeft;
				value6 = value.SettleMode;
				value7 = value.MonsterKillCount;
				value8 = value.UserInfos;
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
							reader.ReadUnmanaged<float>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										ListFormatter.DeserializePackable(ref reader, ref value8);
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
				goto IL_017a;
			}
		}
		value = new PbCopySettleInfo
		{
			IsFromPool = value2,
			PassTime = value3,
			Deaths = value4,
			BossHPLeft = value5,
			SettleMode = value6,
			MonsterKillCount = value7,
			UserInfos = value8
		};
		return;
		IL_017a:
		value.IsFromPool = value2;
		value.PassTime = value3;
		value.Deaths = value4;
		value.BossHPLeft = value5;
		value.SettleMode = value6;
		value.MonsterKillCount = value7;
		value.UserInfos = value8;
	}
}
