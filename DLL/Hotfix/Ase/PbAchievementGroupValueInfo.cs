using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(363)]
[MemoryPackable(GenerateType.Object)]
public class PbAchievementGroupValueInfo : MessageObject, IMemoryPackable<PbAchievementGroupValueInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbAchievementGroupValueInfoFormatter : MemoryPackFormatter<PbAchievementGroupValueInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbAchievementGroupValueInfo value)
		{
			PbAchievementGroupValueInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbAchievementGroupValueInfo value)
		{
			PbAchievementGroupValueInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Value { get; set; }

	public static PbAchievementGroupValueInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbAchievementGroupValueInfo)) as PbAchievementGroupValueInfo;
		}
		return new PbAchievementGroupValueInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Value = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbAchievementGroupValueInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbAchievementGroupValueInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbAchievementGroupValueInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbAchievementGroupValueInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbAchievementGroupValueInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbAchievementGroupValueInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.Id, value.Value);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbAchievementGroupValueInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00be;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbAchievementGroupValueInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00be;
			}
		}
		value = new PbAchievementGroupValueInfo
		{
			IsFromPool = value2,
			Id = value3,
			Value = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Value = value4;
	}
}
