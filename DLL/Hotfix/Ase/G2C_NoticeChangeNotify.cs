using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10317)]
[MemoryPackable(GenerateType.Object)]
public class G2C_NoticeChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<G2C_NoticeChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2C_NoticeChangeNotifyFormatter : MemoryPackFormatter<G2C_NoticeChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2C_NoticeChangeNotify value)
		{
			G2C_NoticeChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2C_NoticeChangeNotify value)
		{
			G2C_NoticeChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbNotice> PbNotices { get; set; } = new List<PbNotice>();

	public static G2C_NoticeChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2C_NoticeChangeNotify)) as G2C_NoticeChangeNotify;
		}
		return new G2C_NoticeChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			PbNotices.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2C_NoticeChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_NoticeChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new G2C_NoticeChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2C_NoticeChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2C_NoticeChangeNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNotice>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNotice>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2C_NoticeChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNotice>>(value.PbNotices));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2C_NoticeChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbNotice> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PbNotices;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbNotice>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2C_NoticeChangeNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PbNotices;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new G2C_NoticeChangeNotify
		{
			IsFromPool = value2,
			PbNotices = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.PbNotices = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
