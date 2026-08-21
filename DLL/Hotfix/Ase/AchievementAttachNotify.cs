using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10579)]
[MemoryPackable(GenerateType.Object)]
public class AchievementAttachNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<AchievementAttachNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class AchievementAttachNotifyFormatter : MemoryPackFormatter<AchievementAttachNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref AchievementAttachNotify value)
		{
			AchievementAttachNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref AchievementAttachNotify value)
		{
			AchievementAttachNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public PbAchievementInfo Info { get; set; }

	public static AchievementAttachNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(AchievementAttachNotify)) as AchievementAttachNotify;
		}
		return new AchievementAttachNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			Info = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static AchievementAttachNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<AchievementAttachNotify>())
		{
			MemoryPackFormatterProvider.Register(new AchievementAttachNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<AchievementAttachNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<AchievementAttachNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref AchievementAttachNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		writer.WritePackable<PbAchievementInfo>(value.Info);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref AchievementAttachNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbAchievementInfo value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Info;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00ca;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbAchievementInfo>();
			reader.ReadUnmanaged<long>(out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(AchievementAttachNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Info;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00ca;
			}
		}
		value = new AchievementAttachNotify
		{
			IsFromPool = value2,
			Info = value3,
			ActorId = value4
		};
		return;
		IL_00ca:
		value.IsFromPool = value2;
		value.Info = value3;
		value.ActorId = value4;
	}
}
