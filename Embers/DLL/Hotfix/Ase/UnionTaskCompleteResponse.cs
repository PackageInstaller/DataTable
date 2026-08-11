using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10700)]
[MemoryPackable(GenerateType.Object)]
public class UnionTaskCompleteResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<UnionTaskCompleteResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionTaskCompleteResponseFormatter : MemoryPackFormatter<UnionTaskCompleteResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionTaskCompleteResponse value)
		{
			UnionTaskCompleteResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionTaskCompleteResponse value)
		{
			UnionTaskCompleteResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(1)]
	public PbDropThing Rewards { get; set; }

	[MemoryPackOrder(2)]
	public int ActivePointReward { get; set; }

	[MemoryPackOrder(3)]
	public int UnionActivePointReward { get; set; }

	[MemoryPackOrder(4)]
	public PbItemChange CostItem { get; set; }

	public static UnionTaskCompleteResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionTaskCompleteResponse)) as UnionTaskCompleteResponse;
		}
		return new UnionTaskCompleteResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Rewards = null;
			ActivePointReward = 0;
			UnionActivePointReward = 0;
			CostItem = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionTaskCompleteResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionTaskCompleteResponse>())
		{
			MemoryPackFormatterProvider.Register(new UnionTaskCompleteResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionTaskCompleteResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionTaskCompleteResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionTaskCompleteResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WriteUnmanaged<int, int>(value.ActivePointReward, value.UnionActivePointReward);
		writer.WritePackable<PbItemChange>(value.CostItem);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionTaskCompleteResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		int value4;
		int value5;
		PbItemChange value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.ActivePointReward;
				value5 = value.UnionActivePointReward;
				value6 = value.CostItem;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadPackable(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01b8;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			value6 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionTaskCompleteResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.ActivePointReward;
				value5 = value.UnionActivePointReward;
				value6 = value.CostItem;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
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
				goto IL_01b8;
			}
		}
		value = new UnionTaskCompleteResponse
		{
			IsFromPool = value2,
			Rewards = value3,
			ActivePointReward = value4,
			UnionActivePointReward = value5,
			CostItem = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01b8:
		value.IsFromPool = value2;
		value.Rewards = value3;
		value.ActivePointReward = value4;
		value.UnionActivePointReward = value5;
		value.CostItem = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
