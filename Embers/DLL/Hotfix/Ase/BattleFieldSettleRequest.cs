using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10151)]
[MemoryPackable(GenerateType.Object)]
public class BattleFieldSettleRequest : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<BattleFieldSettleRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleFieldSettleRequestFormatter : MemoryPackFormatter<BattleFieldSettleRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleFieldSettleRequest value)
		{
			BattleFieldSettleRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleFieldSettleRequest value)
		{
			BattleFieldSettleRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long CheckCode { get; set; }

	[MemoryPackOrder(1)]
	public PbCopySettleInfo CopySettleInfo { get; set; }

	[MemoryPackOrder(2)]
	public bool LeaveHalfway { get; set; }

	[MemoryPackOrder(3)]
	public PbCopyBattleInfo CopyBattleInfo { get; set; }

	public static BattleFieldSettleRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleFieldSettleRequest)) as BattleFieldSettleRequest;
		}
		return new BattleFieldSettleRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			UserId = 0L;
			CheckCode = 0L;
			CopySettleInfo = null;
			LeaveHalfway = false;
			CopyBattleInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleFieldSettleRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldSettleRequest>())
		{
			MemoryPackFormatterProvider.Register(new BattleFieldSettleRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldSettleRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleFieldSettleRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleFieldSettleRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(9, value.IsFromPool, value.CheckCode);
		writer.WritePackable<PbCopySettleInfo>(value.CopySettleInfo);
		writer.WriteUnmanaged<bool>(value.LeaveHalfway);
		writer.WritePackable<PbCopyBattleInfo>(value.CopyBattleInfo);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleFieldSettleRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbCopySettleInfo value4;
		bool value5;
		PbCopyBattleInfo value6;
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
				value5 = value.LeaveHalfway;
				value6 = value.CopyBattleInfo;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadPackable(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01e4;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbCopySettleInfo>();
			reader.ReadUnmanaged<bool>(out value5);
			value6 = reader.ReadPackable<PbCopyBattleInfo>();
			reader.ReadUnmanaged<int, long, int, long>(out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleFieldSettleRequest), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = false;
				value6 = null;
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
				value5 = value.LeaveHalfway;
				value6 = value.CopyBattleInfo;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.UserId;
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
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
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
				goto IL_01e4;
			}
		}
		value = new BattleFieldSettleRequest
		{
			IsFromPool = value2,
			CheckCode = value3,
			CopySettleInfo = value4,
			LeaveHalfway = value5,
			CopyBattleInfo = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			UserId = value10
		};
		return;
		IL_01e4:
		value.IsFromPool = value2;
		value.CheckCode = value3;
		value.CopySettleInfo = value4;
		value.LeaveHalfway = value5;
		value.CopyBattleInfo = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.UserId = value10;
	}
}
