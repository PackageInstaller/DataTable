using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(370)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendFarmGridState : MessageObject, IMemoryPackable<PbFriendFarmGridState>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendFarmGridStateFormatter : MemoryPackFormatter<PbFriendFarmGridState>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendFarmGridState value)
		{
			PbFriendFarmGridState.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendFarmGridState value)
		{
			PbFriendFarmGridState.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long FriendId { get; set; }

	[MemoryPackOrder(1)]
	public int GridIdHarvestState { get; set; }

	[MemoryPackOrder(2)]
	public int GridIdIncreaseState { get; set; }

	public static PbFriendFarmGridState Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendFarmGridState)) as PbFriendFarmGridState;
		}
		return new PbFriendFarmGridState();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			FriendId = 0L;
			GridIdHarvestState = 0;
			GridIdIncreaseState = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendFarmGridState()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendFarmGridState>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendFarmGridStateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendFarmGridState[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendFarmGridState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendFarmGridState? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(4, value.IsFromPool, value.FriendId, value.GridIdHarvestState, value.GridIdIncreaseState);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendFarmGridState? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.GridIdHarvestState;
				value5 = value.GridIdIncreaseState;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendFarmGridState), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.GridIdHarvestState;
				value5 = value.GridIdIncreaseState;
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
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ea;
			}
		}
		value = new PbFriendFarmGridState
		{
			IsFromPool = value2,
			FriendId = value3,
			GridIdHarvestState = value4,
			GridIdIncreaseState = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.FriendId = value3;
		value.GridIdHarvestState = value4;
		value.GridIdIncreaseState = value5;
	}
}
