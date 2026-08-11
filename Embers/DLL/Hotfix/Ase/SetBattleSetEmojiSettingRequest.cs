using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10857)]
[MemoryPackable(GenerateType.Object)]
public class SetBattleSetEmojiSettingRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<SetBattleSetEmojiSettingRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SetBattleSetEmojiSettingRequestFormatter : MemoryPackFormatter<SetBattleSetEmojiSettingRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SetBattleSetEmojiSettingRequest value)
		{
			SetBattleSetEmojiSettingRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SetBattleSetEmojiSettingRequest value)
		{
			SetBattleSetEmojiSettingRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<int> RoundEmojis { get; set; } = new List<int>();

	[MemoryPackOrder(1)]
	public List<int> FightEventEmojis { get; set; } = new List<int>();

	public static SetBattleSetEmojiSettingRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SetBattleSetEmojiSettingRequest)) as SetBattleSetEmojiSettingRequest;
		}
		return new SetBattleSetEmojiSettingRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			RoundEmojis.Clear();
			FightEventEmojis.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SetBattleSetEmojiSettingRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SetBattleSetEmojiSettingRequest>())
		{
			MemoryPackFormatterProvider.Register(new SetBattleSetEmojiSettingRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SetBattleSetEmojiSettingRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SetBattleSetEmojiSettingRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SetBattleSetEmojiSettingRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		writer.WriteValue<List<int>>(value.RoundEmojis);
		writer.WriteValue<List<int>>(value.FightEventEmojis);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SetBattleSetEmojiSettingRequest? value)
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
		long value6;
		int value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoundEmojis;
				value4 = value.FightEventEmojis;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0182;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<int>>();
			value4 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, long, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SetBattleSetEmojiSettingRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoundEmojis;
				value4 = value.FightEventEmojis;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
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
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
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
				goto IL_0182;
			}
		}
		value = new SetBattleSetEmojiSettingRequest
		{
			IsFromPool = value2,
			RoundEmojis = value3,
			FightEventEmojis = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_0182:
		value.IsFromPool = value2;
		value.RoundEmojis = value3;
		value.FightEventEmojis = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
