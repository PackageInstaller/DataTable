using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(371)]
[MemoryPackable(GenerateType.Object)]
public class PbPermitTask : MessageObject, IMemoryPackable<PbPermitTask>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbPermitTaskFormatter : MemoryPackFormatter<PbPermitTask>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbPermitTask value)
		{
			PbPermitTask.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbPermitTask value)
		{
			PbPermitTask.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public int TaskValue { get; set; }

	public static PbPermitTask Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbPermitTask)) as PbPermitTask;
		}
		return new PbPermitTask();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			TaskId = 0;
			TaskValue = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbPermitTask()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbPermitTask>())
		{
			MemoryPackFormatterProvider.Register(new PbPermitTaskFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbPermitTask[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbPermitTask>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbPermitTask? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.TaskId, value.TaskValue);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbPermitTask? value)
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
				value3 = value.TaskId;
				value4 = value.TaskValue;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbPermitTask), 3, memberCount);
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
				value3 = value.TaskId;
				value4 = value.TaskValue;
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
		value = new PbPermitTask
		{
			IsFromPool = value2,
			TaskId = value3,
			TaskValue = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.TaskValue = value4;
	}
}
