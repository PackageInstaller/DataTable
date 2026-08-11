using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10535)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightQuitBattleNotication : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<MultiFightQuitBattleNotication>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightQuitBattleNoticationFormatter : MemoryPackFormatter<MultiFightQuitBattleNotication>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightQuitBattleNotication value)
		{
			MultiFightQuitBattleNotication.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightQuitBattleNotication value)
		{
			MultiFightQuitBattleNotication.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public long ActorId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	public static MultiFightQuitBattleNotication Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightQuitBattleNotication)) as MultiFightQuitBattleNotication;
		}
		return new MultiFightQuitBattleNotication();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			ActorId = 0L;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightQuitBattleNotication()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightQuitBattleNotication>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightQuitBattleNoticationFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightQuitBattleNotication[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightQuitBattleNotication>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightQuitBattleNotication? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, long, long>(5, value.IsFromPool, value.LoginServerId, value.LoginSecretKey, value.ActorId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightQuitBattleNotication? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.ActorId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_011a;
			}
			reader.ReadUnmanaged<bool, int, long, long, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightQuitBattleNotication), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.ActorId;
				value6 = value.UserId;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011a;
			}
		}
		value = new MultiFightQuitBattleNotication
		{
			IsFromPool = value2,
			LoginServerId = value3,
			LoginSecretKey = value4,
			ActorId = value5,
			UserId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.ActorId = value5;
		value.UserId = value6;
	}
}
