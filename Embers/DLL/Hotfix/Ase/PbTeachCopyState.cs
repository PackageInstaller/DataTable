using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(355)]
[MemoryPackable(GenerateType.Object)]
public class PbTeachCopyState : MessageObject, IMemoryPackable<PbTeachCopyState>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbTeachCopyStateFormatter : MemoryPackFormatter<PbTeachCopyState>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbTeachCopyState value)
		{
			PbTeachCopyState.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbTeachCopyState value)
		{
			PbTeachCopyState.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Reached { get; set; }

	[MemoryPackOrder(2)]
	public int Rewarded { get; set; }

	public static PbTeachCopyState Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbTeachCopyState)) as PbTeachCopyState;
		}
		return new PbTeachCopyState();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Reached = 0;
			Rewarded = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbTeachCopyState()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbTeachCopyState>())
		{
			MemoryPackFormatterProvider.Register(new PbTeachCopyStateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbTeachCopyState[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbTeachCopyState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbTeachCopyState? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.Id, value.Reached, value.Rewarded);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbTeachCopyState? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Reached;
				value5 = value.Rewarded;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbTeachCopyState), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Reached;
				value5 = value.Rewarded;
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
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new PbTeachCopyState
		{
			IsFromPool = value2,
			Id = value3,
			Reached = value4,
			Rewarded = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Reached = value4;
		value.Rewarded = value5;
	}
}
