using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10833)]
[MemoryPackable(GenerateType.Object)]
public class GetMailListNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<GetMailListNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetMailListNotifyFormatter : MemoryPackFormatter<GetMailListNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetMailListNotify value)
		{
			GetMailListNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetMailListNotify value)
		{
			GetMailListNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbMailData> Mails { get; set; } = new List<PbMailData>();

	public static GetMailListNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetMailListNotify)) as GetMailListNotify;
		}
		return new GetMailListNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			Mails.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetMailListNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetMailListNotify>())
		{
			MemoryPackFormatterProvider.Register(new GetMailListNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetMailListNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetMailListNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMailData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMailData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetMailListNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(3, value.IsFromPool, value.ActorId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMailData>>(value.Mails));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetMailListNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbMailData> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ActorId;
				value4 = value.Mails;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				goto IL_00c4;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbMailData>(ref reader);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetMailListNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ActorId;
				value4 = value.Mails;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c4;
			}
		}
		value = new GetMailListNotify
		{
			IsFromPool = value2,
			ActorId = value3,
			Mails = value4
		};
		return;
		IL_00c4:
		value.IsFromPool = value2;
		value.ActorId = value3;
		value.Mails = value4;
	}
}
