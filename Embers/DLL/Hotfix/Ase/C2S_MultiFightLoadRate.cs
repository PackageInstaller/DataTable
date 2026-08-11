using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10530)]
[MemoryPackable(GenerateType.Object)]
public class C2S_MultiFightLoadRate : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<C2S_MultiFightLoadRate>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_MultiFightLoadRateFormatter : MemoryPackFormatter<C2S_MultiFightLoadRate>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_MultiFightLoadRate value)
		{
			C2S_MultiFightLoadRate.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_MultiFightLoadRate value)
		{
			C2S_MultiFightLoadRate.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(89)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int Rate { get; set; }

	public static C2S_MultiFightLoadRate Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_MultiFightLoadRate)) as C2S_MultiFightLoadRate;
		}
		return new C2S_MultiFightLoadRate();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			ActorId = 0L;
			UserId = 0L;
			Rate = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_MultiFightLoadRate()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_MultiFightLoadRate>())
		{
			MemoryPackFormatterProvider.Register(new C2S_MultiFightLoadRateFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_MultiFightLoadRate[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_MultiFightLoadRate>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_MultiFightLoadRate? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, long, long>(6, value.IsFromPool, value.Rate, value.LoginServerId, value.LoginSecretKey, value.UserId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_MultiFightLoadRate? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		long value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rate;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.UserId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0148;
			}
			reader.ReadUnmanaged<bool, int, int, long, long, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_MultiFightLoadRate), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0L;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rate;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.UserId;
				value7 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0148;
			}
		}
		value = new C2S_MultiFightLoadRate
		{
			IsFromPool = value2,
			Rate = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			UserId = value6,
			ActorId = value7
		};
		return;
		IL_0148:
		value.IsFromPool = value2;
		value.Rate = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.UserId = value6;
		value.ActorId = value7;
	}
}
