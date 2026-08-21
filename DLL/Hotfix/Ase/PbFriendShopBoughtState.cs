using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(369)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendShopBoughtState : MessageObject, IMemoryPackable<PbFriendShopBoughtState>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendShopBoughtStateFormatter : MemoryPackFormatter<PbFriendShopBoughtState>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendShopBoughtState value)
		{
			PbFriendShopBoughtState.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendShopBoughtState value)
		{
			PbFriendShopBoughtState.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long FriendId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbFriendShopItemBoughtState> BoughtState { get; set; } = new List<PbFriendShopItemBoughtState>();

	public static PbFriendShopBoughtState Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendShopBoughtState)) as PbFriendShopBoughtState;
		}
		return new PbFriendShopBoughtState();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			FriendId = 0L;
			BoughtState.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendShopBoughtState()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopBoughtState>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendShopBoughtStateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendShopBoughtState[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendShopBoughtState>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendShopItemBoughtState>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendShopItemBoughtState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendShopBoughtState? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(3, value.IsFromPool, value.FriendId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendShopItemBoughtState>>(value.BoughtState));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendShopBoughtState? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbFriendShopItemBoughtState> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.BoughtState;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				goto IL_00c4;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbFriendShopItemBoughtState>(ref reader);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendShopBoughtState), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.BoughtState;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c4;
			}
		}
		value = new PbFriendShopBoughtState
		{
			IsFromPool = value2,
			FriendId = value3,
			BoughtState = value4
		};
		return;
		IL_00c4:
		value.IsFromPool = value2;
		value.FriendId = value3;
		value.BoughtState = value4;
	}
}
