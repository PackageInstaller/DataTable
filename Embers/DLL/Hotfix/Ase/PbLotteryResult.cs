using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(348)]
[MemoryPackable(GenerateType.Object)]
public class PbLotteryResult : MessageObject, IMemoryPackable<PbLotteryResult>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbLotteryResultFormatter : MemoryPackFormatter<PbLotteryResult>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbLotteryResult value)
		{
			PbLotteryResult.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbLotteryResult value)
		{
			PbLotteryResult.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ConfigId { get; set; }

	[MemoryPackOrder(1)]
	public int ConfigIndex { get; set; }

	[MemoryPackOrder(2)]
	public List<PbItemBase> DrawRusult { get; set; } = new List<PbItemBase>();

	[MemoryPackOrder(3)]
	public List<PbItemBase> RealResult { get; set; } = new List<PbItemBase>();

	[MemoryPackOrder(4)]
	public List<PbItemBase> ByProduct { get; set; } = new List<PbItemBase>();

	public static PbLotteryResult Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbLotteryResult)) as PbLotteryResult;
		}
		return new PbLotteryResult();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ConfigId = 0;
			ConfigIndex = 0;
			DrawRusult.Clear();
			RealResult.Clear();
			ByProduct.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbLotteryResult()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbLotteryResult>())
		{
			MemoryPackFormatterProvider.Register(new PbLotteryResultFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbLotteryResult[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbLotteryResult>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItemBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItemBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbLotteryResult? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(6, value.IsFromPool, value.ConfigId, value.ConfigIndex);
		List<PbItemBase> source = value.DrawRusult;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.RealResult;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.ByProduct;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbLotteryResult? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<PbItemBase> value5;
		List<PbItemBase> value6;
		List<PbItemBase> value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ConfigId;
				value4 = value.ConfigIndex;
				value5 = value.DrawRusult;
				value6 = value.RealResult;
				value7 = value.ByProduct;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				goto IL_0157;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbItemBase>(ref reader);
			value6 = ListFormatter.DeserializePackable<PbItemBase>(ref reader);
			value7 = ListFormatter.DeserializePackable<PbItemBase>(ref reader);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbLotteryResult), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ConfigId;
				value4 = value.ConfigIndex;
				value5 = value.DrawRusult;
				value6 = value.RealResult;
				value7 = value.ByProduct;
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
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0157;
			}
		}
		value = new PbLotteryResult
		{
			IsFromPool = value2,
			ConfigId = value3,
			ConfigIndex = value4,
			DrawRusult = value5,
			RealResult = value6,
			ByProduct = value7
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.ConfigId = value3;
		value.ConfigIndex = value4;
		value.DrawRusult = value5;
		value.RealResult = value6;
		value.ByProduct = value7;
	}
}
