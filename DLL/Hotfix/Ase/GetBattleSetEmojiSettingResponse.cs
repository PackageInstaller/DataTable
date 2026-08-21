using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10856)]
[MemoryPackable(GenerateType.Object)]
public class GetBattleSetEmojiSettingResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetBattleSetEmojiSettingResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetBattleSetEmojiSettingResponseFormatter : MemoryPackFormatter<GetBattleSetEmojiSettingResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetBattleSetEmojiSettingResponse value)
		{
			GetBattleSetEmojiSettingResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetBattleSetEmojiSettingResponse value)
		{
			GetBattleSetEmojiSettingResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<int> RoundEmojis { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public List<int> FightEventEmojis { get; set; } = new List<int>();

	public static GetBattleSetEmojiSettingResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetBattleSetEmojiSettingResponse)) as GetBattleSetEmojiSettingResponse;
		}
		return new GetBattleSetEmojiSettingResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			RoundEmojis.Clear();
			FightEventEmojis.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetBattleSetEmojiSettingResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetBattleSetEmojiSettingResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetBattleSetEmojiSettingResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetBattleSetEmojiSettingResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetBattleSetEmojiSettingResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetBattleSetEmojiSettingResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteValue<List<int>>(value.RoundEmojis);
		writer.WriteValue<List<int>>(value.FightEventEmojis);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetBattleSetEmojiSettingResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<int> value3;
		List<int> value4;
		int value5;
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoundEmojis;
				value4 = value.FightEventEmojis;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_015b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			value4 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int>(out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetBattleSetEmojiSettingResponse), 6, memberCount);
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
				value3 = value.RoundEmojis;
				value4 = value.FightEventEmojis;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
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
		value = new GetBattleSetEmojiSettingResponse
		{
			IsFromPool = value2,
			RoundEmojis = value3,
			FightEventEmojis = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_015b:
		value.IsFromPool = value2;
		value.RoundEmojis = value3;
		value.FightEventEmojis = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
