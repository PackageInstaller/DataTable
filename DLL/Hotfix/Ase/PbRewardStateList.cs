using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(399)]
[MemoryPackable(GenerateType.Object)]
public class PbRewardStateList : MessageObject, IMemoryPackable<PbRewardStateList>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRewardStateListFormatter : MemoryPackFormatter<PbRewardStateList>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRewardStateList value)
		{
			PbRewardStateList.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRewardStateList value)
		{
			PbRewardStateList.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public int RewardState { get; set; }

	public static PbRewardStateList Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRewardStateList)) as PbRewardStateList;
		}
		return new PbRewardStateList();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			RewardState = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRewardStateList()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRewardStateList>())
		{
			MemoryPackFormatterProvider.Register(new PbRewardStateListFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRewardStateList[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRewardStateList>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRewardStateList? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.Type, value.RewardState);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRewardStateList? value)
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
				value3 = value.Type;
				value4 = value.RewardState;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRewardStateList), 3, memberCount);
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
				value3 = value.Type;
				value4 = value.RewardState;
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
		value = new PbRewardStateList
		{
			IsFromPool = value2,
			Type = value3,
			RewardState = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.Type = value3;
		value.RewardState = value4;
	}
}
