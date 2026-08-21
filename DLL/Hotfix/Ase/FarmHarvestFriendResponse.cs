using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10590)]
[MemoryPackable(GenerateType.Object)]
public class FarmHarvestFriendResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<FarmHarvestFriendResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class FarmHarvestFriendResponseFormatter : MemoryPackFormatter<FarmHarvestFriendResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref FarmHarvestFriendResponse value)
		{
			FarmHarvestFriendResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref FarmHarvestFriendResponse value)
		{
			FarmHarvestFriendResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbItemChange Fruit { get; set; }

	[MemoryPackOrder(1)]
	public int GridIdHarvestState { get; set; }

	public static FarmHarvestFriendResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(FarmHarvestFriendResponse)) as FarmHarvestFriendResponse;
		}
		return new FarmHarvestFriendResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Fruit = null;
			GridIdHarvestState = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static FarmHarvestFriendResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<FarmHarvestFriendResponse>())
		{
			MemoryPackFormatterProvider.Register(new FarmHarvestFriendResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<FarmHarvestFriendResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<FarmHarvestFriendResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref FarmHarvestFriendResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbItemChange>(value.Fruit);
		writer.WriteUnmanaged<int, int, int>(value.GridIdHarvestState, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref FarmHarvestFriendResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbItemChange value3;
		int value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Fruit;
				value4 = value.GridIdHarvestState;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(FarmHarvestFriendResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Fruit;
				value4 = value.GridIdHarvestState;
				value5 = value.RpcId;
				value6 = value.Error;
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
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0156;
			}
		}
		value = new FarmHarvestFriendResponse
		{
			IsFromPool = value2,
			Fruit = value3,
			GridIdHarvestState = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.Fruit = value3;
		value.GridIdHarvestState = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
