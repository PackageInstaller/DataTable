using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(389)]
[MemoryPackable(GenerateType.Object)]
public class PbState : MessageObject, IMemoryPackable<PbState>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbStateFormatter : MemoryPackFormatter<PbState>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbState value)
		{
			PbState.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbState value)
		{
			PbState.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Value { get; set; }

	[MemoryPackOrder(2)]
	public int State { get; set; }

	public static PbState Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbState)) as PbState;
		}
		return new PbState();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Value = 0;
			State = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbState()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbState>())
		{
			MemoryPackFormatterProvider.Register(new PbStateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbState[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbState>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbState? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.Id, value.Value, value.State);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbState? value)
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
				value4 = value.Value;
				value5 = value.State;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbState), 4, memberCount);
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
				value4 = value.Value;
				value5 = value.State;
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
		value = new PbState
		{
			IsFromPool = value2,
			Id = value3,
			Value = value4,
			State = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Value = value4;
		value.State = value5;
	}
}
