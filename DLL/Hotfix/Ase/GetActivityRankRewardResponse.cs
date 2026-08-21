using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10310)]
[MemoryPackable(GenerateType.Object)]
public class GetActivityRankRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetActivityRankRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetActivityRankRewardResponseFormatter : MemoryPackFormatter<GetActivityRankRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetActivityRankRewardResponse value)
		{
			GetActivityRankRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetActivityRankRewardResponse value)
		{
			GetActivityRankRewardResponse.Deserialize(ref reader, ref value);
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
	public List<PbActivityRankStateData> RankData { get; set; } = new List<PbActivityRankStateData>();

	public static GetActivityRankRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetActivityRankRewardResponse)) as GetActivityRankRewardResponse;
		}
		return new GetActivityRankRewardResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Rewards = null;
			RankData.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetActivityRankRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetActivityRankRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetActivityRankRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetActivityRankRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetActivityRankRewardResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbActivityRankStateData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbActivityRankStateData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetActivityRankRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Rewards);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbActivityRankStateData>>(value.RankData));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetActivityRankRewardResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		List<PbActivityRankStateData> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.RankData;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			value4 = ListFormatter.DeserializePackable<PbActivityRankStateData>(ref reader);
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetActivityRankRewardResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.RankData;
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
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
				goto IL_015b;
			}
		}
		value = new GetActivityRankRewardResponse
		{
			IsFromPool = value2,
			Rewards = value3,
			RankData = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.Rewards = value3;
		value.RankData = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
