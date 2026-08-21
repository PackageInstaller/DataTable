using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10086)]
[MemoryPackable(GenerateType.Object)]
public class C2S_GameInstanceSettleRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_GameInstanceSettleRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_GameInstanceSettleRequestFormatter : MemoryPackFormatter<C2S_GameInstanceSettleRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_GameInstanceSettleRequest value)
		{
			C2S_GameInstanceSettleRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_GameInstanceSettleRequest value)
		{
			C2S_GameInstanceSettleRequest.Deserialize(ref reader, ref value);
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
	public long CheckCode { get; set; }

	[MemoryPackOrder(1)]
	public PbCopySettleInfo CopySettleInfo { get; set; }

	[MemoryPackOrder(2)]
	public PbCopyBattleInfo CopyBattleInfo { get; set; }

	[MemoryPackOrder(3)]
	public long Score { get; set; }

	public static C2S_GameInstanceSettleRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_GameInstanceSettleRequest)) as C2S_GameInstanceSettleRequest;
		}
		return new C2S_GameInstanceSettleRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			CheckCode = 0L;
			CopySettleInfo = null;
			CopyBattleInfo = null;
			Score = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_GameInstanceSettleRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_GameInstanceSettleRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2S_GameInstanceSettleRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_GameInstanceSettleRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_GameInstanceSettleRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_GameInstanceSettleRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(9, value.IsFromPool, value.CheckCode);
		writer.WritePackable<PbCopySettleInfo>(value.CopySettleInfo);
		writer.WritePackable<PbCopyBattleInfo>(value.CopyBattleInfo);
		writer.WriteUnmanaged<long, int, long, int, long>(value.Score, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_GameInstanceSettleRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbCopySettleInfo value4;
		PbCopyBattleInfo value5;
		long value6;
		int value7;
		long value8;
		int value9;
		long value10;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CheckCode;
				value4 = value.CopySettleInfo;
				value5 = value.CopyBattleInfo;
				value6 = value.Score;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01df;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbCopySettleInfo>();
			value5 = reader.ReadPackable<PbCopyBattleInfo>();
			reader.ReadUnmanaged<long, int, long, int, long>(out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_GameInstanceSettleRequest), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = null;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CheckCode;
				value4 = value.CopySettleInfo;
				value5 = value.CopyBattleInfo;
				value6 = value.Score;
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
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
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
				goto IL_01df;
			}
		}
		value = new C2S_GameInstanceSettleRequest
		{
			IsFromPool = value2,
			CheckCode = value3,
			CopySettleInfo = value4,
			CopyBattleInfo = value5,
			Score = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_01df:
		value.IsFromPool = value2;
		value.CheckCode = value3;
		value.CopySettleInfo = value4;
		value.CopyBattleInfo = value5;
		value.Score = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
