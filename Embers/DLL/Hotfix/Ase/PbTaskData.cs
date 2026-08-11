using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(326)]
[MemoryPackable(GenerateType.Object)]
public class PbTaskData : MessageObject, IMemoryPackable<PbTaskData>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbTaskDataFormatter : MemoryPackFormatter<PbTaskData>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbTaskData value)
		{
			PbTaskData.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbTaskData value)
		{
			PbTaskData.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public long TargetValue { get; set; }

	[MemoryPackOrder(2)]
	public int RewardState { get; set; }

	[MemoryPackOrder(3)]
	public int CompeteState { get; set; }

	[MemoryPackOrder(4)]
	public int Valid { get; set; }

	[MemoryPackOrder(5)]
	public List<string> IndexSaveData { get; set; } = new List<string>();

	public static PbTaskData Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbTaskData)) as PbTaskData;
		}
		return new PbTaskData();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			TaskId = 0;
			TargetValue = 0L;
			RewardState = 0;
			CompeteState = 0;
			Valid = 0;
			IndexSaveData.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbTaskData()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbTaskData>())
		{
			MemoryPackFormatterProvider.Register(new PbTaskDataFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbTaskData[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbTaskData>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbTaskData? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, int, int>(7, value.IsFromPool, value.TaskId, value.TargetValue, value.RewardState, value.CompeteState, value.Valid);
		writer.WriteValue<List<string>>(value.IndexSaveData);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbTaskData? value)
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
		List<string> value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.TargetValue;
				value5 = value.RewardState;
				value6 = value.CompeteState;
				value7 = value.Valid;
				value8 = value.IndexSaveData;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadValue(ref value8);
				goto IL_0177;
			}
			reader.ReadUnmanaged<bool, int, long, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			value8 = reader.ReadValue<List<string>>();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbTaskData), 7, memberCount);
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
				value8 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.TargetValue;
				value5 = value.RewardState;
				value6 = value.CompeteState;
				value7 = value.Valid;
				value8 = value.IndexSaveData;
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
									if (memberCount != 6)
									{
										reader.ReadValue(ref value8);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0177;
			}
		}
		value = new PbTaskData
		{
			IsFromPool = value2,
			TaskId = value3,
			TargetValue = value4,
			RewardState = value5,
			CompeteState = value6,
			Valid = value7,
			IndexSaveData = value8
		};
		return;
		IL_0177:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.TargetValue = value4;
		value.RewardState = value5;
		value.CompeteState = value6;
		value.Valid = value7;
		value.IndexSaveData = value8;
	}
}
