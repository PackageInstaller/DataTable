using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10702)]
[MemoryPackable(GenerateType.Object)]
public class GetPassportRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetPassportRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetPassportRewardResponseFormatter : MemoryPackFormatter<GetPassportRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetPassportRewardResponse value)
		{
			GetPassportRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetPassportRewardResponse value)
		{
			GetPassportRewardResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Rewards { get; set; }

	[MemoryPackOrder(1)]
	public PbIdValue CheckPacksIds { get; set; }

	[MemoryPackOrder(2)]
	public List<PbIdValue> LimitItems { get; set; } = new List<PbIdValue>();

	[MemoryPackOrder(3)]
	public List<PbRewardStateList> LevelMaxRewardState { get; set; } = new List<PbRewardStateList>();

	public static GetPassportRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetPassportRewardResponse)) as GetPassportRewardResponse;
		}
		return new GetPassportRewardResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Rewards = null;
			CheckPacksIds = null;
			LimitItems.Clear();
			LevelMaxRewardState.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetPassportRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetPassportRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetPassportRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetPassportRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetPassportRewardResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbIdValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbIdValue>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRewardStateList>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRewardStateList>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetPassportRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WritePackable<PbIdValue>(value.CheckPacksIds);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbIdValue>>(value.LimitItems));
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRewardStateList>>(value.LevelMaxRewardState));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetPassportRewardResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		PbIdValue value4;
		List<PbIdValue> value5;
		List<PbRewardStateList> value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.CheckPacksIds;
				value5 = value.LimitItems;
				value6 = value.LevelMaxRewardState;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadPackable(ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01bd;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			value4 = reader.ReadPackable<PbIdValue>();
			value5 = ListFormatter.DeserializePackable<PbIdValue>(ref reader);
			value6 = ListFormatter.DeserializePackable<PbRewardStateList>(ref reader);
			reader.ReadUnmanaged<int, int>(out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetPassportRewardResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.CheckPacksIds;
				value5 = value.LimitItems;
				value6 = value.LevelMaxRewardState;
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
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
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
				goto IL_01bd;
			}
		}
		value = new GetPassportRewardResponse
		{
			IsFromPool = value2,
			Rewards = value3,
			CheckPacksIds = value4,
			LimitItems = value5,
			LevelMaxRewardState = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01bd:
		value.IsFromPool = value2;
		value.Rewards = value3;
		value.CheckPacksIds = value4;
		value.LimitItems = value5;
		value.LevelMaxRewardState = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
