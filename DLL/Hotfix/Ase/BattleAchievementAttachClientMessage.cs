using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10581)]
[MemoryPackable(GenerateType.Object)]
public class BattleAchievementAttachClientMessage : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<BattleAchievementAttachClientMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleAchievementAttachClientMessageFormatter : MemoryPackFormatter<BattleAchievementAttachClientMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleAchievementAttachClientMessage value)
		{
			BattleAchievementAttachClientMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleAchievementAttachClientMessage value)
		{
			BattleAchievementAttachClientMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbBattleAchievementAttachInfo> AttachInfos { get; set; } = new List<PbBattleAchievementAttachInfo>();

	public static BattleAchievementAttachClientMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleAchievementAttachClientMessage)) as BattleAchievementAttachClientMessage;
		}
		return new BattleAchievementAttachClientMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			ActorId = 0L;
			UserId = 0L;
			AttachInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleAchievementAttachClientMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleAchievementAttachClientMessage>())
		{
			MemoryPackFormatterProvider.Register(new BattleAchievementAttachClientMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleAchievementAttachClientMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleAchievementAttachClientMessage>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBattleAchievementAttachInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBattleAchievementAttachInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleAchievementAttachClientMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(6, value.IsFromPool, value.UserId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBattleAchievementAttachInfo>>(value.AttachInfos));
		writer.WriteUnmanaged<int, long, long>(value.LoginServerId, value.LoginSecretKey, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleAchievementAttachClientMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbBattleAchievementAttachInfo> value4;
		int value5;
		long value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.AttachInfos;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0153;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbBattleAchievementAttachInfo>(ref reader);
			reader.ReadUnmanaged<int, long, long>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleAchievementAttachClientMessage), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.AttachInfos;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0153;
			}
		}
		value = new BattleAchievementAttachClientMessage
		{
			IsFromPool = value2,
			UserId = value3,
			AttachInfos = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			ActorId = value7
		};
		return;
		IL_0153:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.AttachInfos = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.ActorId = value7;
	}
}
