using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10817)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightSinglePlayerStartLoadNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightSinglePlayerStartLoadNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightSinglePlayerStartLoadNotifyFormatter : MemoryPackFormatter<MultiFightSinglePlayerStartLoadNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightSinglePlayerStartLoadNotify value)
		{
			MultiFightSinglePlayerStartLoadNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightSinglePlayerStartLoadNotify value)
		{
			MultiFightSinglePlayerStartLoadNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public PbBattleFiledUserInfo User { get; set; }

	[MemoryPackOrder(1)]
	public long CheckCode { get; set; }

	[MemoryPackOrder(2)]
	public int Seed { get; set; }

	[MemoryPackOrder(3)]
	public long RoomId { get; set; }

	[MemoryPackOrder(4)]
	public int CopyId { get; set; }

	[MemoryPackOrder(5)]
	public int Difficult { get; set; }

	public static MultiFightSinglePlayerStartLoadNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightSinglePlayerStartLoadNotify)) as MultiFightSinglePlayerStartLoadNotify;
		}
		return new MultiFightSinglePlayerStartLoadNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			User = null;
			CheckCode = 0L;
			Seed = 0;
			RoomId = 0L;
			CopyId = 0;
			Difficult = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightSinglePlayerStartLoadNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightSinglePlayerStartLoadNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightSinglePlayerStartLoadNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightSinglePlayerStartLoadNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightSinglePlayerStartLoadNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightSinglePlayerStartLoadNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WritePackable<PbBattleFiledUserInfo>(value.User);
		writer.WriteUnmanaged<long, int, long, int, int, long>(value.CheckCode, value.Seed, value.RoomId, value.CopyId, value.Difficult, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightSinglePlayerStartLoadNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbBattleFiledUserInfo value3;
		long value4;
		int value5;
		long value6;
		int value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.User;
				value4 = value.CheckCode;
				value5 = value.Seed;
				value6 = value.RoomId;
				value7 = value.CopyId;
				value8 = value.Difficult;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbBattleFiledUserInfo>();
			reader.ReadUnmanaged<long, int, long, int, int, long>(out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightSinglePlayerStartLoadNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.User;
				value4 = value.CheckCode;
				value5 = value.Seed;
				value6 = value.RoomId;
				value7 = value.CopyId;
				value8 = value.Difficult;
				value9 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01a9;
			}
		}
		value = new MultiFightSinglePlayerStartLoadNotify
		{
			IsFromPool = value2,
			User = value3,
			CheckCode = value4,
			Seed = value5,
			RoomId = value6,
			CopyId = value7,
			Difficult = value8,
			ActorId = value9
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.User = value3;
		value.CheckCode = value4;
		value.Seed = value5;
		value.RoomId = value6;
		value.CopyId = value7;
		value.Difficult = value8;
		value.ActorId = value9;
	}
}
