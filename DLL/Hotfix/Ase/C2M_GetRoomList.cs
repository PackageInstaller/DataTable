using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10009)]
[MemoryPackable(GenerateType.Object)]
public class C2M_GetRoomList : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2M_GetRoomList>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2M_GetRoomListFormatter : MemoryPackFormatter<C2M_GetRoomList>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2M_GetRoomList value)
		{
			C2M_GetRoomList.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2M_GetRoomList value)
		{
			C2M_GetRoomList.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int MainType { get; set; }

	[MemoryPackOrder(1)]
	public int SubType { get; set; }

	[MemoryPackOrder(2)]
	public int Difficult { get; set; }

	[MemoryPackOrder(3)]
	public bool RefreshData { get; set; }

	public static C2M_GetRoomList Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2M_GetRoomList)) as C2M_GetRoomList;
		}
		return new C2M_GetRoomList();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			MainType = 0;
			SubType = 0;
			Difficult = 0;
			RefreshData = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2M_GetRoomList()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_GetRoomList>())
		{
			MemoryPackFormatterProvider.Register(new C2M_GetRoomListFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_GetRoomList[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2M_GetRoomList>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2M_GetRoomList? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, bool, int, long, int, long>(9, value.IsFromPool, value.MainType, value.SubType, value.Difficult, value.RefreshData, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2M_GetRoomList? value)
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
		bool value6;
		int value7;
		long value8;
		int value9;
		long value10;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MainType;
				value4 = value.SubType;
				value5 = value.Difficult;
				value6 = value.RefreshData;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01cc;
			}
			reader.ReadUnmanaged<bool, int, int, int, bool, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2M_GetRoomList), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = false;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MainType;
				value4 = value.SubType;
				value5 = value.Difficult;
				value6 = value.RefreshData;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
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
								reader.ReadUnmanaged<bool>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												_ = 9;
											}
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
				goto IL_01cc;
			}
		}
		value = new C2M_GetRoomList
		{
			IsFromPool = value2,
			MainType = value3,
			SubType = value4,
			Difficult = value5,
			RefreshData = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_01cc:
		value.IsFromPool = value2;
		value.MainType = value3;
		value.SubType = value4;
		value.Difficult = value5;
		value.RefreshData = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
