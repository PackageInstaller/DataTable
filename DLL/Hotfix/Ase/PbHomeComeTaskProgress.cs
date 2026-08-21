using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(430)]
[MemoryPackable(GenerateType.Object)]
public class PbHomeComeTaskProgress : MessageObject, IMemoryPackable<PbHomeComeTaskProgress>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbHomeComeTaskProgressFormatter : MemoryPackFormatter<PbHomeComeTaskProgress>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbHomeComeTaskProgress value)
		{
			PbHomeComeTaskProgress.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbHomeComeTaskProgress value)
		{
			PbHomeComeTaskProgress.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Progress { get; set; }

	[MemoryPackOrder(2)]
	public int TargetValue { get; set; }

	[MemoryPackOrder(3)]
	public int State { get; set; }

	public static PbHomeComeTaskProgress Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbHomeComeTaskProgress)) as PbHomeComeTaskProgress;
		}
		return new PbHomeComeTaskProgress();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Progress = 0;
			TargetValue = 0;
			State = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbHomeComeTaskProgress()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbHomeComeTaskProgress>())
		{
			MemoryPackFormatterProvider.Register(new PbHomeComeTaskProgressFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbHomeComeTaskProgress[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbHomeComeTaskProgress>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbHomeComeTaskProgress? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(5, value.IsFromPool, value.Id, value.Progress, value.TargetValue, value.State);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbHomeComeTaskProgress? value)
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
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Progress;
				value5 = value.TargetValue;
				value6 = value.State;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0117;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbHomeComeTaskProgress), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Progress;
				value5 = value.TargetValue;
				value6 = value.State;
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
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0117;
			}
		}
		value = new PbHomeComeTaskProgress
		{
			IsFromPool = value2,
			Id = value3,
			Progress = value4,
			TargetValue = value5,
			State = value6
		};
		return;
		IL_0117:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Progress = value4;
		value.TargetValue = value5;
		value.State = value6;
	}
}
