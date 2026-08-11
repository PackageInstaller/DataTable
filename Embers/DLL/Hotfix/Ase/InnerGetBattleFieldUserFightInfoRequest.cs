using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1076)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetBattleFieldUserFightInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerGetBattleFieldUserFightInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetBattleFieldUserFightInfoRequestFormatter : MemoryPackFormatter<InnerGetBattleFieldUserFightInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetBattleFieldUserFightInfoRequest value)
		{
			InnerGetBattleFieldUserFightInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetBattleFieldUserFightInfoRequest value)
		{
			InnerGetBattleFieldUserFightInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public string HallAddress { get; set; }

	public static InnerGetBattleFieldUserFightInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetBattleFieldUserFightInfoRequest)) as InnerGetBattleFieldUserFightInfoRequest;
		}
		return new InnerGetBattleFieldUserFightInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			HallAddress = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetBattleFieldUserFightInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetBattleFieldUserFightInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetBattleFieldUserFightInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetBattleFieldUserFightInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetBattleFieldUserFightInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetBattleFieldUserFightInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WriteString(value.HallAddress);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetBattleFieldUserFightInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		string hallAddress;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				hallAddress = value.HallAddress;
				value3 = value.RpcId;
				value4 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				hallAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00f3;
			}
			reader.ReadUnmanaged<bool>(out value2);
			hallAddress = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value3, out value4);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetBattleFieldUserFightInfoRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				hallAddress = null;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				hallAddress = value.HallAddress;
				value3 = value.RpcId;
				value4 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					hallAddress = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value4);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f3;
			}
		}
		value = new InnerGetBattleFieldUserFightInfoRequest
		{
			IsFromPool = value2,
			HallAddress = hallAddress,
			RpcId = value3,
			UserId = value4
		};
		return;
		IL_00f3:
		value.IsFromPool = value2;
		value.HallAddress = hallAddress;
		value.RpcId = value3;
		value.UserId = value4;
	}
}
