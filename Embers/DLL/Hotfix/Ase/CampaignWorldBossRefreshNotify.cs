using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10935)]
[MemoryPackable(GenerateType.Object)]
public class CampaignWorldBossRefreshNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<CampaignWorldBossRefreshNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class CampaignWorldBossRefreshNotifyFormatter : MemoryPackFormatter<CampaignWorldBossRefreshNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref CampaignWorldBossRefreshNotify value)
		{
			CampaignWorldBossRefreshNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref CampaignWorldBossRefreshNotify value)
		{
			CampaignWorldBossRefreshNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int NotifyType { get; set; }

	public static CampaignWorldBossRefreshNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(CampaignWorldBossRefreshNotify)) as CampaignWorldBossRefreshNotify;
		}
		return new CampaignWorldBossRefreshNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			NotifyType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static CampaignWorldBossRefreshNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<CampaignWorldBossRefreshNotify>())
		{
			MemoryPackFormatterProvider.Register(new CampaignWorldBossRefreshNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<CampaignWorldBossRefreshNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<CampaignWorldBossRefreshNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref CampaignWorldBossRefreshNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.NotifyType, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref CampaignWorldBossRefreshNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.NotifyType;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(CampaignWorldBossRefreshNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.NotifyType;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new CampaignWorldBossRefreshNotify
		{
			IsFromPool = value2,
			NotifyType = value3,
			ActorId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.NotifyType = value3;
		value.ActorId = value4;
	}
}
