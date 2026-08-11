using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10448)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightChangeModelRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MultiFightChangeModelRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightChangeModelRequestFormatter : MemoryPackFormatter<MultiFightChangeModelRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightChangeModelRequest value)
		{
			MultiFightChangeModelRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightChangeModelRequest value)
		{
			MultiFightChangeModelRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(91)]
	public long UserId { get; set; }

	[MemoryPackOrder(92)]
	public int ServerType { get; set; }

	[MemoryPackOrder(0)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(1)]
	public int CopyId { get; set; }

	[MemoryPackOrder(2)]
	public int RewardTimes { get; set; }

	public static MultiFightChangeModelRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightChangeModelRequest)) as MultiFightChangeModelRequest;
		}
		return new MultiFightChangeModelRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ServerType = 0;
			SelectModel = 0;
			CopyId = 0;
			RewardTimes = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightChangeModelRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightChangeModelRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightChangeModelRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightChangeModelRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightChangeModelRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightChangeModelRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, long, int, long, long, int>(10, value.IsFromPool, value.SelectModel, value.CopyId, value.RewardTimes, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId, value.UserId, value.ServerType);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightChangeModelRequest? value)
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
		long value7;
		int value8;
		long value9;
		long value10;
		int value11;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SelectModel;
				value4 = value.CopyId;
				value5 = value.RewardTimes;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				value10 = value.UserId;
				value11 = value.ServerType;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				goto IL_01f9;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, long, int, long, long, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightChangeModelRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
				value10 = 0L;
				value11 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SelectModel;
				value4 = value.CopyId;
				value5 = value.RewardTimes;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				value10 = value.UserId;
				value11 = value.ServerType;
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
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													_ = 10;
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
				goto IL_01f9;
			}
		}
		value = new MultiFightChangeModelRequest
		{
			IsFromPool = value2,
			SelectModel = value3,
			CopyId = value4,
			RewardTimes = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9,
			UserId = value10,
			ServerType = value11
		};
		return;
		IL_01f9:
		value.IsFromPool = value2;
		value.SelectModel = value3;
		value.CopyId = value4;
		value.RewardTimes = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
		value.UserId = value10;
		value.ServerType = value11;
	}
}
