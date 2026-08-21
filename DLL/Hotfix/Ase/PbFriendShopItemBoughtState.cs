using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(368)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendShopItemBoughtState : MessageObject, IMemoryPackable<PbFriendShopItemBoughtState>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendShopItemBoughtStateFormatter : MemoryPackFormatter<PbFriendShopItemBoughtState>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendShopItemBoughtState value)
		{
			PbFriendShopItemBoughtState.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendShopItemBoughtState value)
		{
			PbFriendShopItemBoughtState.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int GridId { get; set; }

	[MemoryPackOrder(1)]
	public int BoughtCount { get; set; }

	public static PbFriendShopItemBoughtState Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendShopItemBoughtState)) as PbFriendShopItemBoughtState;
		}
		return new PbFriendShopItemBoughtState();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			GridId = 0;
			BoughtCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendShopItemBoughtState()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopItemBoughtState>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendShopItemBoughtStateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopItemBoughtState[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendShopItemBoughtState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendShopItemBoughtState? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.GridId, value.BoughtCount);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendShopItemBoughtState? value)
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
				value3 = value.GridId;
				value4 = value.BoughtCount;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendShopItemBoughtState), 3, memberCount);
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
				value3 = value.GridId;
				value4 = value.BoughtCount;
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
		value = new PbFriendShopItemBoughtState
		{
			IsFromPool = value2,
			GridId = value3,
			BoughtCount = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.GridId = value3;
		value.BoughtCount = value4;
	}
}
