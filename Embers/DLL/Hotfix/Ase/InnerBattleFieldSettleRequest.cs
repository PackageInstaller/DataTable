using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1078)]
[MemoryPackable(GenerateType.Object)]
public class InnerBattleFieldSettleRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerBattleFieldSettleRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerBattleFieldSettleRequestFormatter : MemoryPackFormatter<InnerBattleFieldSettleRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerBattleFieldSettleRequest value)
		{
			InnerBattleFieldSettleRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerBattleFieldSettleRequest value)
		{
			InnerBattleFieldSettleRequest.Deserialize(ref reader, ref value);
		}
	}

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

	public static InnerBattleFieldSettleRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerBattleFieldSettleRequest)) as InnerBattleFieldSettleRequest;
		}
		return new InnerBattleFieldSettleRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			CheckCode = 0L;
			CopySettleInfo = null;
			LeaveHalfway = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerBattleFieldSettleRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleFieldSettleRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerBattleFieldSettleRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleFieldSettleRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerBattleFieldSettleRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerBattleFieldSettleRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.CheckCode);
		writer.WritePackable<PbCopySettleInfo>(value.CopySettleInfo);
		writer.WriteUnmanaged<bool, int, long>(value.LeaveHalfway, value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerBattleFieldSettleRequest? value)
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
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CheckCode;
				value4 = value.CopySettleInfo;
				value5 = value.LeaveHalfway;
				value6 = value.RpcId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbCopySettleInfo>();
			reader.ReadUnmanaged<bool, int, long>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerBattleFieldSettleRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = false;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CheckCode;
				value4 = value.CopySettleInfo;
				value5 = value.LeaveHalfway;
				value6 = value.RpcId;
				value7 = value.UserId;
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
								reader.ReadUnmanaged<int>(out value6);
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
				goto IL_0152;
			}
		}
		value = new InnerBattleFieldSettleRequest
		{
			IsFromPool = value2,
			CheckCode = value3,
			CopySettleInfo = value4,
			LeaveHalfway = value5,
			RpcId = value6,
			UserId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.CheckCode = value3;
		value.CopySettleInfo = value4;
		value.LeaveHalfway = value5;
		value.RpcId = value6;
		value.UserId = value7;
	}
}
