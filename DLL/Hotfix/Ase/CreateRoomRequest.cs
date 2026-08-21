using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10007)]
[MemoryPackable(GenerateType.Object)]
public class CreateRoomRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<CreateRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CreateRoomRequestFormatter : MemoryPackFormatter<CreateRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CreateRoomRequest value)
		{
			CreateRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CreateRoomRequest value)
		{
			CreateRoomRequest.Deserialize(ref reader, ref value);
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
	public int CopyId { get; set; }

	[MemoryPackOrder(2)]
	public int Difficulty { get; set; }

	[MemoryPackOrder(6)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(7)]
	public string ClientVersion { get; set; }

	[MemoryPackOrder(8)]
	public int RewardTimes { get; set; }

	[MemoryPackOrder(9)]
	public int PlayId { get; set; }

	public static CreateRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CreateRoomRequest)) as CreateRoomRequest;
		}
		return new CreateRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			CopyId = 0;
			Difficulty = 0;
			SelectModel = 0;
			ClientVersion = null;
			RewardTimes = 0;
			PlayId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CreateRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CreateRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new CreateRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CreateRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CreateRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref CreateRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(11, value.IsFromPool, value.CopyId, value.Difficulty, value.SelectModel);
		writer.WriteString(value.ClientVersion);
		writer.WriteUnmanaged<int, int, int, long, int, long>(value.RewardTimes, value.PlayId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CreateRoomRequest? value)
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
		int value6;
		int value7;
		int value8;
		long value9;
		int value10;
		long value11;
		string clientVersion;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.SelectModel;
				clientVersion = value.ClientVersion;
				value6 = value.RewardTimes;
				value7 = value.PlayId;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				clientVersion = reader.ReadString();
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_0233;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			clientVersion = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, long, int, long>(out value6, out value7, out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CreateRoomRequest), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				clientVersion = null;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.SelectModel;
				clientVersion = value.ClientVersion;
				value6 = value.RewardTimes;
				value7 = value.PlayId;
				value8 = value.LoginServerId;
				value9 = value.LoginSecretKey;
				value10 = value.RpcId;
				value11 = value.ActorId;
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
								clientVersion = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value10);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value11);
														_ = 11;
													}
												}
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
				goto IL_0233;
			}
		}
		value = new CreateRoomRequest
		{
			IsFromPool = value2,
			CopyId = value3,
			Difficulty = value4,
			SelectModel = value5,
			ClientVersion = clientVersion,
			RewardTimes = value6,
			PlayId = value7,
			LoginServerId = value8,
			LoginSecretKey = value9,
			RpcId = value10,
			ActorId = value11
		};
		return;
		IL_0233:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Difficulty = value4;
		value.SelectModel = value5;
		value.ClientVersion = clientVersion;
		value.RewardTimes = value6;
		value.PlayId = value7;
		value.LoginServerId = value8;
		value.LoginSecretKey = value9;
		value.RpcId = value10;
		value.ActorId = value11;
	}
}
