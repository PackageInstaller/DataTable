using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(417)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionCopyInfo : MessageObject, IMemoryPackable<PbUnionCopyInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionCopyInfoFormatter : MemoryPackFormatter<PbUnionCopyInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionCopyInfo value)
		{
			PbUnionCopyInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionCopyInfo value)
		{
			PbUnionCopyInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Num { get; set; }

	[MemoryPackOrder(2)]
	public bool PassState { get; set; }

	[MemoryPackOrder(3)]
	public bool RewardState { get; set; }

	public static PbUnionCopyInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionCopyInfo)) as PbUnionCopyInfo;
		}
		return new PbUnionCopyInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Num = 0;
			PassState = false;
			RewardState = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionCopyInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionCopyInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionCopyInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionCopyInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionCopyInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, bool, bool>(5, value.IsFromPool, value.Id, value.Num, value.PassState, value.RewardState);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionCopyInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		bool value5;
		bool value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Num;
				value5 = value.PassState;
				value6 = value.RewardState;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				goto IL_0117;
			}
			reader.ReadUnmanaged<bool, int, int, bool, bool>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionCopyInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = false;
				value6 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Num;
				value5 = value.PassState;
				value6 = value.RewardState;
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
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<bool>(out value6);
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
		value = new PbUnionCopyInfo
		{
			IsFromPool = value2,
			Id = value3,
			Num = value4,
			PassState = value5,
			RewardState = value6
		};
		return;
		IL_0117:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Num = value4;
		value.PassState = value5;
		value.RewardState = value6;
	}
}
