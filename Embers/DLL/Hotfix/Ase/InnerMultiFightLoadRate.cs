using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1072)]
[MemoryPackable(GenerateType.Object)]
public class InnerMultiFightLoadRate : MessageObject, IRequest, IMessage, IMemoryPackable<InnerMultiFightLoadRate>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerMultiFightLoadRateFormatter : MemoryPackFormatter<InnerMultiFightLoadRate>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerMultiFightLoadRate value)
		{
			InnerMultiFightLoadRate.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerMultiFightLoadRate value)
		{
			InnerMultiFightLoadRate.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Rate { get; set; }

	public static InnerMultiFightLoadRate Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerMultiFightLoadRate)) as InnerMultiFightLoadRate;
		}
		return new InnerMultiFightLoadRate();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Rate = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerMultiFightLoadRate()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMultiFightLoadRate>())
		{
			MemoryPackFormatterProvider.Register(new InnerMultiFightLoadRateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMultiFightLoadRate[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerMultiFightLoadRate>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerMultiFightLoadRate? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(4, value.IsFromPool, value.UserId, value.Rate, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerMultiFightLoadRate? value)
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
				value3 = value.UserId;
				value4 = value.Rate;
				value5 = value.RpcId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerMultiFightLoadRate), 4, memberCount);
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
				value3 = value.UserId;
				value4 = value.Rate;
				value5 = value.RpcId;
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
		value = new InnerMultiFightLoadRate
		{
			IsFromPool = value2,
			UserId = value3,
			Rate = value4,
			RpcId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Rate = value4;
		value.RpcId = value5;
	}
}
