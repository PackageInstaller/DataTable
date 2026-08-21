using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(40576)]
[MemoryPackable(GenerateType.Object)]
public class GetAchievementRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetAchievementRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetAchievementRewardResponseFormatter : MemoryPackFormatter<GetAchievementRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetAchievementRewardResponse value)
		{
			GetAchievementRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetAchievementRewardResponse value)
		{
			GetAchievementRewardResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int RewardRank { get; set; }

	[MemoryPackOrder(1)]
	public PbDropThing Rewards { get; set; }

	public static GetAchievementRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetAchievementRewardResponse)) as GetAchievementRewardResponse;
		}
		return new GetAchievementRewardResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RewardRank = 0;
			Rewards = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetAchievementRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetAchievementRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetAchievementRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetAchievementRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetAchievementRewardResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetAchievementRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(6, value.IsFromPool, value.RewardRank);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetAchievementRewardResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbDropThing value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RewardRank;
				value4 = value.Rewards;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetAchievementRewardResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RewardRank;
				value4 = value.Rewards;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
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
		value = new GetAchievementRewardResponse
		{
			IsFromPool = value2,
			RewardRank = value3,
			Rewards = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.RewardRank = value3;
		value.Rewards = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
