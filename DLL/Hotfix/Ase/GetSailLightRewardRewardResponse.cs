using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10594)]
[MemoryPackable(GenerateType.Object)]
public class GetSailLightRewardRewardResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetSailLightRewardRewardResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetSailLightRewardRewardResponseFormatter : MemoryPackFormatter<GetSailLightRewardRewardResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetSailLightRewardRewardResponse value)
		{
			GetSailLightRewardRewardResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetSailLightRewardRewardResponse value)
		{
			GetSailLightRewardRewardResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public bool GreatSuccess { get; set; }

	[MemoryPackOrder(1)]
	public PbDropThing Rewards { get; set; }

	[MemoryPackOrder(2)]
	public PbDropThing GreatRewards { get; set; }

	public static GetSailLightRewardRewardResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetSailLightRewardRewardResponse)) as GetSailLightRewardRewardResponse;
		}
		return new GetSailLightRewardRewardResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			GreatSuccess = false;
			Rewards = null;
			GreatRewards = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetSailLightRewardRewardResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetSailLightRewardRewardResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetSailLightRewardRewardResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetSailLightRewardRewardResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetSailLightRewardRewardResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetSailLightRewardRewardResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, bool>(7, value.IsFromPool, value.GreatSuccess);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WritePackable<PbDropThing>(value.GreatRewards);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetSailLightRewardRewardResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		bool value3;
		PbDropThing value4;
		PbDropThing value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.GreatSuccess;
				value4 = value.Rewards;
				value5 = value.GreatRewards;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<bool>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0187;
			}
			reader.ReadUnmanaged<bool, bool>(out value2, out value3);
			value4 = reader.ReadPackable<PbDropThing>();
			value5 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, int>(out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetSailLightRewardRewardResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = false;
				value4 = null;
				value5 = null;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.GreatSuccess;
				value4 = value.Rewards;
				value5 = value.GreatRewards;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<bool>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0187;
			}
		}
		value = new GetSailLightRewardRewardResponse
		{
			IsFromPool = value2,
			GreatSuccess = value3,
			Rewards = value4,
			GreatRewards = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0187:
		value.IsFromPool = value2;
		value.GreatSuccess = value3;
		value.Rewards = value4;
		value.GreatRewards = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
