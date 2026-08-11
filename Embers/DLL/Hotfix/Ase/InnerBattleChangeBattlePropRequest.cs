using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1123)]
[MemoryPackable(GenerateType.Object)]
public class InnerBattleChangeBattlePropRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerBattleChangeBattlePropRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerBattleChangeBattlePropRequestFormatter : MemoryPackFormatter<InnerBattleChangeBattlePropRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerBattleChangeBattlePropRequest value)
		{
			InnerBattleChangeBattlePropRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerBattleChangeBattlePropRequest value)
		{
			InnerBattleChangeBattlePropRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbRoomBattlePropInfo> BattleProp { get; set; } = new List<PbRoomBattlePropInfo>();

	public static InnerBattleChangeBattlePropRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerBattleChangeBattlePropRequest)) as InnerBattleChangeBattlePropRequest;
		}
		return new InnerBattleChangeBattlePropRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			BattleProp.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerBattleChangeBattlePropRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleChangeBattlePropRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerBattleChangeBattlePropRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleChangeBattlePropRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerBattleChangeBattlePropRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRoomBattlePropInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRoomBattlePropInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerBattleChangeBattlePropRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoomBattlePropInfo>>(value.BattleProp));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerBattleChangeBattlePropRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbRoomBattlePropInfo> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BattleProp;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbRoomBattlePropInfo>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerBattleChangeBattlePropRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BattleProp;
				value4 = value.RpcId;
				value5 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new InnerBattleChangeBattlePropRequest
		{
			IsFromPool = value2,
			BattleProp = value3,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.BattleProp = value3;
		value.RpcId = value4;
		value.UserId = value5;
	}
}
