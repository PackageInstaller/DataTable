using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(364)]
[MemoryPackable(GenerateType.Object)]
public class PbSailLightDispatchInfo : MessageObject, IMemoryPackable<PbSailLightDispatchInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSailLightDispatchInfoFormatter : MemoryPackFormatter<PbSailLightDispatchInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSailLightDispatchInfo value)
		{
			PbSailLightDispatchInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSailLightDispatchInfo value)
		{
			PbSailLightDispatchInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long Idx { get; set; }

	[MemoryPackOrder(1)]
	public int EventId { get; set; }

	[MemoryPackOrder(2)]
	public long StartTime { get; set; }

	[MemoryPackOrder(3)]
	public List<int> HeroIds { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public int GreatSuccessRate { get; set; }

	[MemoryPackOrder(5)]
	public bool Rewarded { get; set; }

	public static PbSailLightDispatchInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSailLightDispatchInfo)) as PbSailLightDispatchInfo;
		}
		return new PbSailLightDispatchInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Idx = 0L;
			EventId = 0;
			StartTime = 0L;
			HeroIds.Clear();
			GreatSuccessRate = 0;
			Rewarded = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSailLightDispatchInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSailLightDispatchInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSailLightDispatchInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSailLightDispatchInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSailLightDispatchInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSailLightDispatchInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, long>(7, value.IsFromPool, value.Idx, value.EventId, value.StartTime);
		writer.WriteValue<List<int>>(value.HeroIds);
		writer.WriteUnmanaged<int, bool>(value.GreatSuccessRate, value.Rewarded);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSailLightDispatchInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		List<int> value6;
		int value7;
		bool value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Idx;
				value4 = value.EventId;
				value5 = value.StartTime;
				value6 = value.HeroIds;
				value7 = value.GreatSuccessRate;
				value8 = value.Rewarded;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadValue(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<bool>(out value8);
				goto IL_017e;
			}
			reader.ReadUnmanaged<bool, long, int, long>(out value2, out value3, out value4, out value5);
			value6 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, bool>(out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSailLightDispatchInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
				value6 = null;
				value7 = 0;
				value8 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Idx;
				value4 = value.EventId;
				value5 = value.StartTime;
				value6 = value.HeroIds;
				value7 = value.GreatSuccessRate;
				value8 = value.Rewarded;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<bool>(out value8);
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
				goto IL_017e;
			}
		}
		value = new PbSailLightDispatchInfo
		{
			IsFromPool = value2,
			Idx = value3,
			EventId = value4,
			StartTime = value5,
			HeroIds = value6,
			GreatSuccessRate = value7,
			Rewarded = value8
		};
		return;
		IL_017e:
		value.IsFromPool = value2;
		value.Idx = value3;
		value.EventId = value4;
		value.StartTime = value5;
		value.HeroIds = value6;
		value.GreatSuccessRate = value7;
		value.Rewarded = value8;
	}
}
