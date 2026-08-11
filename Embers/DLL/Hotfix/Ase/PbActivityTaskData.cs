using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(331)]
[MemoryPackable(GenerateType.Object)]
public class PbActivityTaskData : MessageObject, IMemoryPackable<PbActivityTaskData>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbActivityTaskDataFormatter : MemoryPackFormatter<PbActivityTaskData>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbActivityTaskData value)
		{
			PbActivityTaskData.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbActivityTaskData value)
		{
			PbActivityTaskData.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public long CompeteValue { get; set; }

	[MemoryPackOrder(2)]
	public int RewardState { get; set; }

	[MemoryPackOrder(3)]
	public int CompeteState { get; set; }

	[MemoryPackOrder(4)]
	public int TargetValue { get; set; }

	public static PbActivityTaskData Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbActivityTaskData)) as PbActivityTaskData;
		}
		return new PbActivityTaskData();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			CompeteValue = 0L;
			RewardState = 0;
			CompeteState = 0;
			TargetValue = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbActivityTaskData()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbActivityTaskData>())
		{
			MemoryPackFormatterProvider.Register(new PbActivityTaskDataFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbActivityTaskData[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbActivityTaskData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbActivityTaskData? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, int, int>(6, value.IsFromPool, value.Id, value.CompeteValue, value.RewardState, value.CompeteState, value.TargetValue);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbActivityTaskData? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		int value6;
		int value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.CompeteValue;
				value5 = value.RewardState;
				value6 = value.CompeteState;
				value7 = value.TargetValue;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				goto IL_0146;
			}
			reader.ReadUnmanaged<bool, int, long, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbActivityTaskData), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.CompeteValue;
				value5 = value.RewardState;
				value6 = value.CompeteState;
				value7 = value.TargetValue;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0146;
			}
		}
		value = new PbActivityTaskData
		{
			IsFromPool = value2,
			Id = value3,
			CompeteValue = value4,
			RewardState = value5,
			CompeteState = value6,
			TargetValue = value7
		};
		return;
		IL_0146:
		value.IsFromPool = value2;
		value.Id = value3;
		value.CompeteValue = value4;
		value.RewardState = value5;
		value.CompeteState = value6;
		value.TargetValue = value7;
	}
}
